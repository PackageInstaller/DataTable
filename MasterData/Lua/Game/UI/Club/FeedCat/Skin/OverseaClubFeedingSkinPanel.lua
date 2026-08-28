---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

local CellLua = "Game.UI.Club.FeedCat.Skin.OverseaClubFeedingSkinPanelCell"

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingSkinDialog.prefab > name: OverseaClubFeedingSkinDialog
---@class OverseaClubFeedingSkinPanel
---@field Env                           	OverseaClubFeedingSkinPanel             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field BtnJump                       	UnityEngine.RectTransform               	@ 1    
---@field FurColor                      	UnityEngine.RectTransform               	@ 2    
---@field Neck                          	UnityEngine.RectTransform               	@ 3    
---@field Tail                          	UnityEngine.RectTransform               	@ 4    
---@field TxtTips                       	UnityEngine.RectTransform               	@ 5    
---@field BtnRefineRoot                 	UnityEngine.RectTransform               	@ 6    
---@field BtnRefine                     	Game.Native.Common.FontStyleButton      	@ 7    
---@field CommonBtnConsumePop           	UnityEngine.RectTransform               	@ 8    
---@field TxtRefinePermission           	UnityEngine.RectTransform               	@ 9    
---@field BtnDonate                     	UnityEngine.RectTransform               	@ 10   
---@field IconCoin                      	UnityEngine.RectTransform               	@ 11   
---@field TxtCoinNum                    	UnityEngine.RectTransform               	@ 12   
local OverseaClubFeedingSkinPanel = Class("OverseaClubFeedingSkinPanel")

---@class OverseaClubFeedingSkinPanel.InputData

function OverseaClubFeedingSkinPanel:__init()
    self.controller = nil
    self.selectIndex = 1   --1,2,3 对应部位
    self.inited = false
end

function OverseaClubFeedingSkinPanel:__delete()
    self.controller = nil
end

function OverseaClubFeedingSkinPanel:Awake()
    SetButtonAction(self.BtnJump, function()
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedingSkinMember)
    end)
    
    SetButtonAction(self.BtnRefine, function()
        Mgr.Server:ReqReset(self.selectIndex,function()
            Mgr.cat:ChangeSkin(self.selectIndex,Mgr.Server.dojo.petsFacade[self.selectIndex])
            self:RefreshUI()
        end)
    end)
    
    SetButtonAction(self.BtnDonate, function()
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedingDonatePopup,{donateItemId = Utils.GetParamValue(Utils.ParamsId.MemberDonateItemId)})
    end)
    
    self:Init()
end

function OverseaClubFeedingSkinPanel:Init()
    if self.inited then
        return
    end
    self.inited = true
    
    ---@type OverseaClubFeedingSkinPanelCell[]
    self.cellLuas = {}
    self.cellLuas[1] = CfUtils.GetLuaScr(self.FurColor,CellLua)
    self.cellLuas[2] = CfUtils.GetLuaScr(self.Neck,CellLua)
    self.cellLuas[3] = CfUtils.GetLuaScr(self.Tail,CellLua)
    for i, v in ipairs(self.cellLuas) do
        v:SetSelectCallback(function(part)
            self.selectIndex = part
            self:RefreshUI()
        end)
    end
end

function OverseaClubFeedingSkinPanel:Show(flag,data)
    CfUtils.SetActive(self.controller,flag)
    if flag == true then
        self:RefreshData(data)
    end
end

---@param inData OverseaClubFeedingSkinPanel.InputData
function OverseaClubFeedingSkinPanel:RefreshData(inData)
    self:Init()
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingSkinPanel:RefreshUI()
    local unLocked = Mgr:IsUnlockSkinPart(1)
    if unLocked then
        CfUtils.SetActive(self.TxtTips,false)
        CfUtils.SetActive(self.BtnRefineRoot,true)
        local myMemberDojo   = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
        local hasPermission = ClubUtils.HasJobFunc(myMemberDojo.job, ClubUtils.JobFuncId.FEEDCAT_REFINE_SKIN)
        if hasPermission then
            CfUtils.SetActive(self.TxtRefinePermission,false)
            CfUtils.SetActive(self.BtnRefine,true)
            ---@type CommonBtnConsumePop
            local consumePop = CfUtils.GetLuaScr(self.CommonBtnConsumePop, Constants.UILuaTablePath.BtnConsumePop)
            consumePop:RefreshUI(Constants.Currency.ClubFeedCatSkinCoin, Utils.GetRefineConsum(self.selectIndex))
            self.BtnRefine:ResetFontStyle(Constants.ButtonFontStyle.B3)
        else
            CfUtils.SetActive(self.CommonBtnConsumePop,false)
            CfUtils.SetActive(self.TxtRefinePermission,true)
            self.BtnRefine:SetDisableFontStyle(true)
        end
    else
        CfUtils.SetActive(self.TxtTips,true)
        CfUtils.SetActive(self.BtnRefineRoot,false)
        self.selectIndex = 0
    end

    self:RefreshCells()
    local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(Constants.Currency.ClubFeedCatSkinCoin)
    if goodsVo then
        CfUtils.FillImage(self.IconCoin,goodsVo.photoPath)    
    end
    CfUtils.FillText(self.TxtCoinNum,Mgr.Server.dojo.petsFund)
end

function OverseaClubFeedingSkinPanel:RefreshCells()
    local skinData = Mgr.Server.dojo.petsFacade
    for i, v in ipairs(self.cellLuas) do
        ---@type OverseaClubFeedingSkinPanelCell.InputData
        local data = {}
        data.partType = i
        data.skinId = skinData[i] or 0
        data.select = self.selectIndex == i
        v:RefreshData(data)
    end
end

function OverseaClubFeedingSkinPanel:OnDestroy()
    self:Delete()
end

return OverseaClubFeedingSkinPanel