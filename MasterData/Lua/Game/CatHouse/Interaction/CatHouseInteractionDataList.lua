---
--- Created by Eric.
--- DateTime: 2022/2/9 15:53
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local ConstantsCatHouse = import("Game.CatHouse.ConstantsCatHouse")
local CatHouseMgr = import('Game.CatHouse.CatHouseMgr')

------------ import ------------

------------ define ------------

------------ define ------------


---@class CatHouseInteractionDataList
---@field CatHouseBtnDataNode           	UnityEngine.RectTransform
---@field EmptyPartData                 	UnityEngine.RectTransform
---@field PartDataList                  	UnityEngine.RectTransform
---@field Tips                          	UnityEngine.RectTransform
---@field AppearanceDataList            	UnityEngine.RectTransform
local CatHouseInteractionDataList = Class("CatHouseInteractionDataList")
function CatHouseInteractionDataList:__init()
    self.btnAction = nil
    self.appearanceDataNodeList = {}
    self.partDataNodeList = {}
end

function CatHouseInteractionDataList:__delete()
    self.btnAction = nil
    self.appearanceDataNodeList = nil
    self.partDataNodeList = nil
    self.controller = nil
end

---SetCallBack
---设置单击回调函数
function CatHouseInteractionDataList:SetBtnCallBack(cb)
    self.btnAction = cb
end

function CatHouseInteractionDataList:Awake()
    KTool.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
        if type(self.btnAction) == 'function' then
            self.btnAction()
        end
    end
end

function CatHouseInteractionDataList:FreshBaseUI(data)
    local currentCatData = data
    local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby

    --基因列表
    local CatHouseComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatHouseComponent, Constants.CatHouseEntityId)

    local classifyGene = CatHouseComponent:Process2ClassifyGenes(currentCatData.genes, isChild)
    for k, v in pairs(classifyGene) do
        if k == 1 then
            --部件基因以外的
            local goCount = self.AppearanceDataList.transform.childCount - 1 --减去默认prefab的数量
            if goCount > #v then
                for i = #v + 1, goCount do
                    --复用时隐藏多出来的
                    KTool.SetActive(self.appearanceDataNodeList[i], false)
                end
            end
            for i = 1, #v do
                local go
                go = self.appearanceDataNodeList[i]
                if not go then
                    go = CfUtils.InstantiateGo(self.CatHouseBtnDataNode, self.AppearanceDataList.gameObject)
                    go.name = "DataNode" .. i
                    self.appearanceDataNodeList[i] = go.gameObject
                end
                local nodeEnv = CfUtils.GetLuaScr(self.appearanceDataNodeList[i], "Game.CatHouse.Interaction.CatHouseDataNode")
                if nodeEnv then
                    --local luaIndex = index + 1
                    --local currentCatData = self.catDataList[self.selectedCatIndex]
                    local data = v[i]
                    --local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
                    if isChild then
                        nodeEnv:FreshChild(data, currentCatData)
                    else
                        nodeEnv:FreshAdult(data, currentCatData)
                    end
                    nodeEnv:SetBtnCallBack(function()
                        CatHouseMgr:GetInstance():ShowCatHousDataDetailsNode(go, data)
                        --local vo = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
                        --GameUtils.ShowCommonTipsBoard(
                        --        go,
                        --        vo.name,
                        --        string.format("%s\n%s", vo.desc, vo.description),
                        --        nil, nil, false
                        --)
                    end)
                end
                KTool.SetActive(go, true)
            end

        elseif k == 2 then
            --部件基因
            local goCount = self.PartDataList.transform.childCount - 1 --减去默认prefab的数量
            if goCount > #v then
                for i = #v + 1, goCount do
                    --复用时隐藏多出来的
                    KTool.SetActive(self.partDataNodeList[i], false)
                end
            end
            KTool.SetActive(self.EmptyPartData, #v == 0)
            for i = 1, #v do
                local go
                go = self.partDataNodeList[i]
                if not go then
                    go = CfUtils.InstantiateGo(self.CatHouseBtnDataNode, self.PartDataList.gameObject)
                    go.name = "DataNode" .. i
                    self.partDataNodeList[i] = go.gameObject
                end
                local nodeEnv = CfUtils.GetLuaScr(self.partDataNodeList[i], "Game.CatHouse.Interaction.CatHouseDataNode")
                if nodeEnv then
                    --local luaIndex = index + 1
                    --local currentCatData = self.catDataList[self.selectedCatIndex]
                    local data = v[i]
                    --local isChild = currentCatData.age == ConstantsCatHouse.BornType.Baby
                    if isChild then
                        nodeEnv:FreshChild(data, currentCatData)
                    else
                        nodeEnv:FreshAdult(data, currentCatData)
                    end
                    nodeEnv:SetBtnCallBack(function()
                        if isChild then
                            local catGeneData = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
                            local catAttrData = CfUtils.GetCfVo(AutoIds.IdSetting1901, "CatHouseCatAttributeVo", catGeneData.attributeIdList[1])
                            GameUtils.Toast(localize("_name_达到_num_后进化解锁", { _name_ = catAttrData.name, _num_ = catGeneData.attributeNumList[1] }))
                        else
                            CatHouseMgr:GetInstance():ShowCatHousDataDetailsNode(go, data)

                            --local vo = CfUtils.GetCfVo(AutoIds.IdSetting1902, "CatHouseCatDataVo", data.geneId)
                            --
                            --GameUtils.ShowCommonTipsBoard(
                            --        go,
                            --        vo.name,
                            --        string.format("%s\n%s", vo.desc, vo.description),
                            --        nil, nil, false
                            --)
                        end
                    end)
                end
                KTool.SetActive(go, true)
            end
        end
    end

    if self.Tips then
        KTool.SetActive(self.Tips, isChild)
        self.Tips.transform:SetAsLastSibling()
    end

end

function CatHouseInteractionDataList:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return CatHouseInteractionDataList