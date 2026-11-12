local SoldierRecommendPanel = class("SoldierRecommendPanel", BasePanel)
SoldierRecommendPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierRecommendPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Recommend.SoldierRecommendCtrl"
  }
}

function SoldierRecommendPanel:Awake()
  self._tbRecommendCtrl = {}
end

function SoldierRecommendPanel:BindRecommendCtrl(goNode, sCtrlName)
  local objCtrl = require(sCtrlName).new(goNode, self)
  table.insert(self._tbObjChildCtrl, objCtrl)
  table.insert(self._tbRecommendCtrl, objCtrl)
  objCtrl:_Enter()
  return objCtrl
end

function SoldierRecommendPanel:_PreEnter(callback, goSnapshot)
  BasePanel._PreEnter(self, function()
    for _, objCtrl in ipairs(self._tbRecommendCtrl) do
      objCtrl:ParsePrefab()
    end
    if callback ~= nil then
      callback()
    end
  end, goSnapshot)
end

function SoldierRecommendPanel:_SetPrefabInstance(bDel)
  if bDel then
    for _, objCtrl in ipairs(self._tbRecommendCtrl) do
      if objCtrl._panel ~= nil then
        objCtrl:_Destroy()
      end
    end
    self._tbRecommendCtrl = {}
    self._tbObjCtrl[1]:ClearListCache()
  end
  BasePanel._SetPrefabInstance(self, bDel)
end

function SoldierRecommendPanel:OnEnable()
end

function SoldierRecommendPanel:OnAfterEnter()
end

function SoldierRecommendPanel:OnDisable()
end

function SoldierRecommendPanel:OnDestroy()
end

function SoldierRecommendPanel:OnRelease()
end

return SoldierRecommendPanel
