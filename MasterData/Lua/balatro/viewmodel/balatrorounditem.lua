


















BalatroRoundItem = {}
BalatroRoundItem.__index = BalatroRoundItem

local objs = {
    itemNumImg = {path = "Top/ItemIndexImg", type = BalatroUtil.Image},
    sceneEffectDes = {path = "Top/SceneEffectBG/SceneEffectText", type = BalatroUtil.Text},
    goalScore = {path = "Top/GoalScore", type = BalatroUtil.Text},

    forbidObj = {path = "Bottom/ForbidObj", type = BalatroUtil.GameObject},
    startBtn = {path = "Bottom/StartBtn", type = BalatroUtil.Button},

    roundObj = {path = "Bottom/RoundObj", type = BalatroUtil.GameObject},
    bgLightObj = {path = "Bottom/RoundObj/BGLight", type = BalatroUtil.GameObject},
    bgDarkObj = {path = "Bottom/RoundObj/BGDark", type = BalatroUtil.GameObject},
    completeObj = {path = "Bottom/RoundObj/CompleteObj", type = BalatroUtil.GameObject},
    roundTxt = {path = "Bottom/RoundObj/RoundTxt", type = BalatroUtil.Text}
}

function BalatroRoundItem.New(prefab, parent)

    local self = {}
    setmetatable(self, BalatroRoundItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.forbidObj, false)
    SetActive(self.startBtn.gameObject, false)
    SetActive(self.roundObj, false)
    self.OnClickStartBtn = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroClickStartGame, self.phaseData.phaseIndex)
    end
    LuaMgr.AddClick(self.startBtn, self.OnClickStartBtn)
    return self
end


function BalatroRoundItem:SetPhaseData(data)
    self.phaseData = data
    if data.phaseIndex == nil or data.phaseIndex == 0 then
        LuaDebug.error("BalatroRoundItem:SetPhaseData 数据错误")
        return
    end
    self.itemNumImg.sprite = BalatroRoundItem.GetIndexImage(data.phaseIndex)
    self.sceneEffectDes.text = data.sceneEffectDes or ""
    self.goalScore.text = data.goalScore or ""
    local deltaPhase = data.phaseIndex - data.curPhaseIndex
    SetActive(self.forbidObj, deltaPhase > 0)
    SetActive(self.startBtn.gameObject, deltaPhase == 0)
end

function BalatroRoundItem:SetRoundData(data)
    self.itemNumImg.sprite = BalatroRoundItem.GetIndexImage(data.roundIndex)
    self.sceneEffectDes.text = data.sceneEffectDes or ""
    self.goalScore.text = data.goalScore or ""
    local deltaRound = data.roundIndex - data.curRoundIndex
    SetActive(self.roundObj, deltaRound < 2)
    SetActive(self.bgLightObj, deltaRound == 0)
    SetActive(self.bgDarkObj, deltaRound ~= 0)
    SetActive(self.completeObj, deltaRound < 0)
    if deltaRound == 0 then
        self.roundTxt.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20028")
    elseif deltaRound > 0 then
        self.roundTxt.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20029")
    else
        self.roundTxt.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_20038")
    end
end

function BalatroRoundItem.GetIndexImage(index)
    return LuaMgr.GetSprite(BalatroUtil.AlataOther, "ui_jj_xcp_xz_gk" .. (index or 1))
end