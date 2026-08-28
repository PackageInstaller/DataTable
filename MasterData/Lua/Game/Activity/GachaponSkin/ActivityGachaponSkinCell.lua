
--region global define
local isNull    = isNull
local isNotNull = isNotNull
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine'
local Yielders = CS.Engine.Lib.Yielders
--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinEntry.prefab > name: Cell
---@class ActivityGachaponSkinCell
---@field Env                           	ActivityGachaponSkinCell                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field redPoint                      	UnityEngine.RectTransform               
---@field ImgSkinCard                   	Engine.UI.RawImageAlterable             
---@field TxtName                       	CustomText                              
---@field Text                          	UnityEngine.UI.Text                     
---@field ImgSelectFrame                	UnityEngine.RectTransform               
---@field ImgOwned                      	UnityEngine.RectTransform               
---@field ImgSkin                       	UnityEngine.RectTransform               
---@field BtnNode                       	UnityEngine.RectTransform               
local ActivityGachaponSkinCell = Class('ActivityGachaponSkinCell')
function ActivityGachaponSkinCell:__init()
    self.isAnimated = false
    self.data = nil
    self.index = nil 
    self.co = nil
end


function ActivityGachaponSkinCell:__delete()
    self.isAnimated = nil
    self.data = nil
    self.index = nil 
    if self.co  then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
end


function ActivityGachaponSkinCell:Awake()
    SetButtonAction(self.BtnNode.gameObject, function()
        if isNotNull(self.data) then
            ---@type Engine.UI.UILuaDialog
            local luaDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.ActivityGachaponSkinDialog)
            ---@type ActivityGachaponSkinDialog
            local Env = luaDialog.Env
            Env:SwitchActivityNodeByIndex(self.index)
        end
    end)
end

function ActivityGachaponSkinCell:Refresh(data , index)
    self.data = data 
    self.index = index 
    ---@type CardSkinVo
    if checkInt( data.skinId) > 0 then
        local cardSkinVo = CfUtils.GetCfVo(AutoIds.IdSetting113 , "CardSkinVo" , data.skinId)
        local name = cardSkinVo.name 
        self.TxtName.text = name
        ---@type CardSkinComponent
        local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
        local isHaveSkinId = cardSkinComponent:IsHasSkin(data.skinId)
        KTool.SetActive(self.ImgOwned.gameObject , isHaveSkinId)
    else 
        self.TxtName.text = data.scheduleName
    end
    if isNotNull(data.skinIcon) and string.len(data.skinIcon) > 0  then
        CfUtils.FillImage(self.ImgSkinCard ,CfUtils.GetImageFullPath(data.skinIcon))    
    end
    KTool.SetActive(self.redPoint.gameObject ,  data.redDotHint  == 0)
    KTool.SetActive(self.ImgSkin.gameObject , true)
    self:GachaponSkinEntryCellShow()
end

function ActivityGachaponSkinCell:SetIsSelect(isSelect)
    -- KTool.SetActive(self.ImgSelectFrame.gameObject ,isSelect)
    if isSelect then
        CfUtils.PlayAnimation(self.Root.gameObject , "GachaponSkinEntry_Cell_Select")
    end
end

function ActivityGachaponSkinCell:UpdateTimeText()
    local currentTime = os.time()
    local endTime = self.data.endTime 
    local leftTime = endTime - currentTime 
    CfUtils.FillText(self.Text.gameObject ,CfUtils.GetTimeHMS(leftTime)) 
end
function ActivityGachaponSkinCell:Start()

end

function ActivityGachaponSkinCell:GachaponSkinEntryCellShow()
    if self.isAnimated then
        CfUtils.PlayAnimation(self.Root.gameObject , "GachaponSkinEntry_Cell_Idle")
        return
    end
    self.isAnimated = true
    if self.co  then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    self.co = cs_coroutine.start(function ()
        ---@type UnityEngine.Animation
        local animation = self.controller.transform:GetComponent(typeof(CS.UnityEngine.Animation))
        animation:PlayQueued('UI_Common_List_Cell_Hide', CS.UnityEngine.QueueMode.CompleteOthers)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds((self.index-1) * 0.15))
        animation:PlayQueued('UI_Common_List_Cell_Wait_3', CS.UnityEngine.QueueMode.CompleteOthers)
        animation:PlayQueued('GachaponSkinEntry_Cell_Show', CS.UnityEngine.QueueMode.CompleteOthers)
    end)
 
end


function ActivityGachaponSkinCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end
return ActivityGachaponSkinCell
