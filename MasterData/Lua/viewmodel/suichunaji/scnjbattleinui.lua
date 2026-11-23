





SCNJBattleInUI = {}
SCNJBattleInUI.__index = SCNJBattleInUI

local objs = {
    scoreTitle = {path = "text", type = UITool.Text},
    scoreTitleRect = {path = "text", type = UITool.RectTransform},
    scoreTitleOutline = {path = "text", type = UITool.OutlineEx},
    scoreTextObj = {path = "text/text_score", type = UITool.GameObject}
}

SCNJBattleInUI.New = function(parentObj)

    local self = {}
    setmetatable(self, SCNJBattleInUI)
    local obj = parentObj.transform:Find("root/Middle/UIBossDummyDamage")
    self.gameObject = obj.gameObject
    self.gameObject.transform:SetSiblingIndex(obj:GetSiblingIndex())
    UITool.Parse(self.gameObject, self, objs)
    self:Init()
    return self
end

function SCNJBattleInUI:Init()
    self.bossDummyDamageImg = self.gameObject:GetComponent(UITool.Image)
    SetActive(self.gameObject, true)
    SetActive(self.scoreTextObj, false)
    local r, g, b, a = 80, 45, 45, 255
    self.scoreTitle.color = UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
    r, g, b, a = 251, 242, 219, 255
    self.scoreTitleOutline.effectColor = UnityEngine.Color(r / 255, g / 255, b / 255, a / 255)
    self.scoreTitleOutline.effectDistance = Vector2(2, -2)
    self.bossDummyDamageImg.sprite = LuaMgr.GetSprite("BattleRes", "ui_hd_ns_sscj_db")
    self.bossDummyDamageImg:SetNativeSize()
    self.scoreTitleRect.anchoredPosition = Vector2(-163, 0)
end

function SCNJBattleInUI:SetData(data)
    SetActive(self.prefabModel, false)
    local langStr = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29609")
    local score = SCNJData.GetScore(data.Damage, true)
    self.scoreTitle.text = string.format(langStr, score)
end

function SCNJBattleInUI:Clear()
    LuaMgr.Destroy(self.gameObject)
    self.gameObject = nil
end