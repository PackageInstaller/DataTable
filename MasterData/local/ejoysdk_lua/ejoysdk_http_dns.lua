local E = require("ejoysdk_lua.ejoysdk")
local Uri = require("ejoysdk_lua.libs.uri")
local HttpDns = {}
local DnsCache = {}
local HttpDnsAdapter = {
  Adapter = "Dnspod",
  Dnspod = {
    ttl = nil,
    api = "http://119.29.29.29/d"
  },
  Ejoy = {
    ttl = nil,
    api = "http://119.29.29.29"
  }
}

local function escape_pattern(text)
  do return text.gsub, text, "([^%w])" end
  return text.gsub, text, "([^%w])", "%%%1"
end

local function dnspod_read(data, ttl)
  local ret = {}
  local expires
  if ttl then
    local entry = E.Utils.split_string(data, ",")
    data = entry[1]
    expires = tonumber(entry[2]) + os.time()
  end
  string.gsub(data, "[^;]+", function(c)
    if ttl then
      ret[#ret + 1] = {c, expires}
    else
      ret[#ret + 1] = c
    end
  end)
  if 0 == #ret then
    return
  end
  return ret
end

local function dns_iterator(ips)
  if not ips then
    return function()
    end
  end
  local f, t, s = ipairs(ips)
  local now = os.time()
  
  local function itr(t1, k_)
    local k, v = f(t1, k_)
    while k do
      local ip
      if type(v) == "string" then
        ip = v
      elseif v[2] <= now then
        ip = v[1]
      end
      if ip then
        return k, ip
      else
        k, v = f(t1, k)
      end
    end
  end
  
  return itr, t, s
end

local function make_dns_resp(ips, array)
  if array then
    local ret = {}
    for _, ip in dns_iterator(ips) do
      ret[#ret + 1] = ip
    end
    if 0 ~= #ret then
      return ret
    end
  else
    for _, ip in dns_iterator(ips) do
      return ip
    end
  end
  return
end

local function httpdns_update_params(params, parsed_url)
  if not params.headers then
    params.headers = {}
  end
  local host = parsed_url.host
  if parsed_url.port then
    host = host .. ":" .. parsed_url.port
  end
  params.headers.Host = host
end

function HttpDnsAdapter.Dnspod:gethostbyname(domain, cb)
  local params = {
    dn = domain,
    ttl = self.ttl
  }
  local url = Uri.url_query(self.api, params)
  local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
  HTTP_Adapter.http_get_adapter_security(url, {}, function(resp)
    if resp.status == 200 and resp.body and 0 ~= #resp.body then
      do return cb, dnspod_read(resp.body, self.ttl) end
      return cb, dnspod_read(resp.body, self.ttl)
    end
    do return end
    return cb, dnspod_read(resp.body, self.ttl)
  end)
end

function HttpDnsAdapter.Dnspod:preload(domains, cb)
  local loop
  
  function loop(rest, acc)
    local domain = table.remove(rest)
    if domain then
      self:gethostbyname(domain, function(ips)
        if ips then
          acc[domain] = ips
        end
        loop(rest, acc)
      end)
    else
      do return cb end
      return cb, acc, domain, function(ips)
        if ips then
          acc[domain] = ips
        end
        loop(rest, acc)
      end
    end
  end
  
  loop(domains, {})
end

function HttpDnsAdapter.Ejoy:gethostbyname(domain, cb)
  local params = {
    dn = domain,
    ttl = self.ttl
  }
  local url = Uri.url_query(self.api .. "/d", params)
  local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
  HTTP_Adapter.http_get_adapter_security(url, {}, function(resp)
    if resp.status == 200 and resp.body and 0 ~= #resp.body then
      do return cb, dnspod_read(resp.body, self.ttl) end
      return cb, dnspod_read(resp.body, self.ttl)
    end
    do return cb end
    return cb, {}, dnspod_read(resp.body, self.ttl)
  end)
end

local function ejoy_preload_read(data, _ttl)
  local ret = {}
  string.gsub(data, [[
[^
]+]], function(c)
    local entry = E.Utils.split_string(c, ":")
    local domain = entry[1]
    ret[domain] = dnspod_read(entry[2])
  end)
  return ret
end

function HttpDnsAdapter.Ejoy:preload(domains, cb)
  local params = {
    dn = domains:concat(","),
    ttl = self.ttl
  }
  local url = Uri.url_query(self.api .. "/q", params)
  local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
  HTTP_Adapter.http_get_adapter_security(url, {}, function(resp)
    if resp.status == 200 and resp.body and 0 ~= #resp.body then
      do return cb, ejoy_preload_read(resp.body, self.ttl) end
      return cb, ejoy_preload_read(resp.body, self.ttl)
    end
    do return end
    return cb, ejoy_preload_read(resp.body, self.ttl)
  end)
end

function HttpDns.is_numeric(domain)
  do return string.find, domain end
  return string.find, domain, "^%d+%.%d+%.%d+%.%d+$"
end

function HttpDns.gethostbyname(domain, cb, return_array)
  if HttpDns.is_numeric(domain) then
    do return cb end
    return cb, domain, nil, nil, nil, nil
  end
  local cache = make_dns_resp(DnsCache[domain], return_array)
  if cache then
    do return cb end
    return cb, cache, nil, nil, nil
  end
  local adapter = HttpDnsAdapter[HttpDnsAdapter.Adapter]
  adapter:gethostbyname(domain, function(ips)
    if ips then
      DnsCache[domain] = ips
      do return cb, make_dns_resp(ips, return_array) end
      return cb, make_dns_resp(ips, return_array)
    else
      do return end
      return cb, make_dns_resp(ips, return_array)
    end
  end)
end

function HttpDns.prepare(url, params, cb)
  params.httpdns = nil
  local parsed_url = Uri.parse(url)
  local host = parsed_url.host
  HttpDns.gethostbyname(host, function(ip)
    if ip then
      httpdns_update_params(params, parsed_url)
      url = url:gsub(escape_pattern(host), ip, 1)
    end
    cb(url, params)
  end)
end

function HttpDns.get(url, params, cb)
  HttpDns.prepare(url, params, function(new_url, new_params)
    local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
    HTTP_Adapter.http_get_adapter_security(new_url, new_params, cb)
  end)
end

function HttpDns.post(url, params, content_type, body, cb)
  HttpDns.prepare(url, params, function(new_url, new_params)
    local HTTP_Adapter = require("ejoysdk_lua.ejoysdk_http_adapter")
    HTTP_Adapter.http_post_adapter_security(new_url, new_params, content_type, body, cb)
  end)
end

function HttpDns.preload(domains, cb)
  local adapter = HttpDnsAdapter[HttpDnsAdapter.Adapter]
  adapter:preload(domains, function(ret)
    for domain, ips in pairs(ret) do
      DnsCache[domain] = ips
    end
    if cb then
      cb()
    end
  end)
end

return HttpDns
