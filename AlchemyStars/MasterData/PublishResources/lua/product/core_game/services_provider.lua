_class("ServicesProvider", Object)
ServicesProvider = ServicesProvider

function ServicesProvider:Constructor()
end

function ServicesProvider:AddService(name, service)
  self[name] = service
  return self
end

function ServicesProvider:InitServices()
  for name, service in pairs(self) do
    if service.Initialize then
      service:Initialize()
    end
  end
  for name, service in pairs(self) do
    if service.InitOver then
      service:InitOver()
    end
  end
end

function ServicesProvider:GetService(name)
  return self[name]
end

function ServicesProvider:Dispose()
  for k, v in pairs(self) do
    local service = v
    if service.Dispose then
      service:Dispose()
    end
  end
end
