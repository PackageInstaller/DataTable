
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
---@type CatBallUtils
local CatBallUtils     = import("Game.CatBall.CatBallUtils")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
    
--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverseaManage/OverseaManageCatballDrawEntryItemPrefabCell.prefab > name: OverseaManageCatballDrawEntryItemPrefabCell
---@class CatBallDrawEntryCell
---@field Env                           	CatBallDrawEntryCell                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgNew                        	UnityEngine.RectTransform               
---@field redPoint                      	UnityEngine.RectTransform               
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field CanCovert                     	UnityEngine.RectTransform               
---@field ImgNotGet                     	UnityEngine.RectTransform               
---@field StatusGroup                   	UnityEngine.RectTransform               
---@field CommonSmallCatBallNode        	UnityEngine.RectTransform               
local CatBallDrawEntryCell = Class('CatBallDrawEntryCell')

function CatBallDrawEntryCell:__init()

end


function CatBallDrawEntryCell:__delete()

end


function CatBallDrawEntryCell:Awake()
    KTool.SetActive(self.StatusGroup.gameObject, true)
    KTool.SetActive(self.ImgNotGet.gameObject, false)
    KTool.SetActive(self.CanCovert.gameObject, false)
end


function CatBallDrawEntryCell:Start()
end


function CatBallDrawEntryCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param catBallEntity CatBallEntity
function CatBallDrawEntryCell:FreshUI(catBallEntity, callBack)
    self._env = CatBallUtils.FreshCommonSmallCatBallNode(self.CommonSmallCatBallNode, catBallEntity, function ()
        if callBack then
            callBack(catBallEntity, self)
        end
    end)

    self:FreshStatusGroup(catBallEntity)

end

---FreshStatusGroup
---@param catBallEntity CatBallEntity
function CatBallDrawEntryCell:FreshStatusGroup(catBallEntity)
    local isFragment = catBallEntity.isFragment
    -- KTool.SetActive(self.StatusGroup.gameObject, catBallEntity.isFragment)
    -- if isFragment then
    --     local isCanMerge = catBallEntity.isCanMerge
    --     KTool.SetActive(self.ImgNotGet.gameObject, not isCanMerge)
    --     KTool.SetActive(self.CanCovert.gameObject, isCanMerge)
    -- end
    local isCanMerge = catBallEntity.isCanMerge
    KTool.SetActive(self.ImgNotGet.gameObject, isFragment == true and not isCanMerge)
    KTool.SetActive(self.CanCovert.gameObject, isFragment == true and isCanMerge == true)

    ---@type CatEggComponent
    local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    KTool.SetActive(self.ImgNew.gameObject, not catBallEntity.isFragment and eggComponent:GetCatBallNewFlag(catBallEntity.dojo.id))
end

function CatBallDrawEntryCell:PlayAnimationCompose()
    ---@type CommonSmallCatBallNode
    local env = self._env
    if isNull(env) then return end
    env:PlayAnimationCompose()
    
end

function CatBallDrawEntryCell:FreshRedPoint(isShow)
    -- KTool.SetActive(self.StatusGroup.gameObject, true)
    KTool.SetActive(self.redPoint.gameObject, isShow)
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CatBallDrawEntryCell
