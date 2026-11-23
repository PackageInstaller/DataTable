ApiMgr = {}

function ApiMgr.Request(url, data, auth, onSucc, onFail, isLoadAwait, isRetry)
    local dataStr = json.encode(data);
    LuaMgr.ApiRequest(url, dataStr, auth, onSucc, onFail, isLoadAwait, isRetry == nil and true or isRetry);
end