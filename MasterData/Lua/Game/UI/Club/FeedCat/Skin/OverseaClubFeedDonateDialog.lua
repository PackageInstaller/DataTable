---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingDonatePopup.prefab > name: OverseaClubFeedingDonatePopup
---@class OverseaClubFeedDonateDialog
---@field Env                           	OverseaClubFeedDonateDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CloseEmpty                    	UnityEngine.RectTransform               	@ 0    
---@field InputField                    	TMPro.TMP_InputField                    	@ 1    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 2    
---@field BtnAddTen                     	UnityEngine.RectTransform               	@ 3    
---@field BtnMinusTen                   	UnityEngine.RectTransform               	@ 4    
---@field BtnMinus                      	UnityEngine.RectTransform               	@ 5    
---@field BtnAdd                        	UnityEngine.RectTransform               	@ 6    
---@field TxtLeft                       	UnityEngine.RectTransform               	@ 7    
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 8    
---@field TxtRefineCoinNum              	UnityEngine.RectTransform               	@ 9    
---@field TxtClubCoinNum                	UnityEngine.RectTransform               	@ 10   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 11   
local OverseaClubFeedDonateDialog = Class("OverseaClubFeedDonateDialog")

---@class OverseaClubFeedDonateDialog.InputData
---@field donateItemId number

function OverseaClubFeedDonateDialog:__init()
    self.controller = nil
end

function OverseaClubFeedDonateDialog:__delete()
    self.controller = nil
end

function OverseaClubFeedDonateDialog:Awake()
    SetButtonAction(self.BtnAdd, Bind(self, self.OnBtnAdd))
    SetButtonAction(self.BtnMinus, Bind(self, self.OnBtnReduce))
    SetButtonAction(self.BtnAddTen, Bind(self, self.OnBtnTenAdd))
    SetButtonAction(self.BtnMinusTen, Bind(self, self.OnBtnTenReduce))
    SetButtonAction(self.BtnMinusTen, Bind(self, self.OnBtnTenReduce))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnBtnExchange))
    self.InputField.onValueChanged:AddListener(function(num)
        num = checkNumber(num)
        if num <= 0 then
            self._curNum = 0
        elseif num >= self._maxNum then
            self._curNum = self._maxNum
        else
            self._curNum = num
        end
        self:RefreshSelectNum()
    end)
    
    SetButtonAction(self.CloseEmpty, Bind(self, self.OnBtnClose))
    SetButtonAction(self.BtnClose, Bind(self, self.OnBtnClose))
end

function OverseaClubFeedDonateDialog:OnInitialize()
    return CoWaitDo(function()
        ---@type OverseaClubFeedDonateDialog.InputData
        self.inData = self.controller.Argument.parameters or {}
        self._curNum = 0
        self._maxNum = GoodsUtils.GetThingNo(self.inData.donateItemId)
        self._maxDailyDonate = Utils.GetParamValue(Utils.ParamsId.MemberDonateLimit)
        local leftDonateNum = self._maxDailyDonate - Mgr.Server.dojo.dailyDonateNum
        self._maxNum = math.min(self._maxNum, leftDonateNum)
        ---@type CommonBtnConsumePop
        self._commonBtnConsumePopLua = CfUtils.GetLuaScr(self.CommonBtnConsumePop,Constants.UILuaTablePath.BtnConsumePop)
        self._refineCoinRatio = Utils.GetParamValue(Utils.ParamsId.DonateCoinCount)
        self._clubCoinRatio = Utils.GetParamValue(Utils.ParamsId.DonateClubScoreCount)
        self:RefreshUI()
    end)
end

function OverseaClubFeedDonateDialog:RefreshUI()
    self:RefreshSelectNum()
end

function OverseaClubFeedDonateDialog:RefreshSelectNum()
    self.InputField.text = self._curNum
    self._commonBtnConsumePopLua:RefreshUI(self.inData.donateItemId, self._curNum)
    
    
    --今日捐赠上限：0/3000
    CfUtils.FillText(self.TxtLeft,localize("今日捐赠上限：_num_1/_num2",{_num_1 = Mgr.Server.dojo.dailyDonateNum, _num2 = self._maxDailyDonate}))
    
    CfUtils.FillText(self.TxtRefineCoinNum, self._refineCoinRatio * self._curNum)
    CfUtils.FillText(self.TxtClubCoinNum, self._clubCoinRatio * self._curNum)
end

function OverseaClubFeedDonateDialog:OnBtnExchange()
    if self._curNum <= 0 then
        GameUtils.Toast(localize("请选择数量"))
        return
    end

    local consumeConf = GoodsConfMgr:GetInstance():GetGoodsVoById(self.inData.donateItemId)
    GameUtils.SecondConfirm
    (
            localize("是否捐赠_Num__Name_给社团？",{_Num_ = self._curNum, _Name_ = consumeConf.name}),
            function()
                Mgr.Server:ReqDonat(self._curNum, function()
                    self:OnBtnClose()
                end)
            end
    )
end

--增加
function OverseaClubFeedDonateDialog:OnBtnAdd()
    if self._curNum >= self._maxNum then
        GameUtils.Toast(localize("已经最大数量了"))
        return
    end
    self._curNum = self._curNum + 1
    self:RefreshSelectNum()
end

--减少
function OverseaClubFeedDonateDialog:OnBtnReduce()
    if self._curNum <= 0 then
        GameUtils.Toast(localize("已经最低数量了"))
        return
    end
    self._curNum = self._curNum - 1
    self:RefreshSelectNum()
end

--+10
function OverseaClubFeedDonateDialog:OnBtnTenAdd()
    if self._curNum >= self._maxNum then
        GameUtils.Toast(localize("已经最大数量了"))
        return
    end

    local num = self._curNum + 10
    self._curNum = (num >= self._maxNum) and self._maxNum or num
    self:RefreshSelectNum()
end

---10
function OverseaClubFeedDonateDialog:OnBtnTenReduce()
    if self._curNum <= 0 then
        GameUtils.Toast(localize("已经最低数量了"))
        return
    end

    local num = self._curNum - 10
    self._curNum = (self._curNum <= 0) and 0 or num
    self:RefreshSelectNum()
end

function OverseaClubFeedDonateDialog:OnBtnClose()
    self.controller:Close()
end

function OverseaClubFeedDonateDialog:OnFinalize()
    self:Delete()
end

return OverseaClubFeedDonateDialog