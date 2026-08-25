local UI_Bag_Item_EmojGroup, Super = System.NewComponent("UI_Bag_Item_EmojGroup")
UI_Bag_Item_EmojGroup.uiResCls = UI_Bag_Item_EmojGroupResource

function UI_Bag_Item_EmojGroup:ctor(uiNode, groupId, emojList, tabIndex, prefab, nowId, interactable)
  Super.ctor(self)
  self.uiNode = uiNode
  self.ui = self.uiResCls(uiNode)
  self.groupId = groupId
  self.emojList = emojList
  self.tabIndex = tabIndex
  self.prefab = prefab
  self.nowId = nowId
  self.interactable = interactable
end

function UI_Bag_Item_EmojGroup:OnBind(binder)
  self.binder = binder
  self.binder:BindToText(self.ui.Text_EmojiType, function()
    do return LT.Text end
    return LT.Text, DT.CommonID[self.groupId] and DT.CommonID[self.groupId].Desc or "", self.groupId
  end)
  self.binder:BindToRaw(function()
    binder:BindTimer(0.01, 0, nil, function()
      if self.emojList then
        local parentTf = self.ui.Emoji_GroupList.transform
        local childCount = parentTf.childCount
        local emojCount = #self.emojList
        for i = 1, math.max(childCount, emojCount) do
          local emojId = self.emojList[i]
          local child
          if childCount >= i then
            child = parentTf:GetChild(i - 1)
          end
          if emojId then
            local gameObj = child and child.gameObject
            gameObj = gameObj or self.binder:Instantiate(self.prefab, parentTf)
            self.binder:SetActive(gameObj, true)
            self.binder:BindComponent(UI_Bag_Item_Appearance(gameObj, emojId, {
              tabIndex = self.tabIndex
            }, self.nowId, self.interactable))
          elseif child then
            self.binder:SetActive(child.gameObject, false)
          end
        end
      end
      self.ui.Emoji_GroupList.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.Emoji_GroupList.transform.sizeDelta.x, 242 * math.ceil((self.emojList and #self.emojList or 0) / 6))
    end)
  end, function()
    return self.emojList
  end)
end

return UI_Bag_Item_EmojGroup
