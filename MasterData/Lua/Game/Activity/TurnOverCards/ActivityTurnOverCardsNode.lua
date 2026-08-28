---
--- Created by Eric.
--- DateTime: 2022/11/16 15:14
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders

local cs_coroutine = require 'XLua.cs_coroutine'
------------ import ------------

------------ define ------------

------------ define ------------


--- from: Assets/BundleResources/Prefabs/Activity/ActivityTurnOverCards101501.prefab
---@class ActivityTurnOverCardsNode
---@field Env                           	ActivityTurnOverCardsNode
---@field controller                        Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field GoodNode                        UnityEngine.RectTransform
---@field GetNode                        UnityEngine.RectTransform
---@field OpenNode                        UnityEngine.RectTransform
---@field BtnBack                        UnityEngine.RectTransform
---@field CardCell                        UnityEngine.Animation
local ActivityTurnOverCardsNode = Class("ActivityTurnOverCardsNode")
function ActivityTurnOverCardsNode:__init()
    self.btnAction = nil

end

function ActivityTurnOverCardsNode:__delete()
    self.btnAction = nil

    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function ActivityTurnOverCardsNode:SetBtnCallBack(cb)
    self.btnAction = cb
end

function ActivityTurnOverCardsNode:Awake()
    SetButtonAction(self.BtnBack.gameObject, function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end)
end

function ActivityTurnOverCardsNode:FreshBaseUI(data)
    KTool.SetActive(self.BtnBack, not data.hasOpened)
    KTool.SetActive(self.OpenNode, data.hasOpened)
    KTool.SetActive(self.GetNode, data.hasGet)
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting2835, "FlipCardRewardVo", data.id)
    local goEnv = CfUtils.GetLuaScr(self.GoodNode, "Game.Behaviours.GoodNodeMB")
    local goodsId = vo.reward
    local num = vo.rewardNum
    goEnv:SetClickButtonAction(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if isTable(vo) then
            if data.hasOpened then
                GameUtils.ShowCommonTipsBoard(self.GoodNode, vo.name, vo.desc, vo.quality, vo.id)
            end
        end
    end)

    goEnv:Reload(
            {
                goodsId = goodsId,
                isShowNo = true, text = 'x' .. FormatCurrencyNum(num)
            }
    )
end

--function ActivityTurnOverCardsNode:FreshOpenStatus(hasOpened)
--
--
--end

function ActivityTurnOverCardsNode:PlayMatchAnim()
    local co = cs_coroutine.start(function()
        self.CardCell:PlayQueued("Activity_TurnOverCards_Card_Match", CS.UnityEngine.QueueMode.CompleteOthers)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.333))
    end)
    return co
end

function ActivityTurnOverCardsNode:PlayMatchCloseAnim()
    local co = cs_coroutine.start(function()
        self.CardCell:PlayQueued("Activity_TurnOverCards_Card_hasGet", CS.UnityEngine.QueueMode.CompleteOthers)
    end)
    return co

end

function ActivityTurnOverCardsNode:PlayOpenAnim()
    local co = cs_coroutine.start(function()
        self.CardCell:PlayQueued("Activity_TurnOverCards_Card_Open", CS.UnityEngine.QueueMode.CompleteOthers)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
    end)
    return co

end

function ActivityTurnOverCardsNode:PlayCloseAnim()
    local co = cs_coroutine.start(function()
        self.CardCell:PlayQueued("Activity_TurnOverCards_Card_Close", CS.UnityEngine.QueueMode.CompleteOthers)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.467))
    end)
    return co

end

function ActivityTurnOverCardsNode:OnDestroy()
    self.controller:StopAllCoroutines()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return ActivityTurnOverCardsNode