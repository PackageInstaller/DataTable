local sproto = require("sproto")
local print_r = require("print_r")
local server_proto = sproto.parse([[
.package {
  type 0 : integer
  session 1 : integer
}

foobar 1 {
  request {
    what 0 : string
  }
  response {
    ok 0 : boolean
  }
}

foo 2 {
  response {
    ok 0 : boolean
  }
}

bar 3 {
  response nil
}

blackhole 4 {
}
]])
local client_proto = sproto.parse([[
.package {
  type 0 : integer
  session 1 : integer
}
]])
assert(server_proto:exist_type("package"))
assert(server_proto:exist_proto("foobar"))
game.log.Debug("=== default table")
print_r(server_proto:default("package"))
print_r(server_proto:default("foobar", "REQUEST"))
assert(server_proto:default("foo", "REQUEST") == nil)
assert(server_proto:request_encode("foo") == "")
server_proto:response_encode("foo", {ok = true})
assert(nil == server_proto:request_decode("blackhole"))
assert(nil == server_proto:response_decode("blackhole"))
game.log.Debug("=== test 1")
local server = server_proto:host("package")
local client = client_proto:host("package")
local client_request = client:attach(server_proto)
game.log.Debug("client request foobar")
local req = client_request("foobar", {what = "foo"}, 1)
game.log.Debug("request foobar size =", #req)
local type, name, request, response = server:dispatch(req)
assert("REQUEST" == type and "foobar" == name)
print_r(request)
game.log.Debug("server response")
local resp = response({ok = true})
game.log.Debug("response package size =", #resp)
game.log.Debug("client dispatch")
local type, session, response = client:dispatch(resp)
assert("RESPONSE" == type and 1 == session)
print_r(response)
local req = client_request("foo", nil, 2)
game.log.Debug("request foo size =", #req)
local type, name, request, response = server:dispatch(req)
assert("REQUEST" == type and "foo" == name and nil == request)
local resp = response({ok = false})
game.log.Debug("response package size =", #resp)
game.log.Debug("client dispatch")
local type, session, response = client:dispatch(resp)
assert("RESPONSE" == type and 2 == session)
print_r(response)
local req = client_request("bar", nil, 3)
game.log.Debug("request bar size =", #req)
local type, name, request, response = server:dispatch(req)
assert("REQUEST" == type and "bar" == name and nil == request)
assert(3 == select(2, client:dispatch(response())))
local req = client_request("blackhole")
game.log.Debug("request blackhole size = ", #req)
game.log.Debug("=== test 2")
local v, tag = server_proto:request_encode("foobar", {what = "hello"})
assert(1 == tag)
game.log.Debug("tag =", tag)
print_r(server_proto:request_decode("foobar", v))
local v = server_proto:response_encode("foobar", {ok = true})
print_r(server_proto:response_decode("foobar", v))
