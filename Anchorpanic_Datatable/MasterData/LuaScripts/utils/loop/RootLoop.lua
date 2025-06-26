module("RootLoop", Class.impl())

TimerDebug = false
TimerDebugTimeout = 0.03

function ctor(self)
    self.m_tickers = {}
    gs.LuaLoopTick:SetLuaTable(self)
end

function addTicker(self, ticker)
    if not ticker.update then
        Debug:log_error("RootLoop", "ticker must have [update] function")
        return
    end

    for _,v in ipairs(self.m_tickers) do
        if ticker==v then
            return
        end
    end
    table.insert(self.m_tickers, ticker)
end

function removeTicker(self,ticker)
    for i,v in ipairs(self.m_tickers) do
        if ticker==v then
            table.remove(self.m_tickers, i)
            return
        end
    end
end

--循环
function update(self)
    for _,v in ipairs(self.m_tickers) do
        v:update()
    end
end

return _M
