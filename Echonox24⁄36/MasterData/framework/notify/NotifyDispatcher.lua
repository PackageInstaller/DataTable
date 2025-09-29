module("framework.notify.NotifyDispatcher", package.seeall)

return {
	extend = function(arg_1_0)
		arg_1_0._listenPendings = {}
		arg_1_0._dispatchPendings = {}
		arg_1_0._allListeners = {}
		arg_1_0._dispatching = {}
		arg_1_0._tempToRemoves = {}

		function arg_1_0.addListener(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
			if not arg_2_2 then
				printError("Notify handler cannot be nil,notifyName=", arg_2_1)

				return
			end

			local var_2_0 = arg_2_0:_hasListenerInQueue(arg_2_1, arg_2_2, arg_2_3)
			local var_2_1 = false
			local var_2_2 = false

			if arg_2_0._dispatching[arg_2_1] then
				local var_2_3 = arg_2_0:_getStatusInPending(arg_2_1, arg_2_2, arg_2_3)

				if var_2_3 == NotifyStatus.ToInsert then
					var_2_1 = true
				elseif var_2_3 == NotifyStatus.ToDelete then
					var_2_2 = true
				end
			end

			if var_2_1 then
				return
			end

			if var_2_0 and not var_2_2 then
				return
			end

			local var_2_4 = NotifyEntry.getPool():fetchObject()

			var_2_4.name = arg_2_1
			var_2_4.handlerObj = arg_2_3
			var_2_4.handler = arg_2_2
			var_2_4.priority = arg_2_4 or NotifyPriority.Normal

			if arg_2_0._dispatching[arg_2_1] then
				arg_2_0:_removeFromListenPending(arg_2_1, arg_2_2, arg_2_3)

				var_2_4.status = NotifyStatus.ToInsert

				if not arg_2_0._listenPendings[arg_2_1] then
					arg_2_0._listenPendings[arg_2_1] = {}
				end

				table.insert(arg_2_0._listenPendings[arg_2_1], var_2_4)
			else
				arg_2_0:_safeAddListener(var_2_4)
			end
		end

		function arg_1_0.removeAllListener(arg_3_0, arg_3_1)
			if arg_3_0._allListeners[arg_3_1] == nil then
				return
			end

			local var_3_0 = arg_3_0._allListeners[arg_3_1]

			for iter_3_0 = NotifyPriority.High, NotifyPriority.Low, -1 do
				local var_3_1 = var_3_0[iter_3_0]
				local var_3_2 = #var_3_1

				for iter_3_1 = 1, var_3_2 do
					local var_3_3 = {
						handler = var_3_1[iter_3_1].handler,
						handlerObj = var_3_1[iter_3_1].handlerObj
					}

					table.insert(arg_3_0._tempToRemoves, var_3_3)
				end
			end

			local var_3_4 = #arg_3_0._tempToRemoves

			for iter_3_2 = 1, var_3_4 do
				arg_3_0:removeListener(arg_3_0._tempToRemoves.handler, arg_3_0._tempToRemoves.handlerObj)

				arg_3_0._tempToRemoves[iter_3_2] = nil
			end
		end

		function arg_1_0.removeListener(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
			if arg_4_0._allListeners[arg_4_1] == nil then
				return
			end

			if arg_4_0._dispatching[arg_4_1] then
				arg_4_0:_removeFromListenPending(arg_4_1, arg_4_2, arg_4_3, arg_4_4)

				local var_4_0 = NotifyEntry.getPool():fetchObject()

				var_4_0.handler = arg_4_2
				var_4_0.handlerObj = arg_4_3
				var_4_0.status = NotifyStatus.ToDelete
				var_4_0.name = arg_4_1
				var_4_0.isRemoveAllHandler = arg_4_4

				if not arg_4_0._listenPendings[arg_4_1] then
					arg_4_0._listenPendings[arg_4_1] = {}
				end

				table.insert(arg_4_0._listenPendings[arg_4_1], var_4_0)
			else
				arg_4_0:_safeRemoveListener(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
			end
		end

		function arg_1_0._removeFromListenPending(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
			local var_5_0 = arg_5_0._listenPendings[arg_5_1]

			if not var_5_0 then
				return
			end

			for iter_5_0 = #var_5_0, 1, -1 do
				local var_5_1 = var_5_0[iter_5_0]

				if var_5_1.name == arg_5_1 and var_5_1.handler == arg_5_2 then
					if arg_5_4 then
						NotifyEntry.getPool():returnObject(var_5_1)
						table.remove(var_5_0, iter_5_0)
					elseif var_5_1.handlerObj == arg_5_3 then
						NotifyEntry.getPool():returnObject(var_5_1)
						table.remove(var_5_0, iter_5_0)

						break
					end
				end
			end
		end

		function arg_1_0._safeAddListener(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_0._allListeners[arg_6_1.name]

			if var_6_0 == nil then
				var_6_0 = {}

				for iter_6_0 = NotifyPriority.Low, NotifyPriority.High do
					var_6_0[iter_6_0] = {}
				end

				arg_6_0._allListeners[arg_6_1.name] = var_6_0
			end

			if arg_6_0:_hasListenerInQueue(arg_6_1.name, arg_6_1.handler, arg_6_1.handlerObj) then
				NotifyEntry.getPool():returnObject(arg_6_1)

				return
			end

			arg_6_1.status = NotifyStatus.Active

			table.insert(var_6_0[arg_6_1.priority], arg_6_1)
		end

		function arg_1_0._safeRemoveListener(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
			if arg_7_0._allListeners[arg_7_1] == nil then
				return
			end

			local var_7_0 = arg_7_0._allListeners[arg_7_1]

			for iter_7_0 = NotifyPriority.Low, NotifyPriority.High do
				local var_7_1 = var_7_0[iter_7_0]

				for iter_7_1 = #var_7_1, 1, -1 do
					if var_7_1[iter_7_1].handler == arg_7_2 then
						if arg_7_4 then
							NotifyEntry.getPool():returnObject(var_7_1[iter_7_1])
							table.remove(var_7_1, iter_7_1)
						elseif var_7_1[iter_7_1].handlerObj == arg_7_3 then
							NotifyEntry.getPool():returnObject(var_7_1[iter_7_1])
							table.remove(var_7_1, iter_7_1)

							break
						end
					end
				end
			end
		end

		function arg_1_0.dispatch(arg_8_0, arg_8_1, ...)
			if arg_8_0._allListeners == nil or arg_8_0._allListeners[arg_8_1] == nil then
				return
			end

			if arg_8_0._dispatching[arg_8_1] then
				local var_8_0 = DispatchEntry.getPool():fetchObject()

				var_8_0.name = arg_8_1

				if ... ~= nil then
					var_8_0.message = {
						...
					}
				else
					var_8_0.message = nil
				end

				table.insert(arg_8_0._dispatchPendings, var_8_0)

				return
			end

			arg_8_0._dispatching[arg_8_1] = true

			local var_8_1 = arg_8_0._allListeners[arg_8_1]

			for iter_8_0 = NotifyPriority.High, NotifyPriority.Low, -1 do
				local var_8_2 = var_8_1[iter_8_0]
				local var_8_3 = #var_8_2

				for iter_8_1 = 1, var_8_3 do
					if var_8_2[iter_8_1].handlerObj then
						if enableDebug then
							trycall(var_8_2[iter_8_1].handler, var_8_2[iter_8_1].handlerObj, ...)
						else
							var_8_2[iter_8_1].handler(var_8_2[iter_8_1].handlerObj, ...)
						end
					elseif enableDebug then
						trycall(var_8_2[iter_8_1].handler, ...)
					else
						var_8_2[iter_8_1].handler(...)
					end
				end
			end

			arg_8_0._dispatching[arg_8_1] = nil

			local var_8_4 = arg_8_0._listenPendings[arg_8_1]

			if var_8_4 then
				local var_8_5 = #var_8_4

				for iter_8_2 = 1, var_8_5 do
					local var_8_6 = var_8_4[iter_8_2]

					if var_8_6.status == NotifyStatus.ToInsert then
						arg_8_0:_safeAddListener(var_8_6)
					elseif var_8_6.status == NotifyStatus.ToDelete then
						arg_8_0:_safeRemoveListener(var_8_6.name, var_8_6.handler, var_8_6.handlerObj, var_8_6.isRemoveAllHandler)
						NotifyEntry.getPool():returnObject(var_8_6)
					end

					var_8_4[iter_8_2] = nil
				end
			end

			if #arg_8_0._dispatchPendings > 0 then
				local var_8_7 = table.remove(arg_8_0._dispatchPendings, 1)

				if not arg_8_0._dispatching[var_8_7.name] then
					if var_8_7.message then
						arg_8_0:dispatch(var_8_7.name, unpack(var_8_7.message))
					else
						arg_8_0:dispatch(var_8_7.name)
					end

					DispatchEntry.getPool():returnObject(var_8_7)
				end
			end
		end

		function arg_1_0._getStatusInPending(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
			local var_9_0 = 0
			local var_9_1 = arg_9_0._listenPendings[arg_9_1]

			if var_9_1 then
				for iter_9_0 = #var_9_1, 1, -1 do
					local var_9_2 = var_9_1[iter_9_0]

					if var_9_2.name == arg_9_1 and var_9_2.handlerObj == arg_9_3 and var_9_2.handler == arg_9_2 then
						if var_9_2.status == NotifyStatus.ToInsert then
							var_9_0 = NotifyStatus.ToInsert

							break
						elseif var_9_2.status == NotifyStatus.ToDelete then
							var_9_0 = NotifyStatus.ToDelete

							break
						end
					end
				end
			end

			return var_9_0
		end

		function arg_1_0._hasListenerInQueue(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
			if arg_10_0._allListeners[arg_10_1] == nil then
				return false
			end

			local var_10_0 = arg_10_0._allListeners[arg_10_1]
			local var_10_1 = false

			for iter_10_0 = NotifyPriority.Low, NotifyPriority.High do
				local var_10_2 = var_10_0[iter_10_0]

				for iter_10_1 = #var_10_2, 1, -1 do
					if var_10_2[iter_10_1].handler == arg_10_2 and var_10_2[iter_10_1].handlerObj == arg_10_3 then
						var_10_1 = true

						break
					end
				end

				if var_10_1 then
					break
				end
			end

			return var_10_1
		end

		function arg_1_0.hasListener(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
			local var_11_0 = arg_11_0:_hasListenerInQueue(arg_11_1, arg_11_2, arg_11_3)

			if arg_11_0._dispatching then
				local var_11_1 = arg_11_0:_getStatusInPending(arg_11_1, arg_11_2, arg_11_3)

				if var_11_1 == NotifyStatus.ToInsert then
					var_11_0 = true
				elseif var_11_1 == NotifyStatus.ToDelete then
					var_11_0 = false
				end
			end

			return var_11_0
		end
	end
}
