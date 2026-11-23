require("ViewModel/SongShiYouXin/ViewItem/SSYXNovelItem")
local objs = {
    novelItem = {path = "template/NovelItem", type = UITool.GameObject},
    scrollView = {path = "root/Middle/Group/ScrollView", type = UITool.GameObject},
    videoImg = {path = "root/Middle/Group/Video", type = UITool.Button},
    chapterNum = {path = "root/Middle/Group/ChapaterNum", type = UITool.Text},
    name = {path = "root/Middle/Group/Name", type = UITool.Text},
    novelOperateBtn = {path = "root/Middle/Group/NovelOperateBtn", type = UITool.Button},
    operateName = {path = "root/Middle/Group/NovelOperateBtn/OperateName", type = UITool.Text}
}

local this = {

    lastSelectItem = nil,
    lastSelectData = nil
}

this.before_awake = function()
    this.novelListUI = UIScrollView.New(this.scrollView)
end

this.before_active = function()
    this.novelListUI:Clear(false)
    local scrollDatas = {}
    local novelDatas = SSYXData.GetAllNovelDatas()
    local novelIndex=this.GetNovelUnlockIndex(novelDatas);
    local len = #novelDatas
    this.lastSelectIndex = 0
    for i = 1, len do
        local data = novelDatas[i]
        data.Index = i
        data.OnClickCallback = this.OnSelectedItem
        if this.lastSelectData == nil and i==novelIndex then
            data.IsSelected = true
            this.lastSelectData = data
            this.lastSelectIndex = i
        end

        local scrollData = UIScrollData.GetData(this.novelItem, "SSYXNovelItem", 320, 190, data)
        table.insert(scrollDatas, scrollData)
    end
    this.novelListUI:SetParams(1068, 195)
    this.novelListUI:SetPadding(15, 0, 5, 0)
    this.novelListUI:SetData(scrollDatas, false)
    this.RefreshSelectItemInfo()
end

this.GetNovelUnlockIndex=function(novelDatas)
    local index=1;
    for i,v in ipairs(novelDatas) do
        if v.Status == CommonRewardItem.Status.None then
            index=i;
            break;
        end
    end
    return index;
end

this.RefreshSelectItemInfo = function()
    this.name.text = this.lastSelectData.Name
    this.chapterNum.text = string.format("%02d", this.lastSelectData.Index)
    if this.lastSelectData.Status == CommonRewardItem.Status.Got then
        this.operateName.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText11)
    else
        this.operateName.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText10)
    end
end



this.OnSelectedItem = function(item)
    if this.lastSelectItem ~= nil then
        this.lastSelectItem:SetSelected(false)
    end
    this.lastSelectItem = item
    this.lastSelectItem:SetSelected(true)
    this.lastSelectData = this.lastSelectItem.data
    this.RefreshSelectItemInfo()
end

this.OnClickNovelOperateBtn = function()
    if this.lastSelectData.Status == CommonRewardItem.Status.Lock then
        return
    end
    local playNovelCallback = function()
        LuaMgr.ShowLuaPanel(UIName.SSYXOutNovelPanel)
    end
    LuaMgr.PlayNovel(this.lastSelectData.eventParam, playNovelCallback)
    LuaMgr.HidePanel(UIName.SSYXOutNovelPanel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.novelOperateBtn, this.OnClickNovelOperateBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.novelOperateBtn, this.OnClickNovelOperateBtn)
        UIScrollView.ClearItem("SSYXNovelItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)