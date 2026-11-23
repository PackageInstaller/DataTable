











BlatroMainStartGamePanel = {}
BlatroMainStartGamePanel.__index = BlatroMainStartGamePanel

require("Balatro/ViewModel/BalatroRoundItem")

local objs = {
    sceneEffect = {path = "Top/SceneEffect", type = BalatroUtil.Text},
    phaseGroup = {path = "PhaseGroup", type = BalatroUtil.Transform}
}

function BlatroMainStartGamePanel.New(prefab, obj)

    local self = {}
    setmetatable(self, BlatroMainStartGamePanel)
    self.gameObject = obj
    UITool.Parse(self.gameObject, self, objs)
    local childCount = self.phaseGroup.childCount

    self.phaseItems = {}
    for i = 1, childCount do
        local parent = self.phaseGroup:GetChild(i - 1)
        local item = BalatroRoundItem.New(prefab, parent)
        item.gameObject.transform.localPosition = Vector3.zero
        table.insert(self.phaseItems, item)
    end
    return self
end

function BlatroMainStartGamePanel:Refresh()
    self.sceneEffect.text = BalatroStepMgr.GetGlobalSceneEffect():GetDes()
    if self.phaseItems == nil then
        print("BlatroStartGamePanel:Refresh UI数据错误")
        return
    end
    local curPhaseData = BalatroStepMgr.GetCurPhaseData()
    if not curPhaseData or NumTool.GetLen(curPhaseData) == 0 then
        print("BlatroStartGamePanel:Refresh 阶段数据错误")
        return
    end

    local phaseItemsLen = #self.phaseItems

    local roundDatas = curPhaseData
    if phaseItemsLen ~= #roundDatas then
        print(string.format("BlatroStartGamePanel:Refresh 数据数量不匹配 phaseItemsLen:%d #roundDatas:%d", phaseItemsLen, #roundDatas))
        return
    end
    for i = 1, phaseItemsLen do
        local roundData = roundDatas[i]
        local sceneEffect = roundData:GetSceneEffect()
        local sceneDes = sceneEffect and sceneEffect:GetDes() or ""
        local data = {
            phaseIndex = i,
            sceneEffectDes = sceneDes,
            goalScore = roundData:GetRealGoalScore(),
            curPhaseIndex = roundData:GetPhaseIndex()
        }
        local phaseItemData = self.phaseItems[i]
        phaseItemData:SetPhaseData(data)
    end
end