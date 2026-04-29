_class("EditorGlobal", Singleton)
EditorGlobal = EditorGlobal

function EditorGlobal:Constructor()
  self.StroyController = nil
  self.StroyManager = nil
  self.EnterParamData = nil
  self.IsEditorRun = false
  self.RunStoryConfig = nil
end

function EditorGlobal.SetStroyController(controller)
  EditorGlobal:GetInstance().StroyController = controller
end

function EditorGlobal.SetStroyManager(manager)
  EditorGlobal:GetInstance().StroyManager = manager
end

function EditorGlobal.GetStroyController()
  return EditorGlobal:GetInstance().StroyController
end

function EditorGlobal.GetStroyManager()
  return EditorGlobal:GetInstance().StroyManager
end

function EditorGlobal.SetEnterParam(param)
  EditorGlobal:GetInstance().EnterParamData = param
end

function EditorGlobal.GetEnterParam()
  return EditorGlobal:GetInstance().EnterParamData
end

function EditorGlobal.SetEditorMode(param)
  EditorGlobal:GetInstance().IsEditorRun = param
end

function EditorGlobal.IsEditorMode()
  return EditorGlobal:GetInstance().IsEditorRun
end

function EditorGlobal.SetEditorRunStoryConfig(param)
  EditorGlobal:GetInstance().RunStoryConfig = param
end

function EditorGlobal.GetEditorRunStoryConfig()
  return EditorGlobal:GetInstance().RunStoryConfig
end

function EditorGlobal.IsHomeMovieMode()
  return false
end

function EditorGlobal.GetFurnitureList()
  return {
    [104203] = 5273030,
    [104204] = 5273031,
    [104205] = 5273034,
    [105203] = 5273039,
    [105204] = 5273042,
    [105205] = 5273043,
    [105206] = 5273046,
    [106203] = 5273051,
    [106204] = 5273053,
    [106205] = 5273055,
    [106206] = 5211004
  }
end
