-------------------------------------------------------------------------------
-- 杂货铺 - 装备抽取 - 抽取结果展示节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-27 15:00:43
-------------------------------------------------------------------------------

---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
local DOTween = CS.DG.Tweening

--- from: Assets/BundleResources/Prefabs/OverseaStore/OverseaStoreEquipDrawResultCell.prefab
---@class GroceryEquipmentCallResultCell
---@field Env                           	GroceryEquipmentCallResultCell          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field UIFX_TrailLizi                	UnityEngine.RectTransform               @ UI动效-轨迹粒子
---@field UIFX_Ring3                    	UnityEngine.RectTransform               @ UI动效
---@field UIFX_LiuDong                  	UnityEngine.RectTransform               @ UI动效
---@field UIFX_Glow2                    	UnityEngine.RectTransform               @ UI动效
---@field UIFX_Glow                     	UnityEngine.RectTransform               @ UI动效
---@field UIFX_Dot                      	UnityEngine.RectTransform               @ UI动效
---@field UIFX_Ring2                    	UnityEngine.RectTransform               @ UI动效
---@field UIFX_Particle                 	UnityEngine.RectTransform               @ UI动效
---@field TipsArea                      	UnityEngine.RectTransform               @ 点击区域
---@field TextName                      	UnityEngine.RectTransform               @ 名字文本
---@field ImgTypeIcon                   	UnityEngine.RectTransform               @ 类型图标
---@field EquipTypeNode                 	UnityEngine.RectTransform               @ 类型节点
---@field ImgIconDissociate             	UnityEngine.RectTransform               @ 分解结果图标
---@field ImgIconNormalDestroy          	UnityEngine.RectTransform               @ 装备分解图标
---@field ImgIconNormal                 	UnityEngine.RectTransform               @ 装备图标
local GroceryEquipmentCallResultCell = Class('GroceryEquipmentCallResultCell')

local SHOW_RESULT_ANIM    = 'OverseaStoreEquipDrawResultDialog_IconGo'      -- 入场动画
local SHOW_DESTROY_ANIM   = 'OverseaStoreEquipDrawResultDialog_IconDestroy' -- 销毁动画
local EQUIPMENT_SHOW_TIME = 0.5 -- 装备展示时间
local DECOMPOSE_MOVE_TIME = 0.6 -- 分解移动时间
local DECOMPOSE_SHOW_TIME = 0.0 -- 分解展示时间

function GroceryEquipmentCallResultCell:__init()
end


function GroceryEquipmentCallResultCell:__delete()
end


function GroceryEquipmentCallResultCell:Awake()
    CfUtils.SetActive(self.ImgIconDissociate, false)
    SetButtonAction(self.TipsArea, Bind(self, self.OnClickTipsAreaHandler_))
end


function GroceryEquipmentCallResultCell:Start()
end


function GroceryEquipmentCallResultCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return table
function GroceryEquipmentCallResultCell:GetDisplayData()
    return self.displayData_
end
function GroceryEquipmentCallResultCell:SetDisplayData(displayData)
    self.displayData_ = checkTable(displayData)
    self:UpdateCellContentInfo_()
end


-------------------------------------------------
-- public

---@param targetNode UnityEngine.GameObject
---@param finishCb fun():void
function GroceryEquipmentCallResultCell:DoShowAnimation(targetNode, finishCb)
    local displayData = self:GetDisplayData()
    local decomposes  = checkTable(displayData.decompose)
    local isDecompose = #decomposes > 0

    CoStart(function()
        local resultAnimTime = CfUtils.GetAnimationTime(self.controller, SHOW_RESULT_ANIM)
        CfUtils.PlayAnimation(self.controller, SHOW_RESULT_ANIM)
        CoYield(resultAnimTime)

        if isDecompose then
            local destroyAnimTime = CfUtils.GetAnimationTime(self.controller, SHOW_DESTROY_ANIM)
            CfUtils.PlayAnimation(self.controller, SHOW_DESTROY_ANIM)
            
            CfUtils.SetActive(self.UIFX_TrailLizi, true)
            local targetPosition = targetNode.transform.position
            self.UIFX_TrailLizi.transform:DOMove(targetPosition, DECOMPOSE_MOVE_TIME):SetEase(DOTween.Ease.InOutQuad)
            CoYield(math.max(destroyAnimTime + DECOMPOSE_MOVE_TIME))

            CoYield(DECOMPOSE_SHOW_TIME)
        else
            CoYield(EQUIPMENT_SHOW_TIME)
        end

        if finishCb then
            finishCb()
        end
    end)
end


-------------------------------------------------
-- private

function GroceryEquipmentCallResultCell:UpdateCellContentInfo_()
    local displayData = self:GetDisplayData()
    
    -- update goods icon
    local goodsId  = checkInt(displayData.goodsId)
    local iconPath = goodsConfMgr:GetPhotoPathById(goodsId)
    CfUtils.FillImage(self.ImgIconNormalDestroy, iconPath)
    CfUtils.FillImage(self.ImgIconNormal, iconPath)
    
    -- update goods name
    local goodsVo = goodsConfMgr:GetGoodsVoById(goodsId)
    CfUtils.FillText(self.TextName, tostring(goodsVo.name))

    -- update type icon
    local goodsType = GoodsUtils.GetIdType(goodsId)
    if goodsType == Constants.IDType.Equipment then
        local typeIcon = EquipUtils.GetEquipmentSetIcon(goodsId)
        CfUtils.FillImage(self.ImgTypeIcon, typeIcon)
        CfUtils.SetActive(self.EquipTypeNode, true)
    else
        CfUtils.SetActive(self.EquipTypeNode, false)
    end
    
    -- update ui effect
    local goodsRare = checkInt(goodsVo.quality)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_Dot, goodsRare)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_Ring2, goodsRare)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_Ring3, goodsRare)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_Glow, goodsRare)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_Glow2, goodsRare)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_LiuDong, goodsRare)
    CfUtils.SetUISwitchParticleSystem(self.UIFX_Particle, goodsRare)
end


-------------------------------------------------
-- handler

function GroceryEquipmentCallResultCell:OnClickTipsAreaHandler_()
    local displayData = self:GetDisplayData()
    local goodsId     = checkInt(displayData.goodsId)
    local goodsVo     = goodsConfMgr:GetGoodsVoById(goodsId)
    GameUtils.ShowCommonTipsBoard(self.controller, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
end


return GroceryEquipmentCallResultCell
