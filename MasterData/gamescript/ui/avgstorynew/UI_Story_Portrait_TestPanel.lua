local UI_Story_Portrait_TestPanel, Super = System.NewClass("UI_Story_Portrait_TestPanel", UIBasePanel)
UI_Story_Portrait_TestPanel.uiResCls = UI_Story_Portrait_TestResource

function UI_Story_Portrait_TestPanel:ctor()
  Super.ctor(self)
  self.portraitNo = Vue.ref(nil)
  self.roleId = Vue.ref(nil)
  self.roleType = Vue.ref(nil)
  self.expression = Vue.ref(nil)
end

function UI_Story_Portrait_TestPanel:OnBind(binder)
  self.binder = binder
  local avgUI = UI_Story_Panel_MainResource(self.ui.UI_Story_Panel_Main)
  self.avgUI = avgUI
  avgUI.VideoPlayer1:SetActive(false)
  avgUI.VideoPlayer2:SetActive(false)
  avgUI.Group_Caption2:SetActive(false)
  local avgId = table.next(DT.AvgDialog)
  self.avgModel = self.binder:createModel(AvgDialogModel, avgId, 1)
  self.roleComp = AvgDialogRoleComp(avgUI, self.binder, self.avgModel)
  self.roleComp:Awake()
  binder:BindChildPanel(Urls.SimpleListView, self.ui.Simple_List_Panel, self:GetAvgNewPortraits(), function(data)
    self.portraitNo.value = data.resId
    self.roleId.value = data.roleId
    self.expression.value = nil
    self:SetPortrait()
  end, true)
  binder:BindToImageSync(self.ui.Image_Awaker_Icon, System.fn(self, self.GetAvgEmoj))
  binder:BindButtonClick(self.ui.Image_Click, function()
    if not self.portraitNo.value then
      return
    end
    local faceMap = PortraitUtils.GetFaceMap(self.portraitNo.value)
    local faceList = table.keys(faceMap)
    if #faceList > 0 then
      self.expression.value = faceList[math.random(1, #faceList + 1)]
      self.avgModel:SetTestEmoj(self.expression.value)
      self:SetTalkRole()
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Hide, function()
    self.ui.Simple_List_Panel:SetActive(not self.ui.Simple_List_Panel.activeSelf)
  end)
  binder:BindButtonClick(self.ui.Btn_Close, function()
    self:Close()
  end)
  binder:BindToText(self.ui.Text_EmojName, function()
    return self.expression.value
  end)
  self.RedirectToAvgRole()
  binder:BindButtonClick(self.ui.Btn_Normal, System.bind(self.SetRoleType, self, CommonDefine.AvgRoleType.Normal))
  binder:BindButtonClick(self.ui.Btn_Vertical, System.bind(self.SetRoleType, self, CommonDefine.AvgRoleType.Vertical))
  binder:BindButtonClick(self.ui.Btn_Horizontal, System.bind(self.SetRoleType, self, CommonDefine.AvgRoleType.Horizontal))
end

function UI_Story_Portrait_TestPanel:SetRoleType(roleType)
  self.roleType.value = roleType
  self:SetPortrait()
end

function UI_Story_Portrait_TestPanel:SetPortrait()
  self.avgModel:SetTestRoleId(self.roleId.value, self.roleType.value, self.expression.value)
  self.roleComp:SetRoleList()
  self.roleComp:DoEnterDialog()
  self:SetTalkRole()
end

function UI_Story_Portrait_TestPanel:SetTalkRole()
  local talkRoleInfo = {
    roleId = self.roleId.value,
    headEmoj = nil,
    expression = self.expression.value,
    roleCfg = DT.AvgRole[self.roleId.value] or {}
  }
  self.binder:SetText(self.avgUI.Text_Name, self.avgModel:GetTalkerName(talkRoleInfo))
  self.binder:SetText(self.avgUI.Text_Name_Sec, self.avgModel:GetTalkerTitle(talkRoleInfo))
  self.binder:SetImage(self.avgUI.Image_Awaker_Icon, self.avgModel:GetTalkerIcon(talkRoleInfo))
  self.binder:SetImage(self.avgUI.Image_Exp_Face, self.avgModel:GetTalkerEmotion(talkRoleInfo))
  self.avgUI.Image_Exp_Face:SetActive(nil ~= self.avgModel:GetTalkerEmotion(talkRoleInfo))
end

function UI_Story_Portrait_TestPanel:GetAvgEmoj()
end

local preDTAvgRole
local mockAvgRoleMap = {}
local mockAvgRoleId = -10000

function UI_Story_Portrait_TestPanel:GetAvgNewPortraits()
  local list = {}
  local resMap = {}
  for roleId, cfg in pairs(DT.AvgRole) do
    if cfg.AwakerResource then
      resMap[cfg.AwakerResource] = roleId
    end
  end
  for res, roleId in pairs(resMap) do
    table.insert(list, {
      id = res,
      text = res,
      resId = res,
      roleId = roleId
    })
  end
  local _, mockRourceCfg = table.next(DT.AvgRole)
  for k in pairs(DT.PortraitCenter) do
    local reskey = string.match(k, "Portrait_Full_Awaker_([%w_]+)")
    if not reskey then
      reskey = string.match(k, "Portrait_Full_SpChar_([%w_]+)")
      if reskey then
        reskey = "SpChar_" .. reskey
        print("-------------spchar ", reskey)
      end
    end
    if reskey and not resMap[reskey] then
      print("----------------new mock role ", reskey)
      local mockRoleCfg = table.deepclone(mockRourceCfg)
      mockAvgRoleId = mockAvgRoleId - 1
      mockRoleCfg.ID = mockAvgRoleId
      mockRoleCfg.AwakerResource = reskey
      mockRoleCfg.RoleName = "MockRole"
      mockRoleCfg.Tittle = mockAvgRoleId
      mockAvgRoleMap[mockAvgRoleId] = mockRoleCfg
      table.insert(list, {
        id = reskey,
        text = reskey,
        resId = reskey,
        roleId = mockAvgRoleId
      })
    end
  end
  table.sort(list, function(a, b)
    return a.resId < b.resId
  end)
  return list
end

function UI_Story_Portrait_TestPanel.RedirectToAvgRole()
  if preDTAvgRole then
    return
  end
  preDTAvgRole = DT.AvgRole
  DT.AvgRole = {}
  setmetatable(DT.AvgRole, {
    __index = function(t, k)
      if mockAvgRoleMap[k] then
        return mockAvgRoleMap[k]
      end
      return preDTAvgRole[k]
    end
  })
end

return UI_Story_Portrait_TestPanel
