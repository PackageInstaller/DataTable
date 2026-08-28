
---@type ActivityGachaponSkinMgr
local ActivityGachaponSkinMgr = import("Game.Activity.GachaponSkin.ActivityGachaponSkinMgr"):GetInstance()

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinTaskDialog.prefab > name: Cell
---@class GachaponSkinPropTaskCell
---@field Env                           	GachaponSkinPropTaskCell                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Underway                      	UnityEngine.RectTransform               	@ 0    
---@field FinishGroup                   	UnityEngine.RectTransform               	@ 1    
---@field BtnDrawReward                 	UnityEngine.RectTransform               	@ 2    
---@field ImgCanFrame2                  	UnityEngine.RectTransform               	@ 3    
---@field ImgCanFrame1                  	UnityEngine.RectTransform               	@ 4    
---@field ImgProgress                   	UnityEngine.RectTransform               	@ 5    
---@field ProgressBar                   	UnityEngine.RectTransform               	@ 6    
---@field TextProgress                  	UnityEngine.RectTransform               	@ 7    
---@field TextDescribe                  	UnityEngine.RectTransform               	@ 8    
---@field CommonGoodsList               	UnityEngine.RectTransform               	@ 9    
---@field UIFX_ActivityCompletion       	UnityEngine.RectTransform               	@ 10   
local GachaponSkinPropTaskCell = Class("GachaponSkinPropTaskCell")

---@class GachaponSkinPropTaskCell.InputData
---@field desc string
---@field progress number
---@field target number
---@field rewardList Reward[]
---@field status number  0初始 1可领取 2已领取
---@field openType number  跳转id
---@field openParameter string  跳转参数
---@field taskId number 任务ID

function GachaponSkinPropTaskCell:__init()
    self.controller = nil
    ---@type GachaponSkinPropTaskCell.InputData
    self.data = {}
end

function GachaponSkinPropTaskCell:__delete()
    self.controller = nil
end

function GachaponSkinPropTaskCell:Awake()
    SetButtonAction(self.BtnDrawReward, Bind(self, self.OnClickDrawButton))
end

---@param data GachaponSkinPropTaskCell.InputData
function GachaponSkinPropTaskCell:RefreshData(data, onClickCallBack)
    self.data = data
    self.onClickCallBack = onClickCallBack
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function GachaponSkinPropTaskCell:RefreshUI()
    ---@type CommonGoodsListLight
    local goodsLua = CfUtils.GetLuaScr(self.CommonGoodsList, "Game.Behaviours.CommonGoodsListLight")
    if goodsLua then
        goodsLua:FreshBaseUI(self.data.rewardList)
    end
    
    CfUtils.FillText(self.TextDescribe, self.data.desc)
    CfUtils.FillText(self.TextProgress, string.format("<size=30><color=#545454>%s</color></size>/%s", self.data.progress, self.data.target))
    self.ProgressBar.value = checkNumber(self.data.progress) / checkNumber(self.data.target)
    
    local canGet = self.data.status == Constants.GetStatus.Can
    local canJump = checkNumber(self.data.openType) > 0
    CfUtils.SetUISwitchImage(self.ImgProgress, canGet and 2 or 1)
    CfUtils.SetUISwitchImage(self.ImgCanFrame1, canGet and 2 or 1)
    CfUtils.SetUISwitchImage(self.ImgCanFrame2, canGet and 2 or 1)

    CfUtils.SetActive(self.BtnDrawReward, canGet or canJump)
    if canGet then
        CfUtils.SetButtonStyle(self.BtnDrawReward, "B12", localize("领取"))
    elseif canJump then
        CfUtils.SetButtonStyle(self.BtnDrawReward, "B13", localize("前往"))
    end

    CfUtils.SetActive(self.Underway, not canJump and self.data.status == Constants.GetStatus.Not)
    CfUtils.SetActive(self.FinishGroup, self.data.status == Constants.GetStatus.Has)
    CfUtils.SetActive(self.UIFX_ActivityCompletion, canGet)
end

function GachaponSkinPropTaskCell:OnClickDrawButton()
    local canJump = checkNumber(self.data.openType) > 0
    if self.data.status == Constants.GetStatus.Can then --领取
        if self.onClickCallBack then
            self.onClickCallBack(self.data.taskId)
        end
    elseif self.data.status == Constants.GetStatus.Not and canJump then --跳转
        local goodsConfMgr = GoodsConfMgr:GetInstance() 
        local row = goodsConfMgr:GetJumpModuleRow(self.data.openType)
        local t = checkTable(CfUtils.Split(self.data.openParameter))
        goodsConfMgr:ExecuteJump(row, nil,nil,nil,t)
    end
end

return GachaponSkinPropTaskCell