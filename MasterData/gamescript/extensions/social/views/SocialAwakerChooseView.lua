local SocialAwakerChooseView, Super = NewClass("SocialAwakerChooseView", BaseView)
SocialAwakerChooseView.uiResCls = UI_Social_Popup_AwakerResource
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local Vec2_ResetScrollPos = CS.UnityEngine.Vector2(0, 1)
local TransformUtil = CS.Framework.TransformUtil
local _SetAnchoredPos = TransformUtil.SetAnchoredPos
local _GetAnchoredPos = TransformUtil.GetAnchoredPos
local School_Filter_Type = {
  All = "All",
  Chaos = cd.SchoolType.Chaos,
  Blood = cd.SchoolType.Blood,
  Dimension = cd.SchoolType.Dimension,
  Ocean = cd.SchoolType.Ocean
}

function SocialAwakerChooseView:ctor()
  Super.ctor(self)
  self.selectAwakerTid = self:_GetFirstEnterSelectAwaker()
  self.filterOwnedAwaker = false
  self.schoolFilter = School_Filter_Type.All
end

function SocialAwakerChooseView:OnBuildView()
  self.filterToggleUICfgs = {
    [School_Filter_Type.All] = {
      go = self.ui.Toggle_All
    },
    [School_Filter_Type.Chaos] = {
      go = self.ui.Toggle_Hundun
    },
    [School_Filter_Type.Ocean] = {
      go = self.ui.Toggle_Shenhai
    },
    [School_Filter_Type.Blood] = {
      go = self.ui.Toggle_Xuerou
    },
    [School_Filter_Type.Dimension] = {
      go = self.ui.Toggle_Chaowei
    }
  }
end

function SocialAwakerChooseView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Owned, System.fn(self, self._OnClickFilterOwned))
  self:_InitFilterToggles()
  self:_CreateRankTableView()
end

function SocialAwakerChooseView:RegisterNotifications()
end

function SocialAwakerChooseView:OnEnterView()
  Super.OnEnterView(self)
  self:_SetBgComp()
  self:_RefreshView(true)
end

function SocialAwakerChooseView:OnExitView()
  Super.OnExitView(self)
end

function SocialAwakerChooseView:_RefreshView(isReloadData)
  self:SetButtonChosen(self.ui.Btn_Owned, self.filterOwnedAwaker)
  self:_RefreshAwakerList(isReloadData)
end

function SocialAwakerChooseView:_RefreshAwakerList(isReloadData)
  if not self.awakerTableView then
    return
  end
  if isReloadData then
    self.awakerList = self:_GetAwakerList() or {}
    Logger.Debug("[sr] awakerList=%s", table.tostring(self.awakerList))
    self:_CheckFixAwakerTid()
    self.awakerTableView:ReloadData()
  else
    self.awakerTableView:Refresh()
  end
end

function SocialAwakerChooseView:_SetBgComp()
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self._OnClickClose)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, commonPopupConfirmTipsData)
end

function SocialAwakerChooseView:_InitFilterToggles()
  for schoolFilterType, cfg in pairs(self.filterToggleUICfgs) do
    local go = cfg.go
    Logger.Debug("[sr] toggle filterType=%s, go=%s", schoolFilterType, go)
    self:AddZ1ToggleValueChangedListener(go, function(isOn)
      if isOn then
        self:_SetSchoolFilter(schoolFilterType)
      end
    end)
    if schoolFilterType == self.schoolFilter then
      self:SetZ1Toggle(go, true)
    end
  end
end

function SocialAwakerChooseView:_CreateRankTableView()
  self.awakerTableView = self:CreateTableview(self.ui.ScrollView_Awaker_List, function()
    if not self.awakerList then
      return 0
    end
    return #self.awakerList
  end, function(view, index)
    do return self._RankCellAtIndex, self, view end
    return self._RankCellAtIndex, self, view, index
  end)
end

function SocialAwakerChooseView:_RankCellAtIndex(view, index)
  local awakerTid = self.awakerList[index]
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Social_Item_AwakerAvatar)
  local uiRes = UI_Social_Item_AwakerAvatarResource(cell.gameObject)
  self:AddPressDownListener(uiRes.Btn_Select, System.bind(self._OnClickAwaker, self, awakerTid))
  uiRes.Image_Select:SetActive(awakerTid == self.selectAwakerTid)
  Logger.Debug("[sr] index=%s, awakerTid=%s, icon=%s, favour=%s", index, awakerTid, AwakerDataUtils.GetLittleIcon(awakerTid), AwakerDataUtils.GetAwakerLike(awakerTid))
  self:SetImage(uiRes.Image_Avatar, AwakerDataUtils.GetLittleIcon(awakerTid))
  self:SetText(uiRes.Text_Favor, AwakerDataUtils.GetAwakerLike(awakerTid))
  return cell
end

function SocialAwakerChooseView:_CheckFixAwakerTid()
  local isValid = false
  for _, awakerTid in ipairs(self.awakerList) do
    if awakerTid == self.selectAwakerTid then
      isValid = true
      break
    end
  end
  if isValid then
    return
  end
  self.selectAwakerTid = self.awakerList[1] or 0
end

function SocialAwakerChooseView:_GetAwakerList()
  local list = {}
  local tmp = {}
  if self.filterOwnedAwaker then
    tmp = SocialExtModel.Instance:GetOwnedAwakerLikeRankList()
  else
    tmp = SocialExtModel.Instance:GetAwakerLikeRankList()
  end
  if self.schoolFilter == School_Filter_Type.All then
    return tmp
  end
  for _, awakerTid in ipairs(tmp) do
    local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
    if awakerConfig and awakerConfig.School then
      local schoolConfig = DT.SchoolConfig[awakerConfig.School]
      if schoolConfig.NameEn == self.schoolFilter then
        table.insert(list, awakerTid)
      end
    end
  end
  return list
end

function SocialAwakerChooseView:_GetFirstEnterSelectAwaker()
  do return SocialExtModel.Instance.GetAwakerLikeRankTid end
  return SocialExtModel.Instance.GetAwakerLikeRankTid, SocialExtModel.Instance
end

function SocialAwakerChooseView:_SetSelectAwaker()
  SocialExtModel.Instance:SetAwakerLikeRankTid(self.selectAwakerTid)
end

function SocialAwakerChooseView:_SetSchoolFilter(school)
  if not school then
    return
  end
  self.schoolFilter = school
  self:_RefreshAwakerList(true)
end

function SocialAwakerChooseView:_OnClickAwaker(awakerTid)
  self.selectAwakerTid = awakerTid
  self:_RefreshAwakerList()
  self:_SetSelectAwaker()
  self:Close()
end

function SocialAwakerChooseView:_OnClickFilterOwned()
  self.filterOwnedAwaker = not self.filterOwnedAwaker
  self:SetButtonChosen(self.ui.Btn_Owned, self.filterOwnedAwaker)
  self:_RefreshAwakerList(true)
end

function SocialAwakerChooseView:_OnClickClose()
  self:Close()
end

return SocialAwakerChooseView
