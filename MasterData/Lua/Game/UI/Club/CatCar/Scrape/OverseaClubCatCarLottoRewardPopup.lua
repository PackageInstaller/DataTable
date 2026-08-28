---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarLottoRewardPopup.prefab > name: OverseaClubCatCarLottoRewardPopup
---@class OverseaClubCatCarLottoRewardPopup
---@field Env                           	OverseaClubCatCarLottoRewardPopup       
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RewardLoopView                	SuperScrollView.LoopListView2           	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
local OverseaClubCatCarLottoRewardPopup = Class("OverseaClubCatCarLottoRewardPopup")

---@class OverseaClubCatCarLottoRewardPopup.InputData

function OverseaClubCatCarLottoRewardPopup:__init()
    self.controller = nil
end

function OverseaClubCatCarLottoRewardPopup:__delete()
    self.controller = nil
end

function OverseaClubCatCarLottoRewardPopup:Awake()
    SetButtonAction(self.BtnClose, function() 
        self.controller:Close()
    end)
    self:RefreshUI()
end

function OverseaClubCatCarLottoRewardPopup:OnInitialize() --LuaBehaviour 没有
end

function OverseaClubCatCarLottoRewardPopup:RefreshUI()
    self:RefreshList()
end

function OverseaClubCatCarLottoRewardPopup:RefreshList()
    if not self.RewardLoopView.IsListViewInit then
        self.RewardLoopView:InitListView(#self:GetRewardData(), Bind(self,self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.RewardLoopView, #self:GetRewardData())
    end
end

function OverseaClubCatCarLottoRewardPopup:GetRewardData()
    if self.rewardGroups == nil then
        self.rewardGroups = OverseaClubCatCarUtils:GroupCallConfByType(Mgr.Server.dojo.catCarCallInfo.callConf)
    end
    return self.rewardGroups
end

function OverseaClubCatCarLottoRewardPopup:OnGetItemByIndex(listView, index)
    local data = self:GetRewardData()[index + 1]
    local cell = listView:NewListViewItem("OverseaClubCatCarLottoRewardNode")
    local txtTitle = cell.transform:Find("ImgTitleBg/TxtTitle")
    if txtTitle then
        CfUtils.FillText(txtTitle, OverseaClubCatCarUtils:GetRewardLevelName(data.type))
    end
    ---@type CommonList
    local cellLua = CfUtils.GetLuaScr(cell, "Game.Behaviours.CommonList")
    cellLua:Initialize(#data.rewardList, function(commonList, go, i)
        ---@type OverseaClubCatCarDojo.CallConf
        local callConf = data.rewardList[i]
        local reward = callConf.rewards[1]
        ---@type GoodNodeMB
        local itemEnv = CfUtils.GetLuaScr(go, Constants.UILuaTablePath.GoodNodeMB)
        itemEnv:Reload(reward)
        local txtNum = go.transform:Find("TxtNum")
        if txtNum then
            CfUtils.FillText(txtNum, "No." .. callConf.id)
        end
    end)

    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(cell.transform)
    return cell
end


return OverseaClubCatCarLottoRewardPopup