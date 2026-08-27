local base = UIBaseNode
local UINSGChapterMapLineNode = class("UINSGChapterMapLineNode", base)
local cs_Ease = CS.DG.Tweening.Ease
local cs_LoopType = CS.DG.Tweening.LoopType

function UINSGChapterMapLineNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSGChapterMapLineNode:PlaySGChapterMapSwitchNewLineAnim(delayTime)
  self:__StopAnim()
  self.ui.animNode.alpha = 0
  self.ui.animNode:DOFade(1, 0.2):SetDelay(delayTime):SetLoops(3, cs_LoopType.Yoyo):SetEase(cs_Ease.InOutQuart):SetLink(self.gameObject)
end

function UINSGChapterMapLineNode:PlaySGChapterMapSwitchNewLineAnimSP(delayTime)
  self:__StopAnimSP()
  self.ui.img_fxLine.material:DOFloat(1, "_Dissolve", 2):SetDelay(delayTime):SetLink(self.gameObject)
end

function UINSGChapterMapLineNode:__StopAnim()
  self.ui.animNode:DOComplete()
end

function UINSGChapterMapLineNode:__StopAnimSP()
  self.ui.img_fxLine.material:DOComplete()
end

function UINSGChapterMapLineNode:OnDelete()
  self:__StopAnim()
  self:__StopAnimSP()
  base.OnDelete(self)
end

return UINSGChapterMapLineNode
