local UIExport = CS.FrameWork.UIExport
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local typeof = _ENV.typeof
local BtnCloseItem, Super = System.NewComponent("BtnCloseItem")

function BtnCloseItem:ctor(uiNode, clickCallback, imageBindFunc)
  Super.ctor(self)
  self.ui = UI_Common_Btn_Back3Resource(uiNode)
  self.clickCallback = clickCallback
  self.imageBindFunc = imageBindFunc or function()
  end
end

function BtnCloseItem:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.uiExport = self.ui.uiNode:GetComponent(typeof(UIExport))
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClick))
  binder:BindToImage(self.ui.Image_Icon, self.imageBindFunc)
  local group_Btn = self.ui.uiNode.transform:Find("Group_Back/Group_Btn")
  if group_Btn then
    local closeBtnCanvasGroup = group_Btn:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if closeBtnCanvasGroup then
      closeBtnCanvasGroup.alpha = 1
    end
  end
  if self.uiExport and not self.uiExport.isAutoPlayAnim then
    self:PlayOpenAnim()
  end
end

function BtnCloseItem:OnClick()
  if self.clickCallback then
    self.clickCallback()
  end
end

function BtnCloseItem:PlayCloseAnim()
  local clipsToPlay = ""
  
  local function callBack()
  end
  
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Common_Btn_Back_Close")
  self.uiAnimController:PlayMultiState(clipsToPlay, callBack)
end

function BtnCloseItem:PlayOpenAnim()
  local clipsToPlay = ""
  
  local function callBack()
  end
  
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Common_Btn_Back_Open")
  self.uiAnimController:PlayMultiState(clipsToPlay, callBack)
end

return BtnCloseItem
