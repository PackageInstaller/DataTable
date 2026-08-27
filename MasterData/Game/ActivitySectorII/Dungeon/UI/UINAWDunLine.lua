local UINAWDunLine = class("UINAWDunLine", UIBaseNode)
local base = UIBaseNode

function UINAWDunLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:__ReSetUIState()
end

function UINAWDunLine:RefreshAWDunLine(lastLevelPos, cueLevelPos, nextDunData)
  self:__DrawLine(lastLevelPos, cueLevelPos)
  self:__SetLineState(nextDunData)
end

function UINAWDunLine:__DrawLine(lastLevelPos, cueLevelPos)
  local length, angle, dirVector
  length = Vector2.Distance(lastLevelPos, cueLevelPos)
  dirVector = cueLevelPos - lastLevelPos
  angle = Vector2.Angle(Vector2.right, dirVector)
  angle = angle * (0 < Vector3.Cross(Vector3.right, Vector3.New(dirVector.x, dirVector.y, 0)).z and 1 or -1)
  self.transform.anchoredPosition = lastLevelPos
  self.transform.localEulerAngles = Vector3.New(0, 0, angle)
  self.transform.sizeDelta = Vector2.New(length, self.transform.sizeDelta.y)
  self.length = length
end

function UINAWDunLine:__SetLineState(nextDunData)
  self:__ReSetUIState()
  local isUnlock = nextDunData:GetIsLevelUnlock()
  if not isUnlock then
    self.ui.img_PipeLine.enabled = true
    return
  end
  local isComplete = nextDunData:GetIsLevelComplete()
  if isUnlock and isComplete then
    self.ui.img_Line.enabled = true
    return
  end
  local cs_Material = CS.UnityEngine.Material
  self.__pipeMat = cs_Material(self.ui.mat_Pipe)
  self.ui.lineRender.material = self.__pipeMat
  local tiling = self.length / 24
  self.__pipeMat:SetTextureScale("_MainTex", Vector2.New(tiling, 1))
  self.ui.lineRender.enabled = true
end

function UINAWDunLine:__ReSetUIState()
  self.ui.img_Line.enabled = false
  self.ui.img_PipeLine.enabled = false
  self.ui.lineRender.enabled = false
end

function UINAWDunLine:OnDelete()
  if self.__pipeMat ~= nil then
    DestroyUnityObject(self.self.__pipeMat)
  end
  base.OnDelete(self)
end

return UINAWDunLine
