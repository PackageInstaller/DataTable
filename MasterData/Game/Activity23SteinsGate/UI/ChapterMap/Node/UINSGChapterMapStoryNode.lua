local base = require("Game.Activity23SteinsGate.UI.ChapterMap.Node.UINSGChapterMapNodeBase")
local UINSGChapterMapStoryNode = class("UINSGChapterMapStoryNode", base)

function UINSGChapterMapStoryNode:OnInit()
  base.OnInit(self)
end

function UINSGChapterMapStoryNode:InitNSGChapterMapNode(storyData, nodeData)
  base.InitNSGChapterMapNode(self, storyData, nodeData)
end

function UINSGChapterMapStoryNode:__RefreshNodeTitle()
  self.ui.tex_Stage.text = self.nodeData:Act23GSSN_GetNodeTitle(".\n")
end

function UINSGChapterMapStoryNode:Act23SGSetClickCallback(callback)
  self.callback = callback
end

function UINSGChapterMapStoryNode:__OnClick()
  if self.callback ~= nil then
    self.callback(self.nodeData, self)
  end
end

function UINSGChapterMapStoryNode:OnDelete()
  base.OnDelete(self)
end

return UINSGChapterMapStoryNode
