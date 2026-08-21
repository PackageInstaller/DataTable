_class("UICN17N46FishingGameOrderItem", UICustomWidget)
UICN17N46FishingGameOrderItem = UICN17N46FishingGameOrderItem

function UICN17N46FishingGameOrderItem:Constructor()
  self.hadFinished = false
end

function UICN17N46FishingGameOrderItem:OnShow(uiParams)
  self:InitWidget()
  self:CalBgPos()
end

function UICN17N46FishingGameOrderItem:OnHide()
  if self.taskid ~= nil then
    GameGlobal.TaskManager():KillTask(self.taskid)
    self.taskid = nil
  end
end

function UICN17N46FishingGameOrderItem:CalBgPos()
  self._offsetY = 20
  local tmp = self._bg.gameObject.transform.localPosition
  tmp.y = tmp.y + self._offsetY
  self._tmpPos = {
    [0] = Vector3(tmp.x, 22, tmp.z),
    [1] = Vector3(tmp.x, 5, tmp.z)
  }
end

function UICN17N46FishingGameOrderItem:InitWidget()
  self._bg = self:GetUIComponent("Image", "bg")
  self._fishImg = self:GetUIComponent("Image", "fishImg")
  self._finishImg = self:GetGameObject("finishImg")
  self._atlas = self:GetAsset("UIN14FishingGame.spriteatlas", LoadType.SpriteAtlas)
  self._animation = self.view.gameObject:GetComponent("Animation")
  self._effectGo = self:GetGameObject("effect")
  self._bgError = self:GetGameObject("bgError")
  self._effectOriPos = self._effectGo.transform.localPosition
  self._bgError:SetActive(false)
end

function UICN17N46FishingGameOrderItem:SetData(index, fishId, isCurrent, isFinish, islast)
  self:ResetWeight()
  self._index = index
  self._fishId = fishId
  self._isCurrent = isCurrent
  self._isFinish = isFinish
  self._islastOrder = islast
  self._fishCfg = Cfg.cfg_fishing_fish({ID = fishId})[1]
  self:InitWidget()
  self:_OnValue()
  self._bg.transform.localRotation = self._isFinish and Quaternion.Euler(0, 180, 0) or Quaternion.identity
  self._finishImg.transform.localRotation = self._isFinish and Quaternion.Euler(0, 180, 0) or Quaternion.identity
end

function UICN17N46FishingGameOrderItem:_OnValue()
  local fishId = self._fishId
  self._fishImg.gameObject:SetActive(self._isFinish == false)
  self._finishImg:SetActive(self._isFinish == true)
  self._bgError:SetActive(true)
  self._bg.gameObject.transform.localPosition = self._tmpPos[self._index % 2]
  if self._isCurrent then
    self._bg.sprite = self._atlas:GetSprite("n14_fish_huima2")
  else
    self._bg.sprite = self._atlas:GetSprite("n14_fish_huima1")
  end
  self._fishImg.sprite = self._atlas:GetSprite(self._fishCfg.Sprite)
  if not self.hadFinished and self._isFinish then
    self.hadFinished = true
  end
end

function UICN17N46FishingGameOrderItem:PlayAnimation(index, needlast)
  local aniNames = {
    "uieff_orderFinish",
    "uieff_orderRefresh",
    "uieff_errorfish",
    "uieff_orderRefresh_time"
  }
  local last = 500
  if index == 4 then
    last = 1200
  end
  self.taskid = self:StartTask(function(TT)
    self:Lock("UICN17N46FishingGameOrderItem:PlayAnimation")
    self:ResetWeight()
    YIELD(TT, 100)
    if self.taskid ~= nil then
      self._animation:Play(aniNames[index])
    end
    YIELD(TT, last)
    if self.taskid ~= nil and index == 4 then
      self:ResetWeight()
    end
    self:UnLock("UICN17N46FishingGameOrderItem:PlayAnimation")
    self.taskid = nil
  end, self)
end

function UICN17N46FishingGameOrderItem:EffectDoTween(path, duration, ease, callback)
  local usePath = {}
  local next = math.random(1, 2)
  table.insert(usePath, path[next])
  table.insert(usePath, path[3])
  self._effectGo:SetActive(true)
  self._effectGo.transform:DOPath(usePath, duration):SetEase(ease):OnComplete(function()
    if callback then
      callback(self._effectGo.transform.position)
      self._effectGo:SetActive(false)
      self._effectGo.transform.localPosition = self._effectOriPos
    end
  end)
end

function UICN17N46FishingGameOrderItem:ResetWeight()
  self:GetUIComponent("Image", "bg").color = Color(1.0, 1.0, 1.0, 1)
  self:GetUIComponent("Image", "bgError").color = Color(1.0, 1.0, 1.0, 0)
  self:GetUIComponent("Image", "finishImg").color = Color(1.0, 1.0, 1.0, 1)
  self._finishImg.transform.localRotation = Quaternion.identity
  self._finishImg.transform.localScale = Vector3(1, 1, 1)
  self._finishImg:SetActive(false)
  self._fishImg.transform.localRotation = Quaternion.identity
  self._fishImg.transform.localScale = Vector3(1, 1, 1)
end
