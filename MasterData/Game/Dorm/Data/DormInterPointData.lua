local DormInterPointData = class("DormInterPointData")

function DormInterPointData:ctor()
end

function DormInterPointData:InitInterPoint(interCfg, coord, start_coord, fntData)
  self.id = interCfg.id
  self.interCfg = interCfg
  self.coord = coord
  self.start_coord = start_coord
  self.fntData = fntData
end

function DormInterPointData:BindInterPoint(charEntity)
  self.__active = false
  self.__bindCharacter = charEntity
end

function DormInterPointData:UnBindInterPoint()
  self.__active = true
  self.__bindCharacter = nil
end

function DormInterPointData:GetPointActive()
  return self.__active and self.fntData:GetFntInteractState()
end

function DormInterPointData:IsPointFntAniStateReady()
  return self.fntData:GetFntInteractState()
end

function DormInterPointData:GetFntPointInteractTips()
  return self.fntData:GetFntTouchInteractTips()
end

function DormInterPointData:HasBindCharacter()
  return self.__bindCharacter ~= nil
end

function DormInterPointData:GetBindCharacter()
  return self.__bindCharacter
end

function DormInterPointData:GetInterPointType()
  return self.interCfg.interact_point_type
end

function DormInterPointData:GetInterAngle()
  return self.interCfg.interact_front * 90
end

function DormInterPointData:GetReverseValue()
  return self.interCfg.is_reverse and 1 or 0
end

function DormInterPointData:GetInterAnimType()
  return self.interCfg.anime_type
end

function DormInterPointData:GetInterBindPath()
  return self.interCfg.bind_path
end

function DormInterPointData:GetInterOffsetCoord()
  return Vector3.New(self.coord[1], self.coord[2], self.coord[3])
end

function DormInterPointData:GetInterStartCoord()
  return Vector3.New(self.start_coord[1], 0, self.start_coord[2])
end

function DormInterPointData:GetInterMoveCurveId()
  return self.interCfg.move_curve
end

function DormInterPointData:GetInterExitCurveId()
  return self.interCfg.exit_curve
end

function DormInterPointData:GetInteractName()
  return LanguageUtil.GetLocaleText(self.interCfg.interact_name)
end

function DormInterPointData:GetInterAudioId()
  return self.interCfg.interact_audio_id
end

function DormInterPointData:GetFntCfg()
  return self.fntData.fntCfg
end

return DormInterPointData
