local ActivityBaseToggle = class("ActivityBaseToggle")

function ActivityBaseToggle:GetName()
	return "ActivityBaseToggle"
end

function ActivityBaseToggle:IsActivity()
	return false
end

function ActivityBaseToggle:Check()
	return false
end

function ActivityBaseToggle:UIClass()
	return nil
end

function ActivityBaseToggle:IsManual()
	return false
end

function ActivityBaseToggle:Order()
	return 0
end

function ActivityBaseToggle:RedPointKey()
	return nil
end

function ActivityBaseToggle:Title()
	return ""
end

function ActivityBaseToggle:Image()
	return ""
end

function ActivityBaseToggle:GetParams()
	return nil
end

function ActivityBaseToggle:GetLimitLevel()
	return 0
end

function ActivityBaseToggle:GetSystemID()
	return 0
end

return ActivityBaseToggle
