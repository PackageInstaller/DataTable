local UIFightUserHeadNode = require("Game.Fight.Ui.UIFightUserHeadNode")
local UIFightMainScorePoint = class("UIFightMainScorePoint", UIBaseNode)

function UIFightMainScorePoint:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIFightMainScorePoint:SetActive(active)
  self.ui.winCount.gameObject:SetActive(active)
end

local UIFightMainUserInfoNode = class("UIFightMainUserInfoNode", UIBaseNode)

function UIFightMainUserInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._headNode = UIFightUserHeadNode.New()
  self._headNode:Init(self.ui.head, self._resLoader)
  self._itemPool = UIItemPool.New(UIFightMainScorePoint, self.ui.score)
  self._scoreItems = {}
end

function UIFightMainUserInfoNode:Init(root, resLoader)
  self._resLoader = resLoader
  UIBaseNode.Init(self, root)
end

function UIFightMainUserInfoNode:SetUserInfo(userInfo)
  if userInfo == nil then
    return
  end
  self._headNode:RefreshUserHead(userInfo:GetAvatarId())
  self._headNode:RefreshUserHeadFrame(userInfo:GetAvatarFrameId())
  self.ui.txt_UserName.text = userInfo:GetUserName() or ""
end

function UIFightMainUserInfoNode:SetScore(score, scoreMax)
  if scoreMax ~= #self._scoreItems then
    self:RebuildScoreItem(scoreMax)
  end
  for index, item in ipairs(self._scoreItems) do
    item:SetActive(index <= score)
  end
end

function UIFightMainUserInfoNode:RebuildScoreItem(count)
  self._itemPool:HideAll()
  self._scoreItems = {}
  for _ = 1, count do
    local item = self._itemPool:GetOne()
    table.insert(self._scoreItems, item)
  end
end

function UIFightMainUserInfoNode:Dispose()
  if self._itemPool ~= nil then
    self._itemPool:DeleteAll()
    self._itemPool = nil
  end
end

return UIFightMainUserInfoNode
