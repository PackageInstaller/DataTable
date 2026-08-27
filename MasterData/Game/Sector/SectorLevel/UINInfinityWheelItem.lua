local UINInfinityWheelItem = class("UINInfinityWheelItem", UIBaseNode)
local base = UIBaseNode
local changeStep = 90

function UINInfinityWheelItem:OnInit()
  self.textItemList = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tex_0.gameObject:SetActive(false)
  self:__CreateTextList()
  self:SetArrowActive(false)
end

function UINInfinityWheelItem:InitWheel(listCount, viewSizeY, elementSizeY)
  self.lastDegree = 0
  self.lastAudioDegree = 0
  self.listCount = listCount
  viewSizeY = viewSizeY or 1080
  elementSizeY = elementSizeY or 207
  self.unitDegree = (listCount - viewSizeY / elementSizeY) * 30
  self.offsetValue = (viewSizeY / elementSizeY // 2 - 2) * 10
  self:RoteWheel(0)
  self:WriteNums(0)
end

function UINInfinityWheelItem:RoteWheel(value)
  local degree = value * self.unitDegree
  self.ui.obj_Outer.rotation = Quaternion.Euler(0, 0, -degree)
  self.ui.obj_Inside.rotation = Quaternion.Euler(0, 0, degree)
  local num = ((degree / 30 + 1) * 10 + self.offsetValue) * 1000 * 9.8 / 1000000
  num = GetPreciseDecimalStr(num, 3)
  self.ui.tex_MPa.text = tostring(num)
  if math.abs(degree - self.lastDegree) > changeStep then
    local offsetIndex = degree // 30
    self:WriteNums(offsetIndex)
    self.lastDegree = degree
  end
  if 0 <= value and value <= 1 and 30 < math.abs(degree - self.lastAudioDegree) then
    self.lastAudioDegree = degree
    AudioManager:PlayAudioById(1037)
  end
end

function UINInfinityWheelItem:__CreateTextList()
  local textItem
  for i = 1, 12 do
    local text = self.ui.tex_0.gameObject:Instantiate():GetComponent(typeof(CS.UnityEngine.UI.Text))
    text.gameObject:SetActive(true)
    local z = (i - 1) * -30
    text.transform:Rotate(Vector3.New(0, 0, z))
    self.textItemList[i] = text
  end
end

function UINInfinityWheelItem:WriteNums(offsetIndex)
  local offsetValue = offsetIndex * 10 + self.offsetValue
  if offsetIndex < 0 then
    local offest = math.fmod(offsetIndex, 12)
    offsetIndex = offest + 12
  end
  for i = offsetIndex + 1, offsetIndex + 12 do
    local index = math.fmod(i, 12)
    if index == 0 then
      index = 12
    end
    local textItem = self.textItemList[index]
    local count = i - offsetIndex
    if count <= 6 then
      textItem.text = tostring(FormatNum(count * 10 + offsetValue))
    else
      textItem.text = tostring(FormatNum((12 - count) * -10 + offsetValue))
    end
  end
end

function UINInfinityWheelItem:SetArrowActive(active)
  self.ui.tex_MPa.transform.parent.gameObject:SetActive(active)
end

function UINInfinityWheelItem:OnDelete()
  base.OnDelete(self)
end

return UINInfinityWheelItem
