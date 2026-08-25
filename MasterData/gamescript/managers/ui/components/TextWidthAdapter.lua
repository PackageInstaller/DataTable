local TextWidthAdapter = NewClass("TextWidthAdapter")
local TypeOfTMP_Text = typeof(CS.TMPro.TMP_Text)
local _GetLocalPos = CS.Framework.TransformUtil.GetLocalPos
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local _SetLocalScale = CS.Framework.TransformUtil.SetLocalScale

function TextWidthAdapter:ctor(go)
  self.gameObject = go
  self.tmpTextComp = go:GetComponent(TypeOfTMP_Text)
  self.rectTrans = go.transform
  self.limitMinWidth = 0
  self.limitMaxWidth = 0
  self.adapterNodes = nil
  self.lineWidth = self.rectTrans.rect.width
  local x, y, z = _GetLocalPos(self.rectTrans, nil, nil, nil)
  self.x = x
  self.y = y
  self.z = z
end

function TextWidthAdapter:AddNode(node, initPos)
  self.adapterNodes = self.adapterNodes or {}
  local _, y, _ = _GetLocalPos(node.transform, nil, nil, nil)
  table.insert(self.adapterNodes, {
    node = node,
    initPos = initPos,
    y = y
  })
end

function TextWidthAdapter:OnEnable()
  LateUpdateBeat.Instance:Add(self.LateUpdate, self)
end

function TextWidthAdapter:OnDisable()
  LateUpdateBeat.Instance:Remove(self.LateUpdate, self)
end

function TextWidthAdapter:LateUpdate()
  if not self.tmpTextComp or not self.adapterNodes then
    return
  end
  local preferredWidth = self.tmpTextComp.preferredWidth
  local linesNum = math.max(1, math.ceil(preferredWidth / self.lineWidth))
  preferredWidth = linesNum > 1 and self.lineWidth or preferredWidth
  local scale = math.min(1, self.limitMaxWidth / math.max(0.001, preferredWidth))
  local actualWidth = preferredWidth * scale
  local adjWidth = actualWidth
  if adjWidth < self.limitMinWidth then
    adjWidth = self.limitMinWidth
  end
  local halfSize = (adjWidth - self.limitMinWidth) * 0.5
  for i = 1, #self.adapterNodes do
    local node = self.adapterNodes[i].node
    local posx = self.adapterNodes[i].initPos - halfSize
    _SetLocalPos(node.transform, posx, self.adapterNodes[i].y, 0)
  end
  local x = self.x - (1.0 - scale) * halfSize
  _SetLocalScale(self.rectTrans, scale, scale, scale)
  _SetLocalPos(self.rectTrans, x, self.y, self.z)
end

return TextWidthAdapter
