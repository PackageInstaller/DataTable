local this = class("situationDataContainer_stamp", require("ui.manager.situation.data.situationDataContainer"))
local _stampPath = "UI/Pages/Situation/cell/pre_situationStamp.prefab"
local _photoPicTpl = L_GameTpl:getPhotographPicTpl()

function this:define()
  self.dataType = L_Const.situationDataType.stamp
end

function this:initData(param)
  self.data = require("ui.manager.situation.data.situationData_stamp").new()
  self.data.configId = param.configId
  self.data.pos = param.pos
  self.data.scale = param.scale
  self.data.index = param.index
end

function this:load(sceneData)
  self.sceneData = sceneData
  self:createStamp()
end

function this:release()
  if self.rectTrans then
    self.btn.onClick:RemoveAllListeners()
    C_BoundGameObject.Destroy(self.rectTrans.gameObject)
    self.rectTrans = nil
  end
end

function this:createStamp()
  local obj = L_ResPool:syncGameObject(_stampPath, self.sceneData.stampRoot)
  local rectTrans = obj.transform
  self.rectTrans = rectTrans
  self.image = obj:GetComponent(typeof(C_LImage))
  self.btn = obj:GetComponent(typeof(C_LButton))
  local icon = _photoPicTpl:getIcon(_photoPicTpl:getTplById(self.data.configId))
  self.image:LoadSprite(icon)
  self.image:SetNativeSize()
  self.rectTrans.anchoredPosition = C_Vector2(self.data.pos.x, self.data.pos.y)
  self.rectTrans.localScale = C_Vector3(self.data.scale, self.data.scale, 1)
  self.btn.onClick:AddListener(function()
    L_SituationStore:call(L_SituationStore.event.onClickStamp, self)
  end)
end

function this:setPosition(v2)
  if self.rectTrans then
    self.rectTrans.anchoredPosition = C_Vector2(v2.x, v2.y)
  end
  self.data.pos = {
    x = v2.x,
    y = v2.y
  }
end

function this:setScale(v)
  if self.rectTrans then
    self.rectTrans.localScale = C_Vector3(v, v, 1)
  end
  self.data.scale = v
end

return this
