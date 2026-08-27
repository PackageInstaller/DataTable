local base = UIBaseNode
local UINSGChapterMapNodeBase = class("UINSGChapterMapNodeBase", base)

function UINSGChapterMapNodeBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Item, self, self.__OnClick)
end

function UINSGChapterMapNodeBase:InitNSGChapterMapNode(storyData, nodeData)
  self.storyData = storyData
  self.nodeData = nodeData
  self:__RefreshNodeTitle()
  self:__RefreshNodeImg()
  self:SGNode_RefreshNodeState()
end

function UINSGChapterMapNodeBase:__OnClick()
  print("need child class implement")
end

function UINSGChapterMapNodeBase:__RefreshNodeTitle()
  self.ui.tex_Stage.text = self.nodeData:Act23GSSN_GetNodeTitle()
end

function UINSGChapterMapNodeBase:__RefreshNodeImg()
  local index = self.nodeData:Act23GSSN_GetNodeOutLookIndex()
  index = math.clamp(index, 0, 2)
  self.ui.img_self:SetIndex(index)
end

function UINSGChapterMapNodeBase:SGNode_RefreshNodeState()
  local diff = self.storyData:Act23Gs_GetDiffIndex()
  local isUnlock = self.nodeData:Act23GSSN_GetIsUnlock(diff)
  local isClear = self.nodeData:Act23GSSN_GetIsClear(diff)
  self.ui.obj_Lock:SetActive(not isUnlock)
  self.ui.obj_Clear:SetActive(isClear)
end

function UINSGChapterMapNodeBase:PlaySGChapterMapNodeCompletedAnim(delayTime)
  if IsNull(self.ui.anim_clear) then
    return
  end
  if delayTime == nil then
    delayTime = 0
  end
  self:__StopCompletedAnim()
  self.ui.anim_clear.transform:DOScale(1.5, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_clear:DOFade(0, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
end

function UINSGChapterMapNodeBase:__StopCompletedAnim()
  self.ui.anim_clear.transform:DOComplete()
  self.ui.anim_clear:DOComplete()
end

function UINSGChapterMapNodeBase:PlaySGChapterMapNodeShowNextNodeAnim(delayTime)
  if IsNull(self.ui.anim_canvas) then
    return
  end
  if delayTime == nil then
    delayTime = 0
  end
  self:__StopShowNextNodeAnim()
  self.ui.anim_canvas.transform:DOLocalMoveX(30, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.anim_canvas:DOFade(0, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
end

function UINSGChapterMapNodeBase:__StopShowNextNodeAnim()
  self.ui.anim_canvas.transform:DOComplete()
  self.ui.anim_canvas:DOComplete()
end

function UINSGChapterMapNodeBase:OnDelete()
  self:__StopCompletedAnim()
  self:__StopShowNextNodeAnim()
  base.OnDelete(self)
end

return UINSGChapterMapNodeBase
