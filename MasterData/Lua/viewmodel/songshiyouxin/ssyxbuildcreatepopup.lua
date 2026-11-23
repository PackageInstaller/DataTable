local objs = {
    buildIcon = {path = "root/Middle/BuildIcon", type = UITool.Image},
    maskCloseBtn = {path = "root/Mask", type = UITool.Button},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    createBtn = {path = "root/Middle/CreateBtn", type = UITool.Button},
    createBtnBuyObj = {path = "root/Middle/CreateBtn/BuyObj", type = UITool.GameObject},
    needCount = {path = "root/Middle/CreateBtn/BuyObj/NeedCount", type = UITool.Text},
    createBtnCreateObj = {path = "root/Middle/CreateBtn/CreateObj", type = UITool.GameObject},
    desc = {path = "root/Middle/Desc", type = UITool.Text},
    buildNum = {path = "root/Middle/BuildNum", type = UITool.Text},
    buildName = {path = "root/Middle/BuildName", type = UITool.Text}
}

local this = {

    commonItemCountIcon = nil
}

this.before_awake = function()
    this.commonItemCountIcon = CommonItemCountIcon.New(this.needCount)
end

this.before_active = function()
    this.RefreshUI()
end

this.RefreshUI = function()
    local spriteName = string.format("%d_Light", this.buildData.ID)
    this.buildIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, spriteName)
    this.buildName.text = LuaMgr.GetLangText(this.buildData.Config.NameLan)
    this.desc.text = LuaMgr.GetLangText(this.buildData.Config.DescriptionLan)
    this.buildNum.text = "0/1"

    SetActive(this.createBtnBuyObj, false)
    SetActive(this.createBtnCreateObj, false)
    if type(this.buildData.Config.Consume) == "table" then
        SetActive(this.createBtnBuyObj, true)
        local data = this.buildData.Config.Consume[1]
        this.commonItemCountIcon:SetData(data)
    else
        SetActive(this.createBtnCreateObj, true)
    end
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.SSYXBuildCreatePopup)
end
this.OnClickCreateBtn = function()
    this.OnClickCloseBtn()
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("OnClickCreateBtn 请求错误:" .. res.code)
            return
        end
        this.OnCreateBuildComplete()
    end
    local data = {}
    data.BuildId = this.buildData.ID
    ApiMgr.Request("operateBuild/make", data, true, onSucc, nil, true)
end

this.OnCreateBuildComplete = function()
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("OnClickCreateBtn 请求错误:" .. res.code)
            return
        end
        SSYXData.RefreshBuildDataByID(this.buildData.ID)
        LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXCreateBuildNotify, this.buildData)
    end
    local data = {}
    data.BuildId = this.buildData.ID
    ApiMgr.Request("operateBuild/makeFinish", data, true, onSucc, nil, true)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.maskCloseBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.createBtn, this.OnClickCreateBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length <= 0 then
            return
        end
        this.buildData = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskCloseBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.createBtn, this.OnClickCreateBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)