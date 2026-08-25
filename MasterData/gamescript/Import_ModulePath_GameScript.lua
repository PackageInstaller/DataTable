local LuaComponentContainer = CS.Framework.LuaComponentContainer
local GameObject_Destroy = CS.UnityEngine.GameObject.Destroy
local GameObject_DestroyImmediate = CS.UnityEngine.GameObject.DestroyImmediate
local GameObject_Instantiate = CS.UnityEngine.GameObject.Instantiate
local _SetPositionedActive = CS.Framework.GameObjectUtil.SetPositionedActive
local _SetLocalScale = CS.Framework.TransformUtil.SetLocalScale
local _IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local _AddComponentOnce = CS.Framework.GameObjectUtil.AddComponentOnce
local _MainCoroutine = coroutine.running()

local function IsMainCoroutine(co)
  return co == _MainCoroutine
end

local function IsInMainCoroutine()
  return coroutine.running() == _MainCoroutine
end

local function SetPositiondActive(obj, active)
  _SetPositionedActive(obj, active)
end

local function SetScaledActive(obj, active)
  if active and not obj.activeSelf then
    obj:SetActive(true)
  end
  if active then
    _SetLocalScale(obj.transform, 1, 1, 1)
  else
    _SetLocalScale(obj.transform, 0, 0, 0)
  end
end

local function IsNil(obj)
  return not obj or _IsNull(obj)
end

local function GetLuaComp(go, luaCls)
  local theCls = LuaComponentContainer.Get(go.gameObject, luaCls)
  return theCls
end

local function AddLuaComp(go, luaCls)
  local theCls = LuaComponentContainer.Add(go.gameObject, luaCls)
  return theCls
end

local function AddLuaCompOnce(go, luaCls)
  local theCls = GetLuaComp(go, luaCls)
  theCls = theCls or LuaComponentContainer.Add(go.gameObject, luaCls)
  return theCls
end

local function RemoveLuaComp(go, luaCls)
  if go and luaCls then
    LuaComponentContainer.Remove(go.gameObject, luaCls)
  end
end

local function Destroy(obj)
  if not IsNil(obj) then
    GameObject_Destroy(obj)
  end
end

local function DestroyImmediate(obj, allowDestroyingAssets)
  if not IsNil(obj) then
    GameObject_DestroyImmediate(obj, allowDestroyingAssets or false)
  end
end

local function Instantiate(obj, parent)
  if not IsNil(obj) then
    do return GameObject_Instantiate, obj end
    return GameObject_Instantiate, obj, parent
  end
end

local function AddComponentOnce(obj, compType)
  if compType and not IsNil(obj) then
    do return _AddComponentOnce, obj end
    return _AddComponentOnce, obj, compType
  end
end

local function NewViewComponent(name, super)
  do return NewClass, name end
  return NewClass, name, super or ViewComponent
end

local function LuaPandaPrint(info, value)
  if ApplicationUtils.is_editor_mode() and CS.Z1Client.LuaBehaviour.enableLuaboomer then
    LuaPanda.tools.printTable(value, info)
  end
end

UsingNow("Foundation.System.System", "System")
SetGlobal("LT", LangTable)
SetGlobal("DT", DataTable)
UsingNow("Vue.reactivity.binder", "Binder")
UsingNow("GameScript.Managers.UI.UIBinder", "UIBinder")
UsingNow("GameScript.Managers.UI.UIBaseResource", "UIBaseResource")
UsingNow("Foundation.System.FrameWaiter", "FrameWaiter")
UsingNow("GameScript.Utils.TimeUtils", "TimeUtils")
UsingNow("Foundation.System.Alert", "Alert")
UsingNow("Foundation.System.LangTable", "LangTable")
UsingNow("Foundation.System.DataTable", "DataTable")
UsingNow("GameScript.Utils.ApplicationUtils", "ApplicationUtils")
UsingNow("GameScript.Utils.Utils", "Utils")
UsingNow("GameScript.Utils.UIUtils", "UIUtils")
UsingNow("GameScript.Utils.AttrUtils", "AttrUtils")
UsingNow("Foundation.Utility.Logger", "Logger")
UsingNow("Foundation.Utility.Manager", "Manager")
UsingNow("GameScript.Utils.StrUtils", "StrUtils")
UsingNow("GameLauncher.PatchConst", "PatchConst")
UsingNow("Foundation.Animation.AnimatorUtils", "AnimatorUtils")
UsingNow("Vue.Vue", "Vue")
UsingNow("Battle.BattleConst", "BattleConst")
UsingNow("GameScript.Battle.DbgRender.BattleGlobal", "BattleGlobal")
UsingNow("Foundation.System.Awaiter", "Awaiter")
UsingNow("Foundation.System.AwaiterList", "AwaiterList")
UsingNow("GameScript.Battle.DbgRender.RenderConst", "RenderConst")
UsingNow("GameScript.Utils.GetEnergyCheckUtils", "GetEnergyCheckUtils")
SetGlobal("NewClass", System.NewClass)
SetGlobal("NewPoolClass", System.NewPoolClass)
SetGlobal("NewViewComponent", NewViewComponent)
SetGlobal("IsNil", IsNil)
SetGlobal("SetPositiondActive", SetPositiondActive)
SetGlobal("SetScaledActive", SetScaledActive)
SetGlobal("GetLuaComp", GetLuaComp)
SetGlobal("AddLuaComp", AddLuaComp)
SetGlobal("AddLuaCompOnce", AddLuaCompOnce)
SetGlobal("RemoveLuaComp", RemoveLuaComp)
SetGlobal("Destroy", Destroy)
SetGlobal("Instantiate", Instantiate)
SetGlobal("AddComponentOnce", AddComponentOnce)
SetGlobal("DestroyImmediate", DestroyImmediate)
SetGlobal("GameObject", CS.UnityEngine.GameObject)
SetGlobal("unpack", table.unpack)
SetGlobal("UnityTime", CS.UnityEngine.Time)
SetGlobal("bc", BattleConst)
SetGlobal("bg", BattleGlobal)
SetGlobal("rc", RenderConst)
SetGlobal("cd", CommonDefine)
SetGlobal("Binder", Binder)
SetGlobal("IsMainCoroutine", IsMainCoroutine)
SetGlobal("IsInMainCoroutine", IsInMainCoroutine)
SetGlobal("LuaPandaPrint", LuaPandaPrint)
UsingNow("GameScript.Utils.ColorUtils", "ColorUtils")
UsingNow("Foundation.Animation.DOTweenUtils", "DOTweenUtils")
UsingNow("GameScript.Utils.SkillUtils", "SkillUtils")
bc.ICON_PATH_PERFIX = "UIResources/AtlasSource/UI_Battle_Icon/"
