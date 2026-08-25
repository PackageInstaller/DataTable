local ItemPublicArticleUrl = "UI.Public.Item.ItemPublicArticle"
local CS = _ENV.CS
local typeof = _ENV.typeof
local Animator = CS.UnityEngine.Animator
local RewardItem, Super = System.NewComponent("RewardItem")

function RewardItem:ctor(uiNode, data, ifShowDesc, ifShowAppr, callback)
  Super.ctor(self)
  self.ui = Item_Public_Reward_1Resource(uiNode)
  self.data = data
  self.itemTid = Vue.ref(data.tid)
  self.useOwnNum = Vue.ref(true)
  self.ifShowDesc = ifShowDesc
  self.ifShowAppr = ifShowAppr
  self.callback = callback
  self.item = nil
  self.animator = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  self.canvasGroup = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
  self:InitShowState()
end

function RewardItem:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Name, function()
    local config = ItemDataUtils.GetItemConfig(self.itemTid.value)
    if not config then
      Logger.Info(string.format("<color='#FF0000'>找不到ItemConfig配置, tid:%s. </color>", tostring(self.itemTid.value)))
      return
    end
    do return LT.Text end
    return LT.Text, config.Name, string.format("<color='#FF0000'>找不到ItemConfig配置, tid:%s. </color>", tostring(self.itemTid.value))
  end)
  self.item = binder:BindComponent(require(ItemPublicArticleUrl)(self.ui.Item_Public_Article, self.itemTid.value, StrUtils.NumberConvert(self.data.changedNum), false, self.ifShowDesc, self.ifShowAppr, self.callback))
  self:InitAnimCallback()
end

function RewardItem:InitAnimCallback()
  if not self.animator then
    return
  end
  local animStateHash = Animator.StringToHash("Base Layer.UA_Public_Reward_Item_1")
  local behavior = self.animator:GetAnimatorStateBehavior()
  if not behavior then
    return
  end
  behavior:onStateEnd("+", function(hash)
    if hash == animStateHash then
      self.animator.enabled = false
      self.canvasGroup.alpha = 1
      self.canvasGroup.blocksRaycasts = true
    end
  end)
end

function RewardItem:InitShowState()
  self.animator.enabled = false
  self.canvasGroup.alpha = 0
  self.canvasGroup.blocksRaycasts = false
end

function RewardItem:PlayEnterAnim()
  if not self.animator then
    return
  end
  local startHash = Animator.StringToHash("Open")
  self.animator.enabled = true
  self.animator:SetTrigger(startHash)
end

function RewardItem:GetAnimTime()
  do return CS.Framework.UIUtilTool.GetTotalClipTime end
  return CS.Framework.UIUtilTool.GetTotalClipTime, self.animator
end

function RewardItem:SkipEnterAnim()
  if not self.animator or not self.canvasGroup then
    return
  end
  self.animator.enabled = false
  self.canvasGroup.alpha = 1
  self.canvasGroup.blocksRaycasts = true
end

function RewardItem:SetCallback(callback)
  self.callback = callback
  if self.item then
    self.item:SetCallback(callback)
  end
end

function RewardItem:SetItemTid(tid)
  self.itemTid.value = tid
  if not self.item then
    return
  end
  self.item:SetItemTid(tid)
end

function RewardItem:SetNumText(num)
  if not self.item then
    return
  end
  if type(num) == "number" then
    num = StrUtils.NumberConvert(num)
  end
  self.item:SetNumText(num)
end

function RewardItem:SetVisible(show)
  self.binder:SetActive(self.ui.uiNode, show)
end

return RewardItem
