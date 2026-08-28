
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait

--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/Homeland/HomelandTalentEntryDialog.prefab > name: HomelandTalentEntryDialog
---@class HomelandTalentEntryDialog
---@field Env                           	HomelandTalentEntryDialog               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Root                          	UnityEngine.Animation                   
---@field BtnTalentGroup                	UnityEngine.RectTransform               
---@field BtnProfileGroup               	UnityEngine.RectTransform               
local HomelandTalentEntryDialog = Class('HomelandTalentEntryDialog')


function HomelandTalentEntryDialog:__init()
end


function HomelandTalentEntryDialog:__delete()
    self.controller = nil
end


-- function HomelandTalentEntryDialog:Awake()
-- end


-- function HomelandTalentEntryDialog:OnFocus(focus)

-- end


function HomelandTalentEntryDialog:OnInitialize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:OnInit()
    end))
    return coWait
end


-- function HomelandTalentEntryDialog:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

--     end))
--     return coWait
-- end


function HomelandTalentEntryDialog:OnFinalize()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
        self = nil
    end))
    return coWait
end


--region init 

function HomelandTalentEntryDialog:OnInit()
    self:InitData()
    self:InitBtnGroups()
    self:BindRedPoints()
end

function HomelandTalentEntryDialog:InitData()
    self._config = {
        ---      系统功能表id                    按钮                        进入配置界面入场动画
        { Constants.SystemToggleIds.Id6002, self.BtnTalentGroup, "HomelandTalentEntryDialog_ToTalent", Constants.UITypeIds.HomelandTalentDisplayDialog, Constants.RedPointConst.HomelandTalent}, --- 天赋界面
        { Constants.SystemToggleIds.Id6003, self.BtnProfileGroup, "HomelandTalentEntryDialog_ToProfile", Constants.UITypeIds.HomelandCheckInEntryDialog}, --- 信息界面
    }
end

function HomelandTalentEntryDialog:InitBtnGroups()
    local CfUtils = CfUtils
    for index, config in ipairs(self._config) do
        local toggleId, btn, aniName, uiTypeId, redPointConstant = SafeUnpack(config)
        if not GameUtils.IsSwitchedBySystemTogId(toggleId) then
            CfUtils.SetActive(btn, false)
        else
            local isUnlock = GameUtils.IsUnlockedBySystemTogId(toggleId)
            local Img  = btn:Find("img")
            CfUtils.SetActive(Img, isUnlock)
            
            local Lock = btn:Find("Lock")
            CfUtils.SetActive(Lock, not isUnlock)
            
            SetButtonAction(btn, Bind(self, self.OnClickBtnAction, isUnlock, aniName, uiTypeId))
        end

        if redPointConstant then
            GameUtils.BindRedPoint(redPointConstant, btn, true)
        end
    end
end

function HomelandTalentEntryDialog:BindRedPoints()
    -- 绑定小红点
    GameUtils.BindRedPoint(Constants.RedPointConst.HomelandCheckIn, self.BtnProfileGroup, true)
end

--endregion 


--region logic 



--endregion 


--region get/set 


---endregion 


--region handler 

function HomelandTalentEntryDialog:OnClickBtnAction(isUnlock, aniName, uiTypeId)
    if not isUnlock then
        return
    end

    if uiTypeId == nil then
        return
    end

    if self._isPlaying then
        return
    end

    self._isPlaying = true
    self.Root:Play(aniName)
    CoStart(function() 
        local CoYield = CoYield
        CoYield(.15)
        CfUtils.DialogOpen(uiTypeId, nil, UICommonUtils.GetShowDialogArguments())
    end)

end

---endregion 


return HomelandTalentEntryDialog
