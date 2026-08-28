-------------------------------------------------------------------------------
-- 通用奖励弹窗2 装备分解版
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-03-25 16:02:16
-------------------------------------------------------------------------------

---@type GoodsConfMgr
local goodsConfMgr = GoodsConfMgr:GetInstance()
---@type GroceryConstants
local GroceryConstants = import('Game.Grocery.GroceryConstants')
---@type CommonRewardPopWinDialog
local CommonRewardPopWinDialog = import('Game.UI.Common.CommonRewardPopWinDialog')
local UIEffectCapturedImage = CS.UGUI.Effects.UIEffectCapturedImage

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Common/CommonRewardPopWinDialog2.prefab
---@class CommonRewardPopWinDialog2
---@field Env                           	CommonRewardPopWinDialog2               
---@field controller                    	Engine.UI.UILuaDialog                   
---@field ContinueStopTextRemind        	UnityEngine.RectTransform               @ 继续停止提示
---@field ContinueDisplayCostText2      	UnityEngine.RectTransform               @ 继续消耗数量2
---@field ContinueDisplayCostIcon2      	UnityEngine.RectTransform               @ 继续消耗图标2
---@field ContinueDisplayCostText1      	UnityEngine.RectTransform               @ 继续消耗数量1
---@field ContinueDisplayCostIcon1      	UnityEngine.RectTransform               @ 继续消耗图标1
---@field ContinueDisplayCostNode       	UnityEngine.RectTransform               @ 继续消耗节点
---@field ContinueDisplayNumText        	UnityEngine.RectTransform               @ 继续次数文本
---@field ContinueDisplayNumNode        	UnityEngine.RectTransform               @ 继续次数节点
---@field ContinueDisplayNode           	UnityEngine.RectTransform               @ 继续信息根节点
---@field EquipDissociateDetailsGoodsList	UnityEngine.RectTransform               @ 分解道具列表
---@field EquipDissociateDetailsNode      	UnityEngine.RectTransform               @ 分解内容节点
---@field EquipDissociateNode           	UnityEngine.RectTransform               @ 分解信息根节点
---@field GridView                      	SuperScrollView.LoopGridView            @ >多奖励容器
---@field RewardNode                    	UnityEngine.RectTransform               @ >奖励节点
---@field GoodFatherRoot                	UnityEngine.RectTransform               @ >少奖励容器
---@field CloseBtn                      	UnityEngine.RectTransform               @ >关闭区域
local UICommonRewardPop2 = Class('UICommonRewardPop2', CommonRewardPopWinDialog)


function UICommonRewardPop2:__init()
    CommonRewardPopWinDialog.__init(self)
    ---@type CommonGoodsList
    self.dissociateGoodsList_ = nil
    self.goodsMaxNum = 8
end


function UICommonRewardPop2:__delete()
    self.dissociateGoodsList_ = nil
    CommonRewardPopWinDialog.__delete(self)
end


function UICommonRewardPop2:Awake()
    CommonRewardPopWinDialog.Awake(self)
    self.dissociateGoodsList_ = CfUtils.GetLuaScr(self.EquipDissociateDetailsGoodsList, Constants.UILuaTablePath.ComGoodsList)
end


function UICommonRewardPop2:DoInitialize()
    CommonRewardPopWinDialog.DoInitialize(self)

    local initParams = self.controller.Argument.parameters or {}
    self:SetDecomposesList(initParams.decomposes)
    self:SetConsumeList(initParams.consumes)
    self:SetContinueNum(initParams.continueNum)
    self:SetPackFulled(initParams.isFulled)

    local isDecomposeMode = checkBool(initParams.isDecompose)
    CfUtils.SetActive(self.EquipDissociateNode, isDecomposeMode)

    ---@type UGUI.Effects.UIEffectCapturedImage
    local effectBg = self.controller.gameObject:GetComponent(typeof(UIEffectCapturedImage))
    effectBg.enabled = initParams.isOnCapture ~= false

    if checkNumber(initParams.type) == 1 then
        self:FillRegionLevelUp()
    else
        CfUtils.FillText(self.ContinueStopTextRemind, localize("仓库已满，抽卡中断"))
    end
end

function UICommonRewardPop2:FillRegionLevelUp()
    CfUtils.SetActive(self.ContinueStopTextRemind, true)
    CfUtils.FillText(self.ContinueStopTextRemind, localize("区域升级奖励"))
end

function UICommonRewardPop2:DoFinalize()
    CommonRewardPopWinDialog.DoFinalize(self)
end


function UICommonRewardPop2:DoShow()
    CommonRewardPopWinDialog.DoShow(self)
    CfUtils.SetActive(self.GoodFatherRoot, true)
end


function UICommonRewardPop2:PlayShowSound()
    GameUtils.GetCriWareUtils().PlaySeById(GroceryConstants.CallEquipAnimSoundDefine.REWARD_SHOW)
end


function UICommonRewardPop2:PlayShowFewGoodsCellSound(index)
    GameUtils.GetCriWareUtils().PlaySeById(GroceryConstants.CallEquipAnimSoundDefine.REWARD_ITEM)
end


-------------------------------------------------
-- get / set

---@return integer
function UICommonRewardPop2:GetContinueNum()
    return checkInt(self.continueNum_)
end
function UICommonRewardPop2:SetContinueNum(continueNum)
    self.continueNum_ = checkInt(continueNum)
    self:UpdateContinueNum_()
end


---@return boolean
function UICommonRewardPop2:IsPackFulled()
    return checkBool(self.isPackFulled_)
end
function UICommonRewardPop2:SetPackFulled(isPackFulled)
    self.isPackFulled_ = checkBool(isPackFulled)
    self:UpdateFulledState_()
end


---@return table[]
function UICommonRewardPop2:GetConsumeList()
    return checkTable(self.consumeList_)
end
function UICommonRewardPop2:SetConsumeList(consumeList)
    self.consumeList_ = checkTable(consumeList)
    self:UpdateConsumeInfo_()
end


---@return table[]
function UICommonRewardPop2:GetDecomposesList()
    return checkTable(self.decomposesList_)
end
function UICommonRewardPop2:SetDecomposesList(decomposesList)
    self.decomposesList_ = checkTable(decomposesList)
    self:UpdateDecomposesInfo_()
end


-------------------------------------------------
-- privae

function UICommonRewardPop2:UpdateContinueNum_()
    local continueNum = self:GetContinueNum()
    CfUtils.SetActive(self.ContinueDisplayNumNode, continueNum > 0)
    CfUtils.FillText(self.ContinueDisplayNumText, continueNum)
end


function UICommonRewardPop2:UpdateFulledState_()
    CfUtils.SetActive(self.ContinueStopTextRemind, self:IsPackFulled())
end


function UICommonRewardPop2:UpdateConsumeInfo_()
    local consumeList = self:GetConsumeList()
    for consumeIndex = 1, 2 do
        local consumeData = consumeList[consumeIndex]
        local hasConsume  = consumeData ~= nil
        local costTextRT  = self['ContinueDisplayCostText'..consumeIndex]
        local costIconRT  = self['ContinueDisplayCostIcon'..consumeIndex]
        if consumeData then
            local iconPath = goodsConfMgr:GetPhotoPathById(consumeData.goodsId)
            CfUtils.FillImage(costIconRT, iconPath)
            CfUtils.FillText(costTextRT, consumeData.num)
        end
        CfUtils.SetActive(costTextRT, hasConsume)
        CfUtils.SetActive(costIconRT, hasConsume)
    end
    CfUtils.SetActive(self.ContinueDisplayCostNode, #consumeList > 0)
end


function UICommonRewardPop2:UpdateDecomposesInfo_()
    local decomposesList = self:GetDecomposesList()
    local hasDecomposes  = #decomposesList > 0
    self.dissociateGoodsList_:FreshBaseUI(decomposesList)
    CfUtils.SetActive(self.EquipDissociateDetailsNode, hasDecomposes)
end


return UICommonRewardPop2
