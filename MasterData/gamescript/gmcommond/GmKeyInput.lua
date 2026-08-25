local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local TimeUtil = CS.Framework.TimeUtil
local GmKeyInput = {}
local CurNum = -1
local ResetCurNumTimer
local NumKeyCodes = {
  KeyCode.Alpha0,
  KeyCode.Alpha1,
  KeyCode.Alpha2,
  KeyCode.Alpha3,
  KeyCode.Alpha4,
  KeyCode.Alpha5,
  KeyCode.Alpha6,
  KeyCode.Alpha7,
  KeyCode.Alpha8,
  KeyCode.Alpha9
}

function GmKeyInput.ProcessKeyInput()
  if Input.GetKeyDown(KeyCode.Q) then
    local reloadFromGitSinceHead = _G.ReloadGameScriptFilesFromGitSinceHead
    package.loaded.LocalTest = nil
    local mdu = require("LocalTest")
    if type(mdu) == "function" then
      do return end
      return mdu, mdu, nil, nil, nil, nil
    end
  end
  if Input.GetKey(KeyCode.LeftControl) and Input.GetKeyDown(KeyCode.G) then
    GmClientUtils.QuickOpenGM()
  end
  if (Input.GetKey(KeyCode.Return) or Input.GetKey(KeyCode.KeypadEnter)) and UIManager.Instance:GetWindow(Urls.LoginPanel) then
    local loginPanel = UIManager.Instance:GetWindow(Urls.LoginPanel)
    if loginPanel then
      loginPanel:OnClickBtnLogin()
    end
  end
  if Input.GetKey(KeyCode.LeftControl) and Input.GetKeyDown(KeyCode.A) then
    GmClientUtils.SkipAvg()
  end
  if Input.GetKey(KeyCode.LeftControl) and Input.GetKeyDown(KeyCode.E) then
    LangManager.Instance:SwitchShowLangKey()
  end
  local isEnableTimeScale = Input.GetKey(KeyCode.LeftShift)
  if not bg.battlePanel then
    isEnableTimeScale = true
  end
  if isEnableTimeScale then
    for i = 1, 9 do
      if UIManager.Instance:GetWindow(Urls.GmPanel) or UIManager.Instance:GetWindow(Urls.GmParamPanel) then
        break
      end
      if Input.GetKeyDown(NumKeyCodes[i + 1]) then
        GmKeyInput.DealNumInput(i)
      end
    end
  end
end

function GmKeyInput.DealNumInput(num)
  TimeUtil.SetTimeScale(num * (CurNum == num and 0.1 or 1))
  CurNum = num
  TimerManager.Instance:StopTimer(ResetCurNumTimer)
  TimerManager.Instance:CreateTimer(0.3, 0, nil, function()
    CurNum = -1
  end)
end

function GmKeyInput:ShowGrid()
  local stageComp = require("Managers.WorldStage.WorldStageManager").Instance:GetCurStageComp()
  local mapEntity = stageComp and stageComp.map
  if not mapEntity then
    return
  end
  local hintPrefabPath = "GameBasePrefab/HintBase3d.prefab"
  local allTerrain = mapEntity:GetAllTerrain()
  local zero = CS.UnityEngine.Vector3.zero
  local one = CS.UnityEngine.Vector3.one
  local TMP_Text = CS.TMPro.TMP_Text
  for _, terrain in pairs(allTerrain or {}) do
    local tf = terrain.tf
    local prefab = ResLoadMgr.LoadAsset(hintPrefabPath, stageComp)
    local textObject = CS.UnityEngine.GameObject.Instantiate(prefab)
    textObject.transform:SetParent(tf.transform)
    textObject.transform.localPosition = zero
    textObject.transform.localScale = one
    local textComp = textObject:GetComponent(typeof(TMP_Text))
    textComp.text = tf.name
  end
end

return GmKeyInput
