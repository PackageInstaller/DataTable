local UINChipDetailSuitItem = class("UINChipDetailSuitItem", UIBaseNode)
local base = UIBaseNode
local cs_Image = CS.UnityEngine.UI.Image
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType

function UINChipDetailSuitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._countList = {}
  self._countPool = {}
  table.insert(self._countList, self.ui.img_CountItem)
  self.ui.img_CountItem.fillAmount = 0
end

function UINChipDetailSuitItem:InitChipDetailSuit(tagId, haveCount, maxCount)
  local chipTagCfg = ConfigData.chip_tag[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  self.ui.img_Icon.sprite = CRH:GetSprite(chipTagCfg.tag_icon, CommonAtlasType.ExplorationIcon)
  self:_InitCout(haveCount, maxCount)
end

function UINChipDetailSuitItem:_InitCout(haveCount, maxCount)
  if haveCount == nil then
    return
  end
  self.haveCount = haveCount
  self:_RecycleAll()
  if maxCount == 0 then
    return
  end
  local unitAngle = 360
  unitAngle = unitAngle / maxCount
  for i = 1, maxCount do
    local ring = self:_GetOne(true)
    ring.color = 0 <= haveCount - i and Color.white or Color.New(1, 1, 1, 0.3)
    ring.fillAmount = 1 / maxCount - self.ui.float_Block
    ring.transform.localRotation = Quaternion.Euler(0, 0, -((i - 1) * unitAngle))
  end
  self.ui.tran_CountNode.localRotation = Quaternion.Euler(0, 0, -(self.ui.float_Block * 100 * 2))
end

function UINChipDetailSuitItem:InitChipDetailSuitAndCount(tagId, haveCount, maxCount, dynPlayer, isOwnData, isFirstGet)
  self:InitChipDetailSuit(tagId, haveCount, maxCount)
  if dynPlayer ~= nil and not isOwnData and isFirstGet then
    local compoment = self._countList[haveCount + 1]
    if compoment == nil then
      return
    end
    compoment.color = Color.white
    local t = Time.time % 1.4
    compoment:DOFade(0, 0.7):From():SetLoops(-1, cs_DoTweenLoopType.Yoyo):SetLink(compoment.gameObject):Goto(t, true)
  end
end

function UINChipDetailSuitItem:_RecycleAll()
  if #self._countList <= 0 then
    return
  end
  while #self._countList > 0 do
    local compoment = table.remove(self._countList, #self._countList)
    compoment.gameObject:SetActive(false)
    compoment:DOKill()
    table.insert(self._countPool, compoment)
  end
end

function UINChipDetailSuitItem:_GetOne(active)
  local compoment
  if #self._countPool > 0 then
    compoment = table.remove(self._countPool, #self._countPool)
  else
    local go = self.ui.img_CountItem:Instantiate()
    compoment = go:GetComponent(typeof(cs_Image))
  end
  table.insert(self._countList, compoment)
  compoment.gameObject:SetActive(active)
  return compoment
end

function UINChipDetailSuitItem:OnDelete()
  self:_RecycleAll()
  self._countPool = nil
  base.OnDelete(self)
end

return UINChipDetailSuitItem
