_class("UIActivityDataLoaderBase", Object)
UIActivityDataLoaderBase = UIActivityDataLoaderBase

function UIActivityDataLoaderBase:SetData(params)
end

function UIActivityDataLoaderBase:LoadData(TT)
  Log.exception(self._className .. "必须重写 LoadData() 方法:", debug.traceback())
end

function UIActivityDataLoaderBase:CheckOpen()
  Log.exception(self._className .. "必须重写 CheckOpen() 方法:", debug.traceback())
end
