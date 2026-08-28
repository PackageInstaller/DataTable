---@type OverseaStoreMgr
local OverseaStoreMgr = import('Game.OverseaStore.OverseaStoreMgr'):GetInstance()
---@type OverseaStoreConstants
local OverseaStoreConstants = import('Game.OverseaStore.OverseaStoreConstants')
local Application                 = CS.UnityEngine.Application

--- from: Assets/BundleResources/Prefabs/OverseaMall/OverseaMallCrystalDialog.prefab > name: OverseaMallCrystalDialog
---@class OverseaStorePrimaryCurrencyNode
---@field Env                           	OverseaStorePrimaryCurrencyNode         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BG                            	UnityEngine.RectTransform               	@ 0    
---@field ChargeItem                    	SuperScrollView.LoopGridViewItem        	@ 1    
---@field ScrollView                    	UnityEngine.RectTransform               	@ 2    
---@field Right                         	UnityEngine.RectTransform               	@ 3    
---@field Title6                        	UnityEngine.RectTransform               	@ 4    
---@field Title7                        	UnityEngine.RectTransform               	@ 5    
local OverseaStorePrimaryCurrencyNode = Class("OverseaStorePrimaryCurrencyNode",import("Game.OverseaStore.Node.OverseaStoreTopUpNode"))

function OverseaStorePrimaryCurrencyNode:InitData()
    local PrimaryCurrencyData = OverseaStoreMgr:GetPrimaryCurrencyData()
    self:SetTopUpData(PrimaryCurrencyData)
end

---刷新货币栏
function OverseaStorePrimaryCurrencyNode:RefreshCurrencyBar()
    local currencyList = {Constants.Currency.PayDiamondId}
    CfUtils.RefreshTopGoods(currencyList)
end

function OverseaStorePrimaryCurrencyNode:RefreshUI()
    self:RefreshButton()
    self:RefreshListView()
end

function OverseaStorePrimaryCurrencyNode:RefreshButton()
    local vo1 = CfUtils.GetCfVo(AutoIds.IdSetting6308, "CommercializationSpecialRuleVo", 1) or {}
    if tostring(vo1.switch) ~= '' then
        CfUtils.SetActive(self.Title6, true)
        SetButtonAction(self.Title6, function() 
            CfUtils.OpenURL(vo1.switch)
        end)
    else
        CfUtils.SetActive(self.Title6, false)
    end
    local vo2 = CfUtils.GetCfVo(AutoIds.IdSetting6308, "CommercializationSpecialRuleVo", 2) or {}
    if tostring(vo2.switch) ~= '' then
        CfUtils.SetActive(self.Title7, true)
        SetButtonAction(self.Title7, function()
            CfUtils.OpenURL(vo2.switch)
        end)
    else
        CfUtils.SetActive(self.Title7, false)
    end
end

---刷新列表
function OverseaStorePrimaryCurrencyNode:RefreshListView()
    local topUpData = self:GetTopUpData()
    for i, v in ipairs(topUpData) do
        local cell = self.ScrollView:Find("OverseaMallCrystalItem" .. i)
        if isNotNull(cell) then
            local cellScr = CfUtils.GetLuaScr(cell.gameObject, OverseaStoreConstants.ScrPath.OverseaStorePrimaryCurrencyCell)
            if not isNull(cellScr) then
                cellScr:RefreshState(v, i)
            end
        end
    end
end

return OverseaStorePrimaryCurrencyNode