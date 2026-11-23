






SCNJBattleEndUI = {}
SCNJBattleEndUI.__index = SCNJBattleEndUI

local objs = {
    expValueText = {path = "Title/Exp/ExpValue", type = UITool.Text},
    expTotalValueText = {path = "Title/Exp/ExpValue/TotalValue", type = UITool.Text},
    curScoreText = {path = "Score/CurCoin/Score", type = UITool.Text},
    totalScoreText = {path = "Score/TotalScore/Score", type = UITool.Text},
    breakRecordFlag = {path = "BreakRecordFlag", type = UITool.GameObject}
}

SCNJBattleEndUI.New = function(parentObj, obj)

    local self = {}
    setmetatable(self, SCNJBattleEndUI)
    self.gameObject = obj
    UITool.Parse(self.gameObject, self, objs)
    self:Init()
    return self
end

function SCNJBattleEndUI:Init()
end

function SCNJBattleEndUI:SetData(data)
    self.curScoreText.text = "0"
    self.totalScoreText.text = tostring(SCNJData.GetPlayerTotalScore())
    self.expValueText.text = tostring(DataMgr.Player.exp)
    local maxLevel = ConfigMgr.Config.constants.maxPlayerLevel
    local playerLevel = DataMgr.Player.level
    local nextLevel = (playerLevel + 1) > maxLevel and maxLevel or playerLevel
    local totalExp = ConfigMgr.Config.playerLevelUp[tostring(nextLevel)].exp
    self.expTotalValueText.text = string.format("/%d", totalExp)
    if data ~= nil then
        local reportData = json.decode(data)
        local totalDamage = 0
        for key, value in pairs(reportData) do
            totalDamage = totalDamage + value.damage
        end
        local score = SCNJData.GetScore(totalDamage, true)
        self.curScoreText.text = tostring(score)
    end
    local oldTotalScore = SCNJData.GetOldPlayerTotalScore()
    local curTotalScore = SCNJData.GetPlayerTotalScore()
    SetActive(self.breakRecordFlag, curTotalScore > oldTotalScore)
end

function SCNJBattleEndUI:Clear()
    LuaMgr.Destroy(self.gameObject)
    self.gameObject = nil
end