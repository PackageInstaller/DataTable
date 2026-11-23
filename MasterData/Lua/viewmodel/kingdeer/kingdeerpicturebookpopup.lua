







require("ViewModel/KingDeer/KingDeerPictureBookBtnItem")
local totalPictureCount = 5
local objs = {
    getReward = {path = "root/Middle/ProgressBG/GetRewardBtn", type = UITool.Button},
    getRewardAnim = {path = "root/Middle/ProgressBG/GetRewardBtn", type = UITool.Animator},
    progressImg = {path = "root/Middle/ProgressBG/ProgressSlider", type = UITool.Image},
    progressTxt = {path = "root/Middle/ProgressBG/ProgressText", type = UITool.Text}
}

local this = {
    pictureBookObjs = {},
    drawBtns = {},

    drawBtnDatas = {},
    allComplete = false
}
local animName = "ani_KingDeerPictureBookPopup_PictureBookParent_01"
this.before_awake = function()
    this.SetDrawBtnData(true)
end

this.before_active = function()
    this.isClickLimit = false
    this.SetDrawBtnData(false)
end

this.SetDrawBtnData = function(isInit)
    this.pictureBookDatas = KingDeerData.GetPictureBookDatas()

    if totalPictureCount ~= #this.pictureBookDatas then
        LuaDebug.error("KingDeerPictureBookPopup SetDrawBtnData Num isn't equal")
        return
    end
    for i = 1, totalPictureCount do
        local item = this.drawBtns[i]
        if isInit == true then
            table.insert(this.drawBtnDatas, KingDeerPictureBookBtnItem.New(item, i, this.OnDrawPicture))
        end
        local drawBtnData = this.drawBtnDatas[i]
        drawBtnData:SetData(this.pictureBookDatas[i])
        this.OnDrawPicture(i, this.pictureBookDatas[i], true)
    end
    this.SetQuestProgress()
end

this.OnGetReward = function()
    local progressData = KingDeerData.GetTotalProgress()
    if progressData.questData.progress < progressData.config.progress then
        local tipsContent = LuaMgr.GetLangText(progressData.config.remarksLan)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local playNovelCallback = function()
        if KingDeerData.GetNovelIsLook(KingDeerData.GetNovelID(6)) == false then
            DataExHelper.EX_GetAward(progressData.questData.id, nil)
        end
        LuaMgr.ShowLuaPanel(UIName.KingDeerPictureBookPopup)
        KingDeerData.CheckRedDot(true)
    end
    LuaMgr.PlayNovel(KingDeerData.GetNovelID(6), playNovelCallback)
end


this.OnDrawPicture = function(index, data, isInit)
    if this.isClickLimit == true then
        return
    end
    if isInit ~= true then
        this.isClickLimit = true
    else
        this.isClickLimit = false
    end
    if data == nil then
        local pictureBookDatas = KingDeerData.GetPictureBookDatas()
        if index > #pictureBookDatas then
            return
        end
        data = pictureBookDatas[index]
    end
    this.index = index
    this.data = data
    if index > #this.pictureBookObjs then
        LuaDebug.error("KingDeerPictureBookPopup OnDrawPicture index is valid:" .. index)
        return
    end
    if data.status == KingDeerData.PictureBookStatus.CanActive then
        if isInit ~= true then
            this.pictureBookObjs[index]:Play(animName)
            LuaMgr.AddTimer(TimerConst.KingDeerDrawPictureEnd, this.OnDrawPictureEnd, 1, 1, false)
        end
    elseif data.status == KingDeerData.PictureBookStatus.Actived then
        this.pictureBookObjs[index]:Play(animName)
    end
end

this.OnDrawPictureEnd = function()
    local index = this.index
    local data = this.data
    local callback = function()
        local drawBtnData = this.drawBtnDatas[index]
        data.status = KingDeerData.PictureBookStatus.Actived
        drawBtnData:SetData(data)
        this.SetQuestProgress()
        this.isClickLimit = false
    end
    DataExHelper.EX_ShopConvert(data.config.id, data.config.cost[1].count, callback)
end

this.SetQuestProgress = function()
    local progressData = KingDeerData.GetTotalProgress()
    local progress = 0
    if progressData.questData ~= nil and progressData.questData.progress ~= nil then
        progress = progressData.questData.progress / progressData.config.progress
    end
    this.progressImg.fillAmount = progress
    local txt = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7303")
    local tempTxt = "%.0f%%"
    txt = string.format(txt, tempTxt)
    this.progressTxt.text = string.format(txt, progress * 100)
    if progressData.questData ~= nil and progressData.questData.progress < progressData.config.progress or KingDeerData.GetNovelIsLook(KingDeerData.GetNovelID(6)) == true then
        this.getRewardAnim.enabled = false
    else
        this.getRewardAnim.enabled = true
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, totalPictureCount do
            local tempData = {}
            tempData.path = "root/Middle/PictureBookParent/PictureBook" .. i
            tempData.type = UITool.Animator
            objs["pictureBook" .. i] = tempData

            tempData = {}
            tempData.path = "root/Middle/DrawGroup/Button" .. i
            tempData.type = UITool.Button
            objs["activateBtn" .. i] = tempData
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        for i = 1, totalPictureCount do
            this.pictureBookObjs[i] = this["pictureBook" .. i]
            this.drawBtns[i] = this["activateBtn" .. i]
        end
        LuaMgr.AddClick(this.getReward, this.OnGetReward)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.getReward, this.OnGetReward)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)