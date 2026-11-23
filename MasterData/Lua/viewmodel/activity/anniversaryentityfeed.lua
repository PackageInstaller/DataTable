







local objs = {
    downTimeTxt = {path = "root/Middle/BG/DownTimeBG/DownTimeTxt", type = UITool.Text},
    inputGroupObj = {path = "root/Middle/BG/InputGroup", type = UITool.GameObject},
    inputAfterObj = {path = "root/Middle/BG/InputAfterGroup", type = UITool.GameObject},
    inputBtn = {path = "root/Middle/BG/InputInfoBtn", type = UITool.Button},
    cancelBtn = {path = "root/Middle/BG/InputGroup/CancelBtn", type = UITool.Button},
    confirmBtn = {path = "root/Middle/BG/InputGroup/ConfirmBtn", type = UITool.Button},
    recipientInputfield = {path = "root/Middle/BG/InputGroup/RecipientInputfield", type = UITool.InputField},
    telInputfield = {path = "root/Middle/BG/InputGroup/TelInputfield", type = UITool.InputField},
    addressInputfield = {path = "root/Middle/BG/InputGroup/AddressInputfield", type = UITool.InputField}
}

local this = {}

this.before_awake = function()
    SetActive(this.inputAfterObj, false)
    SetActive(this.inputAfterObj, false)
end

this.before_active = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.YearGift1)
    this.activityExpireTime = activityData.expireTime
    local isComplete = DataMgr.Player.AnniversaryRecharge2.Reward == true
    this.SetObjVisible(isComplete == false, isComplete, false)
end

this.OnTimer = function()
    local remainTime = this.activityExpireTime - LuaMgr.Timestamp()
    if remainTime < 0 then
        LuaMgr.RemoveTimer(TimerConst.AnniversaryDownTime)
        this.downTimeTxt.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15701")
        return
    end
    local d, h, m, s = GetTimeDHMS2(remainTime)
    local content = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15701")
    this.downTimeTxt.text = string.format(content, d, h, m, s)
end

this.OnClickInputBtn = function()
    SetActive(this.inputGroupObj, true)
end

this.OnClickCancelBtn = function()
    SetActive(this.inputGroupObj, false)
end

this.OnClickConfirmBtn = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.YearGift1) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return
    end
    if this.CheckPopupInfo() == false then
        return
    end
    local data = {}
    data.clickCallbacks = {}
    data.btnTextStrs = {}
    data.clickCallbacks[ConfirmCommonPanel.BtnType.Confirm] = this.ConfirmCallback
    data.btnTextStrs[ConfirmCommonPanel.BtnType.Confirm] = this.GetLang("TotalRechargePanel_UI_18")
    data.btnTextStrs[ConfirmCommonPanel.BtnType.Cancel] = this.GetLang("TotalRechargePanel_UI_17")
    data.contentStr = this.GetLang("TotalRechargePanel_UI_19")
    LuaMgr.ShowLuaPanel(UIName.ConfirmCommonPanel, ConfirmCommonPanel.MsgBoxType.TextButton, data)
end

this.ConfirmCallback = function()
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= 0 then
            return
        end
        this.recipientInputfield.text = ""
        this.telInputfield.text = ""
        this.addressInputfield.text = ""
        this.SetObjVisible(false, true, false)
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, this.GetLang("TotalRechargeViewModel_0"))
    end
    local data = {
        name = this.recipientInputfield.text,
        phone = this.telInputfield.text,
        address = this.addressInputfield.text
    }
    ApiMgr.Request("anniversaryrecharge/post", data, true, callback, nil, true)
end

this.SetObjVisible = function(inputBtnVis, inputAfterObjVis, inputGroupObjVis)
    SetActive(this.inputBtn.gameObject, inputBtnVis)
    SetActive(this.inputAfterObj, inputAfterObjVis)
    SetActive(this.inputGroupObj, inputGroupObjVis)
end

this.CheckPopupInfo = function()
    local tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7002"].NameLan)
    if IsNullOrEmpty(this.recipientInputfield.text) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil)
        return false
    end

    tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7004"].NameLan)
    if IsNullOrEmpty(this.telInputfield.text) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil)
        return false
    else
        local phoneStr = string.match(this.telInputfield.text, "[1][3-9]%d%d%d%d%d%d%d%d%d")
        if phoneStr == nil or phoneStr ~= this.telInputfield.text then
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil)
            return false
        end
    end
    tips = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7001"].NameLan)
    if IsNullOrEmpty(this.addressInputfield.text) then
        LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel, string.sub(tips, 2), nil, nil)
        return false
    end
    return true
end

this.GetLang = function(nameLan)
    return CS.Laigu.Manager.LangManager.Singleton:GetData(nameLan)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.inputBtn, this.OnClickInputBtn)
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancelBtn)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirmBtn)
        HeroRedDataHelper.SetAnniversaryEntityFeedRed(true)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.before_active()
        LuaMgr.AddTimer(TimerConst.AnniversaryDownTime, this.OnTimer, 1, -1, true)
        HeroRedDataHelper.SetAnniversaryEntityFeedRed()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.RemoveTimer(TimerConst.AnniversaryDownTime)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.inputBtn, this.OnClickInputBtn)
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancelBtn)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirmBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)