---@type OverseaClubFeedCatMgr
local Mgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubFeedingSkinMemberBlock.prefab > name: MemberBlock1
---@class OverseaClubFeedingSkinMemberCell
---@field Env                           	OverseaClubFeedingSkinMemberCell        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field bg                            	UnityEngine.RectTransform               	@ 0    
---@field rare                          	UnityEngine.RectTransform               	@ 1    
---@field Content                       	UnityEngine.RectTransform               	@ 2    
local OverseaClubFeedingSkinMemberCell = Class("OverseaClubFeedingSkinMemberCell")

---@class OverseaClubFeedingSkinMemberCell.InputData
---@field partType number    1  2  3 对应部位

function OverseaClubFeedingSkinMemberCell:__init()
    self.controller = nil
end

function OverseaClubFeedingSkinMemberCell:__delete()
    self.controller = nil
end

function OverseaClubFeedingSkinMemberCell:Awake()
end

---@param inData OverseaClubFeedingSkinMemberCell.InputData
function OverseaClubFeedingSkinMemberCell:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubFeedingSkinMemberCell:RefreshUI()
    CfUtils.SetUISwitchImage(self.bg,self.inData.partType)
    CfUtils.FillText(self.rare,Utils.GetSkinPartName(self.inData.partType))
    
    ---@type ClubFeedCatSkinRefineVo[]
    local vos = CfUtils.GetCf(AutoIds.IdSetting6314, "ClubFeedCatSkinRefineVo", true)
    ---@type ClubFeedCatSkinRefineVo[]
    local filtedVos = {}
    for i = 1, #vos do
        if vos[i].skinType == self.inData.partType and vos[i].phylogeneticStage == Mgr.Server.dojo.petsPhase then
            table.insert(filtedVos, vos[i])
        end
    end
    
    ---@type CommonList
    local commonList = CfUtils.GetLuaScr(self.Content,"Game.Behaviours.CommonList")
    commonList:Initialize(#filtedVos,function(commonList,go, index)
        local vo = filtedVos[index]
        if vo then
            ---@type GoodNodeMBStub
            local goodNodeStub = CfUtils.GetLuaScr(go,"Game.Behaviours.GoodNodeMBStub")
            goodNodeStub:Reload({
                goodsId = vo.itemId,
                text = "x1",
                isShowNum = true
            },0.8)
        end
    end)
end

function OverseaClubFeedingSkinMemberCell:RefreshContent()
    
end



return OverseaClubFeedingSkinMemberCell