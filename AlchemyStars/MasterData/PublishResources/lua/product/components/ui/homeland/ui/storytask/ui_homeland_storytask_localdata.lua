_class("UIHomelandStoryTaskLocalData", CampaignDataBase)
UIHomelandStoryTaskLocalData = UIHomelandStoryTaskLocalData

function UIHomelandStoryTaskLocalData:Constructor()
  self._redDotModule = GameGlobal.GetModule(RedDotModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
end

function UIHomelandStoryTaskLocalData:GetStoryTaskInfo()
  local storyTaskInfos = self._homelandModule.m_homeland_info.story_task_info
  return storyTaskInfos
end

function UIHomelandStoryTaskLocalData:CheckHaveNewStoryTask()
  local data = self:GetStoryTaskInfo()
  if not data then
    return false
  end
  local ids = data.id_list
  for key, value in pairs(ids) do
    local had = UIHomelandStoryTaskLocalData.HasPrefsStoryTask(value)
    if not had then
      return true
    end
  end
end

function UIHomelandStoryTaskLocalData:SetNewStoryTask()
  local data = self:GetStoryTaskInfo()
  if not data then
    return false
  end
  local ids = data.id_list
  for key, value in pairs(ids) do
    local had = UIHomelandStoryTaskLocalData.HasPrefsStoryTask(value)
    if not had then
      UIHomelandStoryTaskLocalData.SetPrefsStoryTask(value)
    end
  end
end

function UIHomelandStoryTaskLocalData:GetHaveNewStoryTaskGroup()
end

function UIHomelandStoryTaskLocalData.GetPstId()
  local mRole = GameGlobal.GetModule(RoleModule)
  return mRole:GetPstId()
end

function UIHomelandStoryTaskLocalData.GetPrefsKey(str)
  local playerPrefsKey = UIHomelandStoryTaskLocalData.GetPstId() .. str
  return playerPrefsKey
end

function UIHomelandStoryTaskLocalData.SetPrefsKey(str, num)
  local playerPrefsKey = UIHomelandStoryTaskLocalData.GetPstId() .. str
  UnityEngine.PlayerPrefs.SetInt(playerPrefsKey, num)
end

function UIHomelandStoryTaskLocalData.GetPrefsStoryTask(taskId)
  local str = UIHomelandStoryTaskLocalData.GetStoryTaskCheckStr()
  return UIHomelandStoryTaskLocalData.GetPrefsKey(str .. taskId)
end

function UIHomelandStoryTaskLocalData.HasPrefsStoryTask(taskId)
  return UnityEngine.PlayerPrefs.HasKey(UIHomelandStoryTaskLocalData.GetPrefsStoryTask(taskId))
end

function UIHomelandStoryTaskLocalData.SetPrefsStoryTask(taskId)
  UnityEngine.PlayerPrefs.SetInt(UIHomelandStoryTaskLocalData.GetPrefsStoryTask(taskId), 1)
end

function UIHomelandStoryTaskLocalData.GetPrefsStoryTaskGroup()
  local str = UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckStr()
  return UnityEngine.PlayerPrefs.GetInt(UIHomelandStoryTaskLocalData.GetPrefsKey(str))
end

function UIHomelandStoryTaskLocalData.SetPrefsStoryTaskGroup(num)
  local str = UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckStr()
  UIHomelandStoryTaskLocalData.SetPrefsKey(str, num)
end

function UIHomelandStoryTaskLocalData.GetPrefsStoryTaskGroupNew()
  local str = UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckNew()
  return UnityEngine.PlayerPrefs.GetInt(UIHomelandStoryTaskLocalData.GetPrefsKey(str))
end

function UIHomelandStoryTaskLocalData.HasPrefsStoryTaskGroupNew()
  local str = UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckNew()
  return UnityEngine.PlayerPrefs.HasKey(UIHomelandStoryTaskLocalData.GetPrefsKey(str))
end

function UIHomelandStoryTaskLocalData.SetPrefsStoryTaskGroupNew(num)
  local str = UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckNew()
  UIHomelandStoryTaskLocalData.SetPrefsKey(str, num)
end

function UIHomelandStoryTaskLocalData.GetStoryTaskCheckStr()
  return "HomelandStoryTaskCheckStr"
end

function UIHomelandStoryTaskLocalData.GetStoryTaskCheckNewStr()
  return "HomelandStoryTaskCheckNew"
end

function UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckStr()
  return "HomelandStoryTaskGroupCheckStr"
end

function UIHomelandStoryTaskLocalData.GetStoryTaskGroupCheckNew()
  return "HomelandStoryTaskGroupCheckNew"
end
