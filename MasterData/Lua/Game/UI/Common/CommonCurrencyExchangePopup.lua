---@type OverseaStoreUtils
local OverseaStoreUtils = import('Game.OverseaStore.OverseaStoreUtils')
---@type ServerDifferenceMgr
local ServerDifferenceMgr = import('Game.Setting.ServerDifferenceMgr')
local cs_coroutine = import('XLua.cs_coroutine')

local GoodCellPath = "Game.Behaviours.GoodNodeMB"
---@type OverseaStoreConstants
local OverseaStoreConstants = import('Game.OverseaStore.OverseaStoreConstants')
local KTool =  CS.Engine.Lib.KTool

--- from: Assets/BundleResources/Prefabs/Common/SecondCurrencyPopUp1.prefab > name: SecondCurrencyPopUp1
---@class CommonCurrencyExchangePopup
---@field Env                           	CommonCurrencyExchangePopup             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 0    
---@field BtnGoto                       	UnityEngine.RectTransform               	@ 1    
---@field TxtGoto                       	UnityEngine.UI.Text                     	@ 2    
---@field BtnOK                         	UnityEngine.RectTransform               	@ 3    
---@field Description                   	UnityEngine.UI.Text                     	@ 4    
---@field NotEnoughGroup                	UnityEngine.RectTransform               	@ 5    
---@field GoodNode1                     	UnityEngine.RectTransform               	@ 6    
---@field GoodNode2                     	UnityEngine.RectTransform               	@ 7    
---@field GoodNode4                     	UnityEngine.RectTransform               	@ 8    
---@field NotEnoughGroup2               	UnityEngine.RectTransform               	@ 9    
---@field GoodNode3                     	UnityEngine.RectTransform               	@ 10   
local CommonCurrencyExchangePopup = Class("CommonCurrencyExchangePopup")

---@class CommonCurrencyExchangePopup.InputData
---@field leftId number 左边物品id
---@field leftNum number 左边物品数量
---@field rightId number 右边物品id
---@field rightNum number 右边物品数量
---@field leftData table {{goodsId:111 , num = 1  }}
---@field des string 描述
---@field goto string 前往描述
---@field onConfirmClick fun() 确认点击回调
---@field onConfirmNotEnoughClick fun() 兑换物品不足时确认点击回调
---@field onGotoClick fun() 前往点击回调

function CommonCurrencyExchangePopup:__init()
    ---@type CommonCurrencyExchangePopup.InputData
    self.data = {}
end

function CommonCurrencyExchangePopup:__delete()
    self.controller = nil
end

function CommonCurrencyExchangePopup:Awake()
    SetButtonAction(self.BtnClose, function()
        self.controller:Close()
    end)
    SetButtonAction(self.BtnGoto, Bind(self, self.OnGotoClick))
    SetButtonAction(self.BtnOK, Bind(self, self.OnConfirmClick))

    CfUtils.SetActive(self.NotEnoughGroup,false)
end

function CommonCurrencyExchangePopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self.data = initParams
        self:RefreshUI()
    end)
end

function CommonCurrencyExchangePopup:RefreshUI()
    if isNotNull(self.data.leftData) then
        self:RefreshListGoodsExUI()
    else
        if self:IsFreeDiamondExchange() then
            self:RefreshFreeDiamondExchange()
        else
            self:RefreshNormal()
        end
    end
end
--- 批量道具兑换
function CommonCurrencyExchangePopup:RefreshListGoodsExUI()
    local isEnough = false
    local GoodNodes = {self.GoodNode1 ,self.GoodNode2 , self.GoodNode4}
    local NotEnoughGroups = {self.NotEnoughGroup , self.NotEnoughGroup2}
    for i =2 , #self.data.leftData , 1 do
        KTool.SetActive(NotEnoughGroups[i-1] , true) 
    end
    local allEnough = true
    local goodsDecs = {}
    for k, v  in ipairs(self.data.leftData) do
        local ownNum = GoodsUtils.GetThingNo(v.goodsId) 
        local enough = ownNum >= v.num 
        if not enough then
            local needPayDiamond = self:GetNeedDiamondNum(v.num - ownNum)
            self.needPayDiamond = needPayDiamond
        end
        self:RefreshGoodMB(GoodNodes[k], v.goodsId, v.num , (not enough))
        local vo1 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(v.goodsId))
        goodsDecs[#goodsDecs+1] =  GameUtils.FormatColotText("#FF0000",v.num) .. vo1.name 
        if not enough then
            allEnough = false
        end
    end
    self.enough = allEnough
    self:RefreshGoodMB(self.GoodNode3, self.data.rightId, self.data.rightNum)
    local vo2 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(self.data.rightId))
    CfUtils.FillText(self.Description, localize("是否确认消耗_dec_购买_cnt2__name2_？",
                { _dec_ = table.concat(goodsDecs , ",") , _cnt2_ = GameUtils.FormatColotText("#FF0000",self.data.rightNum), _name2_ = vo2.name }))      
end

function CommonCurrencyExchangePopup:IsFreeDiamondExchange()
    return self.data.leftId == Constants.Currency.FreeDiamondId and ServerDifferenceMgr:IsSecondaryCurrencyEnable()
end

function CommonCurrencyExchangePopup:RefreshNormal()
    local ownNum = GoodsUtils.GetThingNo(self.data.leftId)
    self.enough = ownNum >= self.data.leftNum
    --print("==>>", self.data.leftNum, ownNum, self.data.rightNum)
    if self.enough then
        --数量充足
        self:RefreshGoodMB(self.GoodNode1, self.data.leftId, self.data.leftNum)
        self:RefreshGoodMB(self.GoodNode3, self.data.rightId, self.data.rightNum)
    else
        self:RefreshGoodMB(self.GoodNode1, self.data.leftId, self.data.leftNum, true)
        self:RefreshGoodMB(self.GoodNode3, self.data.rightId, self.data.rightNum)
    end
    
    local vo1 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(self.data.leftId))
    local vo2 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(self.data.rightId))
    
    if self.data.des then
        CfUtils.FillText(self.Description, self.data.des)
    else
        CfUtils.FillText(self.Description, localize("是否确认消耗_cnt1__name1_购买_cnt2__name2_？",
                { _cnt1_ = GameUtils.FormatColotText("#FF0000",self.data.leftNum), _name1_ = vo1.name, _cnt2_ = GameUtils.FormatColotText("#FF0000",self.data.rightNum), _name2_ = vo2.name }))
    end

end

function CommonCurrencyExchangePopup:RefreshFreeDiamondExchange()   --猫眼石购买,不足可用虹晶补充
    local ownNum = GoodsUtils.GetThingNo(self.data.leftId)
    self.enough = ownNum >= self.data.leftNum
    local vo1 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(self.data.leftId))
    local vo2 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(self.data.rightId))
    if self.enough then
        self:RefreshGoodMB(self.GoodNode1, self.data.leftId, self.data.leftNum)
        self:RefreshGoodMB(self.GoodNode3, self.data.rightId, self.data.rightNum)
        CfUtils.FillText(self.Description, localize("是否确认消耗_cnt1__name1_购买_cnt2__name2_？",
                { _cnt1_ = GameUtils.FormatColotText("#FF0000",self.data.leftNum), _name1_ = vo1.name, _cnt2_ = GameUtils.FormatColotText("#FF0000",self.data.rightNum), _name2_ = vo2.name }))
        return
    end
    
    local needPayDiamond = self:GetNeedDiamondNum(self.data.leftNum - ownNum)
    self.needPayDiamond = needPayDiamond
    local ownPayDiamond = GoodsUtils.GetThingNo(Constants.Currency.PayDiamondId)
    local vo3 = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(Constants.Currency.PayDiamondId))
    CfUtils.SetActive(self.NotEnoughGroup,true)
    self.primaryCurrencyEnough = false
    if ownPayDiamond >= needPayDiamond then  --虹晶充足
        --self.enough = true
        self.primaryCurrencyEnough = true
        self:RefreshGoodMB(self.GoodNode2, Constants.Currency.PayDiamondId, needPayDiamond)
    else
        self:RefreshGoodMB(self.GoodNode2, Constants.Currency.PayDiamondId, needPayDiamond, true)
    end
    self:RefreshGoodMB(self.GoodNode1, self.data.leftId, ownNum)
    self:RefreshGoodMB(self.GoodNode3, self.data.rightId, self.data.rightNum)
    CfUtils.FillText(self.Description, localize("是否确认消耗_cnt1__name1_+_cnt3__name3_购买_cnt2__name2_？",
            { _cnt1_ = GameUtils.FormatColotText("#FF0000",ownNum), _name1_ = vo1.name, 
              _cnt2_ = GameUtils.FormatColotText("#FF0000",self.data.rightNum), _name2_ = vo2.name,
              _cnt3_ = GameUtils.FormatColotText("#FF0000",needPayDiamond), _name3_ = vo3.name }))
end

function CommonCurrencyExchangePopup:OnGotoClick()
    if self.data.onGotoClick then
        self.data.onGotoClick()
    else   --default
        cs_coroutine.start(function()
            local UIModule          = CS.Engine.UI.UIModule
            cs_coroutine.yield_return(UIModule.BackDialog())  --先把自己关了,避免入栈

            local buyDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UICommonBuyItemDialog)
            if buyDialog then
                cs_coroutine.yield_return(UIModule.CloseDialog(buyDialog, true))
            end
            local t = {}
            local dialogs = UIModule.CurrentScreen.dialogs
            for _, dialog in pairs(dialogs) do
                table.insert(t, dialog.Argument)
            end
            OverseaStoreUtils.OpenStore(OverseaStoreConstants.StoreType.TimeLimitActivity,t) 
        end)
        return
    end
    self.controller:Close()
end

function CommonCurrencyExchangePopup:RefreshGoodMB(trans, id, num, notEnough)
    ---@type GoodNodeMB
    local env = CfUtils.GetLuaScr(trans, GoodCellPath)
    local text = num
    if notEnough == true then
        text = GameUtils.FormatColotText("#FF0000",text)
    end
    if not isNull(env) then
        env:Reload({
            goodsId = id,
            text = text,
            isShowNum = true,
        })
    end

end

function CommonCurrencyExchangePopup:OnConfirmClick()
    if isNotNull(self.data.leftData)  then
       self:OnLeftListDataConfirmClick()
    else
        if self:IsFreeDiamondExchange() then
            self:OnFreeDiamondConfirmClick()
        else
            self:OnNormalConfirmClick()
        end    
    end
end

function CommonCurrencyExchangePopup:OnLeftListDataConfirmClick()
    if self.enough then
        if self.data.onConfirmClick then
            self.data.onConfirmClick()
        end
    else
        if ServerDifferenceMgr:IsSecondaryCurrencyEnable() then
            self:OnFreeDiamondConfirmClick()
        else
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(Constants.Currency.FreeDiamondId)
            GameUtils.SecondConfirm
            (
                    localize("_name_不足, 是否前往充值？", {_name_ = goodsVo.name}),
                    function()
                        ---@type OverseaStoreUtils
                        local OverseaStoreUtils = import('Game.OverseaStore.OverseaStoreUtils')
                        ---@type OverseaStoreConstants
                        local OverseaStoreConstants = import('Game.OverseaStore.OverseaStoreConstants')
                        OverseaStoreUtils.OpenStore(OverseaStoreConstants.StoreType.TopUp)
                    end
            )
        end
    end
end

function CommonCurrencyExchangePopup:OnNormalConfirmClick()
    if self.enough then
        if self.data.onConfirmClick then
            self.data.onConfirmClick()
        end
    else
        if self.data.onConfirmNotEnoughClick then
            self.data.onConfirmNotEnoughClick()
        else
            if self.data.leftId == Constants.Currency.PayDiamondId then
                self.needPayDiamond = self.data.leftNum
                self:OnFreeDiamondConfirmClick()
                return  -- 不能让下面 close 掉
            else
                local consumItem = GoodsConfMgr:GetGoodsVoById(self.data.leftId)
                GameUtils.Toast(localize("_name_不足", { _name_ = consumItem.name }))
            end
        end
    end
    self.controller:Close()
end

function CommonCurrencyExchangePopup:OnFreeDiamondConfirmClick()
    if self.enough then
        if self.data.onConfirmClick then
            self.data.onConfirmClick()
        end
    else
        --虹晶不足跳转购买虹晶,虹晶充足使用虹晶转换猫眼石
        if self.primaryCurrencyEnough then
            local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
            UIRaycastBlocker:AddCondition("CommonCurrencyExchangePopup")
            GameUtils.Request(Interfaces.StoreDiamondChanges, {num = self.needPayDiamond},
                    function(request, response)
                        UIRaycastBlocker:RemoveCondition("CommonCurrencyExchangePopup")
                        if checkInt(response.errCode) == 0 then
                            local consume = {
                                {
                                    goodsId = Constants.Currency.PayDiamondId,
                                    num     = -self.needPayDiamond
                                }
                            }
                            GoodsUtils.DrawRewards(checkTable(consume))
                            GoodsUtils.DrawRewards(response.data.rewards)
                            if self.data.onConfirmClick then
                                self.data.onConfirmClick()
                            end
                        end
                    end
            )
        else
            --GameUtils.Toast("결제 미오픈")
            --return
            ---@type CommonPrimaryCurrencyBuyPopup.InputData
            local data = {
                payedCallback = function(paySuccess)
                    self:Show(true)
                end,
                needNum = self.needPayDiamond
            }
            CfUtils.DialogOpen(Constants.UITypeIds.PrimaryCurrencyPopup,data)
            self:Show(false)
            return
        end
    end
    self.controller:Close()
end

function CommonCurrencyExchangePopup:Show(flag)
    CfUtils.SetActive(self.controller, flag)
    if flag then
        self:RefreshUI()
    end
end

function CommonCurrencyExchangePopup:GetNeedDiamondNum(freeDiamondNum)
    --一个一级货币,可以兑换ratio个二级货币
    local ratio = checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting10, "BaseArgVo", 20).num)
    if ratio == 0 then
        ratio = 1
    end
    return math.ceil(freeDiamondNum / ratio)
end

return CommonCurrencyExchangePopup