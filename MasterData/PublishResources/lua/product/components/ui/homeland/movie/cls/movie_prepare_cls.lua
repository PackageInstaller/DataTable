_class("MoviePrepareData", Singleton)
MoviePrepareData = MoviePrepareData

function MoviePrepareData:Constructor()
  self.movieId = 101
  self.prepareTarget = nil
  self.pstId = 0
  self._build = nil
  self.arch_list = nil
  self._isRoast = true
  self._playbackData = nil
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
end

function MoviePrepareData:Clear()
  self.movieId = 0
  self.prepareTarget = nil
  self._build = nil
end

function MoviePrepareData:EnsurePrepareArchList()
  self.arch_list = self.mUIHomeland:GetFreeChildren(self._build)
end

function MoviePrepareData:ClearData(prepareType)
  if prepareType == MoviePrepareType.PT_Scene then
    self.mUIHomeland:ClearWallAndFloorInScene(self._build)
  elseif prepareType == MoviePrepareType.PT_Prop then
  elseif prepareType == MoviePrepareType.PT_Furniture then
    self.mUIHomeland:ClearFreeChildrenInScene(self._build)
  elseif prepareType == MoviePrepareType.PT_Actor then
  end
end

function MoviePrepareData:SetMovieData(movieId, pstId, build)
  self.movieId = movieId
  self.pstId = pstId
  self._build = build
end

function MoviePrepareData:SetReplayData(fatherBuilding, isRoast, arch_list, playbackData)
  self._build = fatherBuilding
  self._isRoast = isRoast
  self._playbackData = playbackData
  self.arch_list = arch_list
  self.movieId = playbackData.movice_id
  self.pstId = playbackData.pstid
end

function MoviePrepareData:SetOpenTease(isRoast)
  self._isRoast = isRoast
end

function MoviePrepareData:GetFatherBuild()
  return self._build
end

function MoviePrepareData:GetPstId()
  return self.pstId
end

function MoviePrepareData:GetMovieId()
  return self.movieId
end

function MoviePrepareData:GetPlayBackData()
  return self._playbackData
end

function MoviePrepareData:GetPrepareArchList()
  return self.arch_list
end

function MoviePrepareData:GetOpenTease()
  return self._isRoast
end
