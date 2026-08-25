local T_UIExport = typeof(CS.FrameWork.UIExport)
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AddClipToPlay = AnimatorUtils.AddClipToPlay

local function __callBackEmpty()
end

local UICompBtnCloseItem, Super = NewViewComponent("UICompBtnCloseItem")

function UICompBtnCloseItem:ctor(uiNode, view, clickCallback, imageBindFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Btn_Back3Resource(uiNode)
  self.clickCallback = clickCallback
  self.imageBindFunc = imageBindFunc or function()
  end
end

function UICompBtnCloseItem:OnEnterComponent()
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.uiExport = self.ui.uiNode:GetComponent(T_UIExport)
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self.OnClick))
  if self.imageBindFunc then
    local imgPath = self.imageBindFunc()
    if imgPath then
      self:SetImage(self.ui.Image_Icon, imgPath)
    end
  end
  local group_Btn = self.ui.uiNode.transform:Find("Group_Back/Group_Btn")
  if group_Btn then
    local closeBtnCanvasGroup = group_Btn:GetComponent(T_CanvasGroup)
    if closeBtnCanvasGroup then
      closeBtnCanvasGroup.alpha = 1
    end
  end
  if self.uiExport and not self.uiExport.isAutoPlayAnim then
    self:PlayOpenAnim()
  end
end

function UICompBtnCloseItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UICompBtnCloseItem:OnClick()
  if self.clickCallback then
    self.clickCallback()
  end
end

function UICompBtnCloseItem:PlayCloseAnim()
  local clipsToPlay = ""
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Common_Btn_Back_Close")
  
  local function __callBack()
    if not IsNil(self.uiAnimController) then
      self.uiAnimController:StopPlayableGraph()
      self.uiAnimController = nil
    end
  end
  
  self.uiAnimController:PlayMultiState(clipsToPlay, __callBack)
end

function UICompBtnCloseItem:PlayOpenAnim()
  local clipsToPlay = ""
  clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Common_Btn_Back_Open")
  self.uiAnimController:PlayMultiState(clipsToPlay, __callBackEmpty)
end

return UICompBtnCloseItem
