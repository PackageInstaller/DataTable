return {
	Play926021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926021001
		arg_1_1.duration_ = 11.13

		local var_1_0 = {
			zh = 9.133,
			ja = 11.133
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play926021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I22g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I22g")
				var_4_0.name = "I22g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I22g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I22g

				arg_1_1.bgs_.I22g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I22g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = ""

			if arg_1_1.actors_[""] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "")

				if not isNil(var_4_10) then
					local var_4_11 = Object.Instantiate(var_4_10, arg_1_1.canvasGo_.transform)

					var_4_11.transform:SetSiblingIndex(1)

					var_4_11.name = var_4_9
					var_4_11.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_9] = var_4_11

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_11:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_12 = arg_1_1.actors_[""]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps == nil then
				arg_1_1.var_.actorSpriteComps = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 0) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 0) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 0) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 0) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps = nil
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.666666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_20 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_25 = arg_1_1:GetWordFromCfg(926021001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 32 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 32)

				if (32 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 32)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021001", "story_v_out_926021.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_926021", "926021001", "story_v_out_926021.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_926021", "926021001", "story_v_out_926021.awb")

						arg_1_1:RecordAudio("926021001", var_4_30)
						arg_1_1:RecordAudio("926021001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926021", "926021001", "story_v_out_926021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926021", "926021001", "story_v_out_926021.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play926021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926021002
		arg_9_1.duration_ = 1.33

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["106103"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "106103"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["106103"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["106103"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps106103 == nil then
				arg_9_1.var_.actorSpriteComps106103 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps106103 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								iter_12_3.color = Color.New(Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_3.color.r, 1, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_3.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps106103 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps106103 = nil
			end

			local var_12_5 = arg_9_1.actors_["106103"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos106103 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("106103", 2)

				for iter_12_6 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_6)

					if var_12_6.name == "split_3" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_12_8 = 0
			local var_12_9 = 0.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(926021002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)

				if (3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021002", "story_v_out_926021.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021002", "story_v_out_926021.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_926021", "926021002", "story_v_out_926021.awb")

						arg_9_1:RecordAudio("926021002", var_12_15)
						arg_9_1:RecordAudio("926021002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926021", "926021002", "story_v_out_926021.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926021", "926021002", "story_v_out_926021.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play926021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926021003
		arg_13_1.duration_ = 1.07

		local var_13_0 = {
			zh = 1,
			ja = 1.066
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play926021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["128404"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "128404"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["128404"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["128404"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps128404 == nil then
				arg_13_1.var_.actorSpriteComps128404 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps128404 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								iter_16_3.color = Color.New(Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_3.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_3.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps128404 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_16_5 then
						iter_16_5.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps128404 = nil
			end

			local var_16_5 = arg_13_1.actors_["106103"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps106103 == nil then
				arg_13_1.var_.actorSpriteComps106103 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps106103 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								iter_16_7.color = Color.New(Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_7.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_7.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps106103 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_16_9 then
						iter_16_9.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps106103 = nil
			end

			local var_16_8 = arg_13_1.actors_["128404"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos128404 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("128404", 4)

				for iter_16_10 = 0, var_16_8.childCount - 1 do
					local var_16_9 = var_16_8:GetChild(iter_16_10)

					if var_16_9.name == "split_6" or not string.find(var_16_9.name, "split") then
						var_16_9.gameObject:SetActive(true)
					else
						var_16_9.gameObject:SetActive(false)
					end
				end
			end

			local var_16_10 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_10 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_13_1.time_ - 0) / var_16_10)
			end

			if arg_13_1.time_ >= 0 + var_16_10 and arg_13_1.time_ < 0 + var_16_10 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_16_11 = 0
			local var_16_12 = 0.075

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(926021003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 3 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 3)

				if (3 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 3)) > 0 and var_16_12 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021003", "story_v_out_926021.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021003", "story_v_out_926021.awb") / 1000

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_926021", "926021003", "story_v_out_926021.awb")

						arg_13_1:RecordAudio("926021003", var_16_18)
						arg_13_1:RecordAudio("926021003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926021", "926021003", "story_v_out_926021.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926021", "926021003", "story_v_out_926021.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_11 <= arg_13_1.time_ and arg_13_1.time_ < var_16_11 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_11) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_11 + var_16_19 and arg_13_1.time_ < var_16_11 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play926021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926021004
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"

			SetActive(arg_17_1.choicesGo_, true)

			for iter_18_0, iter_18_1 in ipairs(arg_17_1.choices_) do
				SetActive(iter_18_1.go, iter_18_0 <= 1)
			end

			arg_17_1.choices_[1].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1314].name)
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play926021005(arg_17_1)
			end

			arg_17_1:RecordChoiceLog(926021004, 1314)
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["128404"]) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = arg_17_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["128404"]) then
				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["128404"]) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play926021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926021005
		arg_21_1.duration_ = 11.93

		local var_21_0 = {
			zh = 10.966,
			ja = 11.933
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play926021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["10144"] == nil then
				local var_24_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_24_0) then
					local var_24_1 = Object.Instantiate(var_24_0, arg_21_1.canvasGo_.transform)

					var_24_1.transform:SetSiblingIndex(1)

					var_24_1.name = "10144"
					var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_["10144"] = var_24_1

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs((var_24_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_2 = arg_21_1.actors_["10144"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10144 == nil then
				arg_21_1.var_.actorSpriteComps10144 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10144 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								iter_24_3.color = Color.New(Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_3.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_3.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10144 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_24_5 then
						iter_24_5.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10144 = nil
			end

			local var_24_5 = arg_21_1.actors_["128404"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos128404 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("128404", 7)

				for iter_24_6 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_6)

					if var_24_6.name == "split_2" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_8 = arg_21_1.actors_["10144"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10144 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10144", 3)

				for iter_24_7 = 0, var_24_8.childCount - 1 do
					local var_24_9 = var_24_8:GetChild(iter_24_7)

					if var_24_9.name == "split_2" or not string.find(var_24_9.name, "split") then
						var_24_9.gameObject:SetActive(true)
					else
						var_24_9.gameObject:SetActive(false)
					end
				end
			end

			local var_24_10 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_10 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_21_1.time_ - 0) / var_24_10)
			end

			if arg_21_1.time_ >= 0 + var_24_10 and arg_21_1.time_ < 0 + var_24_10 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_24_11 = arg_21_1.actors_["106103"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos106103 = var_24_11.localPosition
				var_24_11.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("106103", 7)

				for iter_24_8 = 0, var_24_11.childCount - 1 do
					local var_24_12 = var_24_11:GetChild(iter_24_8)

					if var_24_12.name == "split_3" or not string.find(var_24_12.name, "split") then
						var_24_12.gameObject:SetActive(true)
					else
						var_24_12.gameObject:SetActive(false)
					end
				end
			end

			local var_24_13 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_13 then
				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_21_1.time_ - 0) / var_24_13)
			end

			if arg_21_1.time_ >= 0 + var_24_13 and arg_21_1.time_ < 0 + var_24_13 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_24_14 = 0
			local var_24_15 = 1.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_16 = arg_21_1:GetWordFromCfg(926021005)
				local var_24_17 = arg_21_1:FormatText(var_24_16.content)

				arg_21_1.text_.text = var_24_17

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 45 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 45)

				if (45 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 45)) > 0 and var_24_15 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_14
					end
				end

				arg_21_1.text_.text = var_24_17
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021005", "story_v_out_926021.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_926021", "926021005", "story_v_out_926021.awb") / 1000

					if var_24_20 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_14
					end

					if var_24_16.prefab_name ~= "" and arg_21_1.actors_[var_24_16.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_16.prefab_name].transform, "story_v_out_926021", "926021005", "story_v_out_926021.awb")

						arg_21_1:RecordAudio("926021005", var_24_21)
						arg_21_1:RecordAudio("926021005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926021", "926021005", "story_v_out_926021.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926021", "926021005", "story_v_out_926021.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_15, arg_21_1.talkMaxDuration)

			if var_24_14 <= arg_21_1.time_ and arg_21_1.time_ < var_24_14 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_14) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_14 + var_24_22 and arg_21_1.time_ < var_24_14 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play926021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926021006
		arg_25_1.duration_ = 12

		local var_25_0 = {
			zh = 6.833,
			ja = 12
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play926021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10144 = arg_25_1.actors_["10144"].transform.localPosition
				arg_25_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10144", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10144"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10144"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_7" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_28_2 = 0
			local var_28_3 = 0.775

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(926021006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 31 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 31)

				if (31 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 31)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021006", "story_v_out_926021.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021006", "story_v_out_926021.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_926021", "926021006", "story_v_out_926021.awb")

						arg_25_1:RecordAudio("926021006", var_28_9)
						arg_25_1:RecordAudio("926021006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926021", "926021006", "story_v_out_926021.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926021", "926021006", "story_v_out_926021.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play926021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926021007
		arg_29_1.duration_ = 1.33

		local var_29_0 = {
			zh = 1.2,
			ja = 1.333
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play926021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["104701"] == nil then
				local var_32_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_32_0) then
					local var_32_1 = Object.Instantiate(var_32_0, arg_29_1.canvasGo_.transform)

					var_32_1.transform:SetSiblingIndex(1)

					var_32_1.name = "104701"
					var_32_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_["104701"] = var_32_1

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs((var_32_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_2 = arg_29_1.actors_["104701"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps104701 == nil then
				arg_29_1.var_.actorSpriteComps104701 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps104701 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								iter_32_3.color = Color.New(Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_3.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_3.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps104701 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_32_5 then
						iter_32_5.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps104701 = nil
			end

			local var_32_5 = arg_29_1.actors_["10144"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps10144 == nil then
				arg_29_1.var_.actorSpriteComps10144 = var_32_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_6 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.actorSpriteComps10144 then
					for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_32_7 then
							if arg_29_1.isInRecall_ then
								iter_32_7.color = Color.New(Mathf.Lerp(iter_32_7.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_6), Mathf.Lerp(iter_32_7.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_6), (Mathf.Lerp(iter_32_7.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_6)))
							else
								local var_32_7 = Mathf.Lerp(iter_32_7.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_6)

								iter_32_7.color = Color.New(var_32_7, var_32_7, var_32_7)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.actorSpriteComps10144 then
				for iter_32_8, iter_32_9 in pairs(arg_29_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_32_9 then
						iter_32_9.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10144 = nil
			end

			local var_32_8 = 0
			local var_32_9 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_10 = arg_29_1:GetWordFromCfg(926021007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 3 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 3)

				if (3 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 3)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021007", "story_v_out_926021.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021007", "story_v_out_926021.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_926021", "926021007", "story_v_out_926021.awb")

						arg_29_1:RecordAudio("926021007", var_32_15)
						arg_29_1:RecordAudio("926021007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926021", "926021007", "story_v_out_926021.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926021", "926021007", "story_v_out_926021.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play926021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926021008
		arg_33_1.duration_ = 9.47

		local var_33_0 = {
			zh = 6.7,
			ja = 9.466
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10144"]) and arg_33_1.var_.actorSpriteComps10144 == nil then
				arg_33_1.var_.actorSpriteComps10144 = arg_33_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10144"]) then
				if arg_33_1.var_.actorSpriteComps10144 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 1, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10144"]) and arg_33_1.var_.actorSpriteComps10144 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10144 = nil
			end

			local var_36_2 = arg_33_1.actors_["104701"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps104701 == nil then
				arg_33_1.var_.actorSpriteComps104701 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps104701 then
					for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_36_5 then
							if arg_33_1.isInRecall_ then
								iter_36_5.color = Color.New(Mathf.Lerp(iter_36_5.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_5.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_5.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_5.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_5.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps104701 then
				for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_36_7 then
						iter_36_7.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps104701 = nil
			end

			local var_36_5 = arg_33_1.actors_["10144"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10144 = var_36_5.localPosition
				var_36_5.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10144", 3)

				for iter_36_8 = 0, var_36_5.childCount - 1 do
					local var_36_6 = var_36_5:GetChild(iter_36_8)

					if var_36_6.name == "" or not string.find(var_36_6.name, "split") then
						var_36_6.gameObject:SetActive(true)
					else
						var_36_6.gameObject:SetActive(false)
					end
				end
			end

			local var_36_7 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_33_1.time_ - 0) / var_36_7)
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_36_8 = 0
			local var_36_9 = 0.725

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(926021008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 29 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 29)

				if (29 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 29)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021008", "story_v_out_926021.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021008", "story_v_out_926021.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_926021", "926021008", "story_v_out_926021.awb")

						arg_33_1:RecordAudio("926021008", var_36_15)
						arg_33_1:RecordAudio("926021008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_926021", "926021008", "story_v_out_926021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_926021", "926021008", "story_v_out_926021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play926021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926021009
		arg_37_1.duration_ = 1.97

		local var_37_0 = {
			zh = 1.533,
			ja = 1.966
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play926021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["106103"]) and arg_37_1.var_.actorSpriteComps106103 == nil then
				arg_37_1.var_.actorSpriteComps106103 = arg_37_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["106103"]) then
				if arg_37_1.var_.actorSpriteComps106103 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["106103"]) and arg_37_1.var_.actorSpriteComps106103 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps106103 = nil
			end

			local var_40_2 = arg_37_1.actors_["10144"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10144 == nil then
				arg_37_1.var_.actorSpriteComps10144 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps10144 then
					for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_40_5 then
							if arg_37_1.isInRecall_ then
								iter_40_5.color = Color.New(Mathf.Lerp(iter_40_5.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_5.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_5.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_5.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_5.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps10144 then
				for iter_40_6, iter_40_7 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_40_7 then
						iter_40_7.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10144 = nil
			end

			local var_40_5 = arg_37_1.actors_["10144"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10144 = var_40_5.localPosition
				var_40_5.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10144", 7)

				for iter_40_8 = 0, var_40_5.childCount - 1 do
					local var_40_6 = var_40_5:GetChild(iter_40_8)

					if var_40_6.name == "" or not string.find(var_40_6.name, "split") then
						var_40_6.gameObject:SetActive(true)
					else
						var_40_6.gameObject:SetActive(false)
					end
				end
			end

			local var_40_7 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				var_40_5.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_7)
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				var_40_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_8 = arg_37_1.actors_["106103"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos106103 = var_40_8.localPosition
				var_40_8.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106103", 2)

				for iter_40_9 = 0, var_40_8.childCount - 1 do
					local var_40_9 = var_40_8:GetChild(iter_40_9)

					if var_40_9.name == "" or not string.find(var_40_9.name, "split") then
						var_40_9.gameObject:SetActive(true)
					else
						var_40_9.gameObject:SetActive(false)
					end
				end
			end

			local var_40_10 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_10 then
				var_40_8.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_37_1.time_ - 0) / var_40_10)
			end

			if arg_37_1.time_ >= 0 + var_40_10 and arg_37_1.time_ < 0 + var_40_10 + arg_40_0 then
				var_40_8.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_40_11 = 0
			local var_40_12 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:GetWordFromCfg(926021009)
				local var_40_14 = arg_37_1:FormatText(var_40_13.content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 5 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 5)

				if (5 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 5)) > 0 and var_40_12 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16

					if var_40_16 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021009", "story_v_out_926021.awb") ~= 0 then
					local var_40_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021009", "story_v_out_926021.awb") / 1000

					if var_40_17 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_11
					end

					if var_40_13.prefab_name ~= "" and arg_37_1.actors_[var_40_13.prefab_name] ~= nil then
						local var_40_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_13.prefab_name].transform, "story_v_out_926021", "926021009", "story_v_out_926021.awb")

						arg_37_1:RecordAudio("926021009", var_40_18)
						arg_37_1:RecordAudio("926021009", var_40_18)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926021", "926021009", "story_v_out_926021.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926021", "926021009", "story_v_out_926021.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_19 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_11) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_11 + var_40_19 and arg_37_1.time_ < var_40_11 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play926021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926021010
		arg_41_1.duration_ = 3.47

		local var_41_0 = {
			zh = 2.233,
			ja = 3.466
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play926021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["128404"]) and arg_41_1.var_.actorSpriteComps128404 == nil then
				arg_41_1.var_.actorSpriteComps128404 = arg_41_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["128404"]) then
				if arg_41_1.var_.actorSpriteComps128404 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 1, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["128404"]) and arg_41_1.var_.actorSpriteComps128404 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps128404 = nil
			end

			local var_44_2 = arg_41_1.actors_["106103"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								iter_44_5.color = Color.New(Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_5.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_5.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_7 then
						iter_44_7.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_5 = arg_41_1.actors_["128404"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos128404 = var_44_5.localPosition
				var_44_5.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("128404", 4)

				for iter_44_8 = 0, var_44_5.childCount - 1 do
					local var_44_6 = var_44_5:GetChild(iter_44_8)

					if var_44_6.name == "" or not string.find(var_44_6.name, "split") then
						var_44_6.gameObject:SetActive(true)
					else
						var_44_6.gameObject:SetActive(false)
					end
				end
			end

			local var_44_7 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_41_1.time_ - 0) / var_44_7)
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_44_8 = 0
			local var_44_9 = 0.2

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(926021010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 8 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 8)

				if (8 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 8)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021010", "story_v_out_926021.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021010", "story_v_out_926021.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_926021", "926021010", "story_v_out_926021.awb")

						arg_41_1:RecordAudio("926021010", var_44_15)
						arg_41_1:RecordAudio("926021010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926021", "926021010", "story_v_out_926021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926021", "926021010", "story_v_out_926021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play926021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926021011
		arg_45_1.duration_ = 1

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"

			SetActive(arg_45_1.choicesGo_, true)

			for iter_46_0, iter_46_1 in ipairs(arg_45_1.choices_) do
				SetActive(iter_46_1.go, iter_46_0 <= 1)
			end

			arg_45_1.choices_[1].txt.text = arg_45_1:FormatText(StoryChoiceCfg[1315].name)
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play926021012(arg_45_1)
			end

			arg_45_1:RecordChoiceLog(926021011, 1315)
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["128404"]) and arg_45_1.var_.actorSpriteComps128404 == nil then
				arg_45_1.var_.actorSpriteComps128404 = arg_45_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["128404"]) then
				if arg_45_1.var_.actorSpriteComps128404 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["128404"]) and arg_45_1.var_.actorSpriteComps128404 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play926021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926021012
		arg_49_1.duration_ = 6.7

		local var_49_0 = {
			zh = 5.466,
			ja = 6.7
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play926021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10144"]) and arg_49_1.var_.actorSpriteComps10144 == nil then
				arg_49_1.var_.actorSpriteComps10144 = arg_49_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10144"]) then
				if arg_49_1.var_.actorSpriteComps10144 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								iter_52_1.color = Color.New(Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, (arg_49_1.time_ - 0) / var_52_0), Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, (arg_49_1.time_ - 0) / var_52_0), (Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, (arg_49_1.time_ - 0) / var_52_0)))
							else
								local var_52_1 = Mathf.Lerp(iter_52_1.color.r, 1, (arg_49_1.time_ - 0) / var_52_0)

								iter_52_1.color = Color.New(var_52_1, var_52_1, var_52_1)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10144"]) and arg_49_1.var_.actorSpriteComps10144 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_52_3 then
						iter_52_3.color = arg_49_1.isInRecall_ and (arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_49_1.var_.actorSpriteComps10144 = nil
			end

			local var_52_2 = arg_49_1.actors_["128404"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos128404 = var_52_2.localPosition
				var_52_2.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("128404", 7)

				for iter_52_4 = 0, var_52_2.childCount - 1 do
					local var_52_3 = var_52_2:GetChild(iter_52_4)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_4)
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_5 = arg_49_1.actors_["106103"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos106103 = var_52_5.localPosition
				var_52_5.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("106103", 7)

				for iter_52_5 = 0, var_52_5.childCount - 1 do
					local var_52_6 = var_52_5:GetChild(iter_52_5)

					if var_52_6.name == "" or not string.find(var_52_6.name, "split") then
						var_52_6.gameObject:SetActive(true)
					else
						var_52_6.gameObject:SetActive(false)
					end
				end
			end

			local var_52_7 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_7)
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_8 = arg_49_1.actors_["10144"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10144 = var_52_8.localPosition
				var_52_8.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10144", 3)

				for iter_52_6 = 0, var_52_8.childCount - 1 do
					local var_52_9 = var_52_8:GetChild(iter_52_6)

					if var_52_9.name == "" or not string.find(var_52_9.name, "split") then
						var_52_9.gameObject:SetActive(true)
					else
						var_52_9.gameObject:SetActive(false)
					end
				end
			end

			local var_52_10 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_10 then
				var_52_8.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_49_1.time_ - 0) / var_52_10)
			end

			if arg_49_1.time_ >= 0 + var_52_10 and arg_49_1.time_ < 0 + var_52_10 + arg_52_0 then
				var_52_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_52_11 = 0
			local var_52_12 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_11 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(926021012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_16 = 20 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_14) / 20)

				if (20 <= 0 and var_52_12 or var_52_12 * (utf8.len(var_52_14) / 20)) > 0 and var_52_12 < var_52_16 then
					arg_49_1.talkMaxDuration = var_52_16

					if var_52_16 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_16 + var_52_11
					end
				end

				arg_49_1.text_.text = var_52_14
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021012", "story_v_out_926021.awb") ~= 0 then
					local var_52_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021012", "story_v_out_926021.awb") / 1000

					if var_52_17 + var_52_11 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_17 + var_52_11
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_926021", "926021012", "story_v_out_926021.awb")

						arg_49_1:RecordAudio("926021012", var_52_18)
						arg_49_1:RecordAudio("926021012", var_52_18)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926021", "926021012", "story_v_out_926021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926021", "926021012", "story_v_out_926021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_19 = math.max(var_52_12, arg_49_1.talkMaxDuration)

			if var_52_11 <= arg_49_1.time_ and arg_49_1.time_ < var_52_11 + var_52_19 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_11) / var_52_19

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_11 + var_52_19 and arg_49_1.time_ < var_52_11 + var_52_19 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play926021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926021013
		arg_53_1.duration_ = 12.93

		local var_53_0 = {
			zh = 8.166,
			ja = 12.933
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play926021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(926021013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 42 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 42)

				if (42 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 42)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021013", "story_v_out_926021.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021013", "story_v_out_926021.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_926021", "926021013", "story_v_out_926021.awb")

						arg_53_1:RecordAudio("926021013", var_56_6)
						arg_53_1:RecordAudio("926021013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926021", "926021013", "story_v_out_926021.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926021", "926021013", "story_v_out_926021.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play926021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926021014
		arg_57_1.duration_ = 5.97

		local var_57_0 = {
			zh = 4.3,
			ja = 5.966
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10144 = arg_57_1.actors_["10144"].transform.localPosition
				arg_57_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10144", 3)

				for iter_60_0 = 0, arg_57_1.actors_["10144"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10144"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_2" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_60_2 = 0
			local var_60_3 = 0.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(926021014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 20 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 20)

				if (20 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 20)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021014", "story_v_out_926021.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021014", "story_v_out_926021.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_926021", "926021014", "story_v_out_926021.awb")

						arg_57_1:RecordAudio("926021014", var_60_9)
						arg_57_1:RecordAudio("926021014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_926021", "926021014", "story_v_out_926021.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_926021", "926021014", "story_v_out_926021.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play926021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926021015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10144"]) and arg_61_1.var_.actorSpriteComps10144 == nil then
				arg_61_1.var_.actorSpriteComps10144 = arg_61_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10144"]) then
				if arg_61_1.var_.actorSpriteComps10144 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10144"]) and arg_61_1.var_.actorSpriteComps10144 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10144 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(926021015).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 13 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 13)

				if (13 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 13)) > 0 and var_64_3 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_7 and arg_61_1.time_ < var_64_2 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play926021016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926021016
		arg_65_1.duration_ = 8.83

		local var_65_0 = {
			zh = 6.333,
			ja = 8.833
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926021017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10144"]) and arg_65_1.var_.actorSpriteComps10144 == nil then
				arg_65_1.var_.actorSpriteComps10144 = arg_65_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10144"]) then
				if arg_65_1.var_.actorSpriteComps10144 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10144"]) and arg_65_1.var_.actorSpriteComps10144 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10144 = nil
			end

			local var_68_2 = arg_65_1.actors_["10144"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 3)

				for iter_68_4 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_4)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_68_5 = 0
			local var_68_6 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(926021016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 28 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 28)

				if (28 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 28)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021016", "story_v_out_926021.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021016", "story_v_out_926021.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_926021", "926021016", "story_v_out_926021.awb")

						arg_65_1:RecordAudio("926021016", var_68_12)
						arg_65_1:RecordAudio("926021016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926021", "926021016", "story_v_out_926021.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926021", "926021016", "story_v_out_926021.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play926021017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926021017
		arg_69_1.duration_ = 13.67

		local var_69_0 = {
			zh = 10.433,
			ja = 13.666
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play926021018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(926021017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 44 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 44)

				if (44 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 44)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021017", "story_v_out_926021.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021017", "story_v_out_926021.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_926021", "926021017", "story_v_out_926021.awb")

						arg_69_1:RecordAudio("926021017", var_72_6)
						arg_69_1:RecordAudio("926021017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926021", "926021017", "story_v_out_926021.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926021", "926021017", "story_v_out_926021.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play926021018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926021018
		arg_73_1.duration_ = 10.7

		local var_73_0 = {
			zh = 8.2,
			ja = 10.7
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926021019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10144 = arg_73_1.actors_["10144"].transform.localPosition
				arg_73_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10144", 3)

				for iter_76_0 = 0, arg_73_1.actors_["10144"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10144"].transform:GetChild(iter_76_0)

					if var_76_0.name == "" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_76_2 = 0
			local var_76_3 = 1.05

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(926021018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 42 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 42)

				if (42 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 42)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021018", "story_v_out_926021.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021018", "story_v_out_926021.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_926021", "926021018", "story_v_out_926021.awb")

						arg_73_1:RecordAudio("926021018", var_76_9)
						arg_73_1:RecordAudio("926021018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_926021", "926021018", "story_v_out_926021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_926021", "926021018", "story_v_out_926021.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play926021019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926021019
		arg_77_1.duration_ = 2.6

		local var_77_0 = {
			zh = 2.6,
			ja = 2.3
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play926021020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.35

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(926021019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 14 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 14)

				if (14 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 14)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021019", "story_v_out_926021.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021019", "story_v_out_926021.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_926021", "926021019", "story_v_out_926021.awb")

						arg_77_1:RecordAudio("926021019", var_80_6)
						arg_77_1:RecordAudio("926021019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926021", "926021019", "story_v_out_926021.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926021", "926021019", "story_v_out_926021.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play926021020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 926021020
		arg_81_1.duration_ = 1

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"

			SetActive(arg_81_1.choicesGo_, true)

			for iter_82_0, iter_82_1 in ipairs(arg_81_1.choices_) do
				SetActive(iter_82_1.go, iter_82_0 <= 2)
			end

			arg_81_1.choices_[1].txt.text = arg_81_1:FormatText(StoryChoiceCfg[1316].name)
			arg_81_1.choices_[2].txt.text = arg_81_1:FormatText(StoryChoiceCfg[1317].name)
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play926021021(arg_81_1)
			end

			if arg_83_0 == 2 then
				arg_81_0:Play926021021(arg_81_1)
			end

			arg_81_1:RecordChoiceLog(926021020, 1316, 1317)
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10144"]) and arg_81_1.var_.actorSpriteComps10144 == nil then
				arg_81_1.var_.actorSpriteComps10144 = arg_81_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10144"]) then
				if arg_81_1.var_.actorSpriteComps10144 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10144"]) and arg_81_1.var_.actorSpriteComps10144 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10144 = nil
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play926021021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926021021
		arg_85_1.duration_ = 9.1

		local var_85_0 = {
			zh = 6.4,
			ja = 9.1
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play926021022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10144"]) and arg_85_1.var_.actorSpriteComps10144 == nil then
				arg_85_1.var_.actorSpriteComps10144 = arg_85_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10144"]) then
				if arg_85_1.var_.actorSpriteComps10144 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10144"]) and arg_85_1.var_.actorSpriteComps10144 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10144 = nil
			end

			local var_88_2 = arg_85_1.actors_["10144"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10144 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10144", 3)

				for iter_88_4 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_4)

					if var_88_3.name == "split_4" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_85_1.time_ - 0) / var_88_4)
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_88_5 = 0
			local var_88_6 = 0.825

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(926021021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 33 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 33)

				if (33 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 33)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021021", "story_v_out_926021.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021021", "story_v_out_926021.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_926021", "926021021", "story_v_out_926021.awb")

						arg_85_1:RecordAudio("926021021", var_88_12)
						arg_85_1:RecordAudio("926021021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926021", "926021021", "story_v_out_926021.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926021", "926021021", "story_v_out_926021.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play926021022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 926021022
		arg_89_1.duration_ = 8.57

		local var_89_0 = {
			zh = 6.833,
			ja = 8.566
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play926021023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10144 = arg_89_1.actors_["10144"].transform.localPosition
				arg_89_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10144", 3)

				for iter_92_0 = 0, arg_89_1.actors_["10144"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["10144"].transform:GetChild(iter_92_0)

					if var_92_0.name == "split_7" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_92_2 = 0
			local var_92_3 = 0.825

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(926021022)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 33 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 33)

				if (33 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 33)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021022", "story_v_out_926021.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021022", "story_v_out_926021.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_out_926021", "926021022", "story_v_out_926021.awb")

						arg_89_1:RecordAudio("926021022", var_92_9)
						arg_89_1:RecordAudio("926021022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_926021", "926021022", "story_v_out_926021.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_926021", "926021022", "story_v_out_926021.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play926021023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 926021023
		arg_93_1.duration_ = 11.13

		local var_93_0 = {
			zh = 8,
			ja = 11.133
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play926021024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.1

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(926021023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 44 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 44)

				if (44 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 44)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021023", "story_v_out_926021.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021023", "story_v_out_926021.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_926021", "926021023", "story_v_out_926021.awb")

						arg_93_1:RecordAudio("926021023", var_96_6)
						arg_93_1:RecordAudio("926021023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_926021", "926021023", "story_v_out_926021.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_926021", "926021023", "story_v_out_926021.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play926021024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 926021024
		arg_97_1.duration_ = 8.13

		local var_97_0 = {
			zh = 6.4,
			ja = 8.133
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play926021025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["128404"]) and arg_97_1.var_.actorSpriteComps128404 == nil then
				arg_97_1.var_.actorSpriteComps128404 = arg_97_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["128404"]) then
				if arg_97_1.var_.actorSpriteComps128404 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 1, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["128404"]) and arg_97_1.var_.actorSpriteComps128404 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps128404 = nil
			end

			local var_100_2 = arg_97_1.actors_["10144"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10144 == nil then
				arg_97_1.var_.actorSpriteComps10144 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10144 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10144 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10144 = nil
			end

			local var_100_5 = arg_97_1.actors_["128404"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos128404 = var_100_5.localPosition
				var_100_5.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("128404", 3)

				for iter_100_8 = 0, var_100_5.childCount - 1 do
					local var_100_6 = var_100_5:GetChild(iter_100_8)

					if var_100_6.name == "split_6" or not string.find(var_100_6.name, "split") then
						var_100_6.gameObject:SetActive(true)
					else
						var_100_6.gameObject:SetActive(false)
					end
				end
			end

			local var_100_7 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				var_100_5.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_97_1.time_ - 0) / var_100_7)
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				var_100_5.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_100_8 = arg_97_1.actors_["10144"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10144 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10144", 7)

				for iter_100_9 = 0, var_100_8.childCount - 1 do
					local var_100_9 = var_100_8:GetChild(iter_100_9)

					if var_100_9.name == "" or not string.find(var_100_9.name, "split") then
						var_100_9.gameObject:SetActive(true)
					else
						var_100_9.gameObject:SetActive(false)
					end
				end
			end

			local var_100_10 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_10 then
				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_10)
			end

			if arg_97_1.time_ >= 0 + var_100_10 and arg_97_1.time_ < 0 + var_100_10 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_11 = 0
			local var_100_12 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_11 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(926021024)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_16 = 30 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 30)

				if (30 <= 0 and var_100_12 or var_100_12 * (utf8.len(var_100_14) / 30)) > 0 and var_100_12 < var_100_16 then
					arg_97_1.talkMaxDuration = var_100_16

					if var_100_16 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_16 + var_100_11
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021024", "story_v_out_926021.awb") ~= 0 then
					local var_100_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021024", "story_v_out_926021.awb") / 1000

					if var_100_17 + var_100_11 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_11
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_926021", "926021024", "story_v_out_926021.awb")

						arg_97_1:RecordAudio("926021024", var_100_18)
						arg_97_1:RecordAudio("926021024", var_100_18)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_926021", "926021024", "story_v_out_926021.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_926021", "926021024", "story_v_out_926021.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_19 = math.max(var_100_12, arg_97_1.talkMaxDuration)

			if var_100_11 <= arg_97_1.time_ and arg_97_1.time_ < var_100_11 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_11) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_11 + var_100_19 and arg_97_1.time_ < var_100_11 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play926021025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 926021025
		arg_101_1.duration_ = 7.7

		local var_101_0 = {
			zh = 4.333,
			ja = 7.7
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play926021026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10144"]) and arg_101_1.var_.actorSpriteComps10144 == nil then
				arg_101_1.var_.actorSpriteComps10144 = arg_101_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10144"]) then
				if arg_101_1.var_.actorSpriteComps10144 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 1, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10144"]) and arg_101_1.var_.actorSpriteComps10144 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10144 = nil
			end

			local var_104_2 = arg_101_1.actors_["128404"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps128404 == nil then
				arg_101_1.var_.actorSpriteComps128404 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps128404 then
					for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_104_5 then
							if arg_101_1.isInRecall_ then
								iter_104_5.color = Color.New(Mathf.Lerp(iter_104_5.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_3), Mathf.Lerp(iter_104_5.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_3), (Mathf.Lerp(iter_104_5.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_3)))
							else
								local var_104_4 = Mathf.Lerp(iter_104_5.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_3)

								iter_104_5.color = Color.New(var_104_4, var_104_4, var_104_4)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps128404 then
				for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_104_7 then
						iter_104_7.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps128404 = nil
			end

			local var_104_5 = arg_101_1.actors_["10144"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10144 = var_104_5.localPosition
				var_104_5.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10144", 3)

				for iter_104_8 = 0, var_104_5.childCount - 1 do
					local var_104_6 = var_104_5:GetChild(iter_104_8)

					if var_104_6.name == "" or not string.find(var_104_6.name, "split") then
						var_104_6.gameObject:SetActive(true)
					else
						var_104_6.gameObject:SetActive(false)
					end
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_101_1.time_ - 0) / var_104_7)
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_104_8 = 0
			local var_104_9 = 0.65

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(926021025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 26 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 26)

				if (26 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 26)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021025", "story_v_out_926021.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021025", "story_v_out_926021.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_926021", "926021025", "story_v_out_926021.awb")

						arg_101_1:RecordAudio("926021025", var_104_15)
						arg_101_1:RecordAudio("926021025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_926021", "926021025", "story_v_out_926021.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_926021", "926021025", "story_v_out_926021.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play926021026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 926021026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play926021027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10144"]) and arg_105_1.var_.actorSpriteComps10144 == nil then
				arg_105_1.var_.actorSpriteComps10144 = arg_105_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10144"]) then
				if arg_105_1.var_.actorSpriteComps10144 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10144"]) and arg_105_1.var_.actorSpriteComps10144 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10144 = nil
			end

			local var_108_2 = 0
			local var_108_3 = 0.425

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_4 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(926021026).content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 17)

				if (17 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 17)) > 0 and var_108_3 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_7 and arg_105_1.time_ < var_108_2 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play926021027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 926021027
		arg_109_1.duration_ = 13.23

		local var_109_0 = {
			zh = 7.166,
			ja = 13.233
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play926021028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10144"]) and arg_109_1.var_.actorSpriteComps10144 == nil then
				arg_109_1.var_.actorSpriteComps10144 = arg_109_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10144"]) then
				if arg_109_1.var_.actorSpriteComps10144 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 1, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10144"]) and arg_109_1.var_.actorSpriteComps10144 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps10144 = nil
			end

			local var_112_2 = 0
			local var_112_3 = 0.925

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(926021027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 37 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 37)

				if (37 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 37)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021027", "story_v_out_926021.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021027", "story_v_out_926021.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_926021", "926021027", "story_v_out_926021.awb")

						arg_109_1:RecordAudio("926021027", var_112_9)
						arg_109_1:RecordAudio("926021027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_926021", "926021027", "story_v_out_926021.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_926021", "926021027", "story_v_out_926021.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play926021028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 926021028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play926021029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10144"]) and arg_113_1.var_.actorSpriteComps10144 == nil then
				arg_113_1.var_.actorSpriteComps10144 = arg_113_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10144"]) then
				if arg_113_1.var_.actorSpriteComps10144 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10144"]) and arg_113_1.var_.actorSpriteComps10144 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10144 = nil
			end

			local var_116_2 = 0
			local var_116_3 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_4 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(926021028).content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 27 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 27)

				if (27 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 27)) > 0 and var_116_3 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_7 and arg_113_1.time_ < var_116_2 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play926021029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 926021029
		arg_117_1.duration_ = 5.77

		local var_117_0 = {
			zh = 3.3,
			ja = 5.766
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play926021030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10144"]) and arg_117_1.var_.actorSpriteComps10144 == nil then
				arg_117_1.var_.actorSpriteComps10144 = arg_117_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10144"]) then
				if arg_117_1.var_.actorSpriteComps10144 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 1, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10144"]) and arg_117_1.var_.actorSpriteComps10144 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10144 = nil
			end

			local var_120_2 = arg_117_1.actors_["10144"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10144 = var_120_2.localPosition
				var_120_2.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10144", 3)

				for iter_120_4 = 0, var_120_2.childCount - 1 do
					local var_120_3 = var_120_2:GetChild(iter_120_4)

					if var_120_3.name == "" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_2.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_117_1.time_ - 0) / var_120_4)
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_120_5 = 0
			local var_120_6 = 0.425

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(926021029)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 17 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 17)

				if (17 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 17)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021029", "story_v_out_926021.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021029", "story_v_out_926021.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_926021", "926021029", "story_v_out_926021.awb")

						arg_117_1:RecordAudio("926021029", var_120_12)
						arg_117_1:RecordAudio("926021029", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_926021", "926021029", "story_v_out_926021.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_926021", "926021029", "story_v_out_926021.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play926021030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 926021030
		arg_121_1.duration_ = 4.83

		local var_121_0 = {
			zh = 4.566,
			ja = 4.833
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play926021031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(926021030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 25 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 25)

				if (25 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 25)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021030", "story_v_out_926021.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021030", "story_v_out_926021.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_926021", "926021030", "story_v_out_926021.awb")

						arg_121_1:RecordAudio("926021030", var_124_6)
						arg_121_1:RecordAudio("926021030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_926021", "926021030", "story_v_out_926021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_926021", "926021030", "story_v_out_926021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play926021031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 926021031
		arg_125_1.duration_ = 7.13

		local var_125_0 = {
			zh = 5.666,
			ja = 7.133
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play926021032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.8

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(926021031)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 32 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 32)

				if (32 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 32)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021031", "story_v_out_926021.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021031", "story_v_out_926021.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_926021", "926021031", "story_v_out_926021.awb")

						arg_125_1:RecordAudio("926021031", var_128_6)
						arg_125_1:RecordAudio("926021031", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_926021", "926021031", "story_v_out_926021.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_926021", "926021031", "story_v_out_926021.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play926021032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 926021032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play926021033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10144"]) and arg_129_1.var_.actorSpriteComps10144 == nil then
				arg_129_1.var_.actorSpriteComps10144 = arg_129_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10144"]) then
				if arg_129_1.var_.actorSpriteComps10144 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10144"]) and arg_129_1.var_.actorSpriteComps10144 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps10144 = nil
			end

			local var_132_2 = 0
			local var_132_3 = 0.25

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_4 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(926021032).content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_6 = 10 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_4) / 10)

				if (10 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_4) / 10)) > 0 and var_132_3 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_7 and arg_129_1.time_ < var_132_2 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play926021033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 926021033
		arg_133_1.duration_ = 4

		local var_133_0 = {
			zh = 1.833,
			ja = 4
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play926021034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10144"]) and arg_133_1.var_.actorSpriteComps10144 == nil then
				arg_133_1.var_.actorSpriteComps10144 = arg_133_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10144"]) then
				if arg_133_1.var_.actorSpriteComps10144 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								iter_136_1.color = Color.New(Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_0), Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_0), (Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_0)))
							else
								local var_136_1 = Mathf.Lerp(iter_136_1.color.r, 1, (arg_133_1.time_ - 0) / var_136_0)

								iter_136_1.color = Color.New(var_136_1, var_136_1, var_136_1)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10144"]) and arg_133_1.var_.actorSpriteComps10144 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10144 = nil
			end

			local var_136_2 = arg_133_1.actors_["10144"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10144 = var_136_2.localPosition
				var_136_2.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10144", 3)

				for iter_136_4 = 0, var_136_2.childCount - 1 do
					local var_136_3 = var_136_2:GetChild(iter_136_4)

					if var_136_3.name == "split_2" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				var_136_2.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_133_1.time_ - 0) / var_136_4)
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				var_136_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_136_5 = 0
			local var_136_6 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_7 = arg_133_1:GetWordFromCfg(926021033)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 10 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 10)

				if (10 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 10)) > 0 and var_136_6 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021033", "story_v_out_926021.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021033", "story_v_out_926021.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_926021", "926021033", "story_v_out_926021.awb")

						arg_133_1:RecordAudio("926021033", var_136_12)
						arg_133_1:RecordAudio("926021033", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_926021", "926021033", "story_v_out_926021.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_926021", "926021033", "story_v_out_926021.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_6, arg_133_1.talkMaxDuration)

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_5) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_5 + var_136_13 and arg_133_1.time_ < var_136_5 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play926021034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 926021034
		arg_137_1.duration_ = 4.17

		local var_137_0 = {
			zh = 3.233,
			ja = 4.166
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play926021035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["104701"]) and arg_137_1.var_.actorSpriteComps104701 == nil then
				arg_137_1.var_.actorSpriteComps104701 = arg_137_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["104701"]) then
				if arg_137_1.var_.actorSpriteComps104701 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 1, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["104701"]) and arg_137_1.var_.actorSpriteComps104701 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps104701 = nil
			end

			local var_140_2 = arg_137_1.actors_["10144"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10144 == nil then
				arg_137_1.var_.actorSpriteComps10144 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10144 then
					for iter_140_4, iter_140_5 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_140_5 then
							if arg_137_1.isInRecall_ then
								iter_140_5.color = Color.New(Mathf.Lerp(iter_140_5.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_5.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_5.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_5.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_5.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10144 then
				for iter_140_6, iter_140_7 in pairs(arg_137_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_140_7 then
						iter_140_7.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10144 = nil
			end

			local var_140_5 = arg_137_1.actors_["104701"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos104701 = var_140_5.localPosition
				var_140_5.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("104701", 3)

				for iter_140_8 = 0, var_140_5.childCount - 1 do
					local var_140_6 = var_140_5:GetChild(iter_140_8)

					if var_140_6.name == "" or not string.find(var_140_6.name, "split") then
						var_140_6.gameObject:SetActive(true)
					else
						var_140_6.gameObject:SetActive(false)
					end
				end
			end

			local var_140_7 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				var_140_5.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_137_1.time_ - 0) / var_140_7)
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				var_140_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_140_8 = arg_137_1.actors_["10144"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10144 = var_140_8.localPosition
				var_140_8.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10144", 7)

				for iter_140_9 = 0, var_140_8.childCount - 1 do
					local var_140_9 = var_140_8:GetChild(iter_140_9)

					if var_140_9.name == "" or not string.find(var_140_9.name, "split") then
						var_140_9.gameObject:SetActive(true)
					else
						var_140_9.gameObject:SetActive(false)
					end
				end
			end

			local var_140_10 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_10 then
				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_137_1.time_ - 0) / var_140_10)
			end

			if arg_137_1.time_ >= 0 + var_140_10 and arg_137_1.time_ < 0 + var_140_10 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_140_11 = 0
			local var_140_12 = 0.325

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_13 = arg_137_1:GetWordFromCfg(926021034)
				local var_140_14 = arg_137_1:FormatText(var_140_13.content)

				arg_137_1.text_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 13 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 13)

				if (13 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 13)) > 0 and var_140_12 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16

					if var_140_16 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_14
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021034", "story_v_out_926021.awb") ~= 0 then
					local var_140_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021034", "story_v_out_926021.awb") / 1000

					if var_140_17 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_11
					end

					if var_140_13.prefab_name ~= "" and arg_137_1.actors_[var_140_13.prefab_name] ~= nil then
						local var_140_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_13.prefab_name].transform, "story_v_out_926021", "926021034", "story_v_out_926021.awb")

						arg_137_1:RecordAudio("926021034", var_140_18)
						arg_137_1:RecordAudio("926021034", var_140_18)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_926021", "926021034", "story_v_out_926021.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_926021", "926021034", "story_v_out_926021.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_19 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 <= arg_137_1.time_ and arg_137_1.time_ < var_140_11 + var_140_19 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_11) / var_140_19

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_11 + var_140_19 and arg_137_1.time_ < var_140_11 + var_140_19 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play926021035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926021035
		arg_141_1.duration_ = 12.1

		local var_141_0 = {
			zh = 11.1,
			ja = 12.1
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play926021036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 == nil then
				arg_141_1.var_.actorSpriteComps10144 = arg_141_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10144"]) then
				if arg_141_1.var_.actorSpriteComps10144 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 1, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10144"]) and arg_141_1.var_.actorSpriteComps10144 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10144 = nil
			end

			local var_144_2 = arg_141_1.actors_["104701"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps104701 == nil then
				arg_141_1.var_.actorSpriteComps104701 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps104701 then
					for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_144_5 then
							if arg_141_1.isInRecall_ then
								iter_144_5.color = Color.New(Mathf.Lerp(iter_144_5.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_5.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_5.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_5.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_5.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps104701 then
				for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_144_7 then
						iter_144_7.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps104701 = nil
			end

			local var_144_5 = arg_141_1.actors_["104701"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos104701 = var_144_5.localPosition
				var_144_5.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("104701", 4)

				for iter_144_8 = 0, var_144_5.childCount - 1 do
					local var_144_6 = var_144_5:GetChild(iter_144_8)

					if var_144_6.name == "" or not string.find(var_144_6.name, "split") then
						var_144_6.gameObject:SetActive(true)
					else
						var_144_6.gameObject:SetActive(false)
					end
				end
			end

			local var_144_7 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				var_144_5.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_141_1.time_ - 0) / var_144_7)
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				var_144_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_144_8 = arg_141_1.actors_["10144"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10144 = var_144_8.localPosition
				var_144_8.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10144", 2)

				for iter_144_9 = 0, var_144_8.childCount - 1 do
					local var_144_9 = var_144_8:GetChild(iter_144_9)

					if var_144_9.name == "" or not string.find(var_144_9.name, "split") then
						var_144_9.gameObject:SetActive(true)
					else
						var_144_9.gameObject:SetActive(false)
					end
				end
			end

			local var_144_10 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_10 then
				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_141_1.time_ - 0) / var_144_10)
			end

			if arg_141_1.time_ >= 0 + var_144_10 and arg_141_1.time_ < 0 + var_144_10 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_144_11 = 0
			local var_144_12 = 1.375

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(926021035)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 57 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 57)

				if (57 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 57)) > 0 and var_144_12 < var_144_16 then
					arg_141_1.talkMaxDuration = var_144_16

					if var_144_16 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021035", "story_v_out_926021.awb") ~= 0 then
					local var_144_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021035", "story_v_out_926021.awb") / 1000

					if var_144_17 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_11
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_926021", "926021035", "story_v_out_926021.awb")

						arg_141_1:RecordAudio("926021035", var_144_18)
						arg_141_1:RecordAudio("926021035", var_144_18)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_926021", "926021035", "story_v_out_926021.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_926021", "926021035", "story_v_out_926021.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_19 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_19

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_19 and arg_141_1.time_ < var_144_11 + var_144_19 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play926021036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926021036
		arg_145_1.duration_ = 2.97

		local var_145_0 = {
			zh = 2.966,
			ja = 1.666
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play926021037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["104701"]) and arg_145_1.var_.actorSpriteComps104701 == nil then
				arg_145_1.var_.actorSpriteComps104701 = arg_145_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["104701"]) then
				if arg_145_1.var_.actorSpriteComps104701 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 1, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["104701"]) and arg_145_1.var_.actorSpriteComps104701 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps104701 = nil
			end

			local var_148_2 = arg_145_1.actors_["10144"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10144 == nil then
				arg_145_1.var_.actorSpriteComps10144 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps10144 then
					for iter_148_4, iter_148_5 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_148_5 then
							if arg_145_1.isInRecall_ then
								iter_148_5.color = Color.New(Mathf.Lerp(iter_148_5.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_5.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_5.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_5.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_5.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10144 then
				for iter_148_6, iter_148_7 in pairs(arg_145_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_148_7 then
						iter_148_7.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps10144 = nil
			end

			local var_148_5 = arg_145_1.actors_["104701"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos104701 = var_148_5.localPosition
				var_148_5.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("104701", 4)

				for iter_148_8 = 0, var_148_5.childCount - 1 do
					local var_148_6 = var_148_5:GetChild(iter_148_8)

					if var_148_6.name == "split_5" or not string.find(var_148_6.name, "split") then
						var_148_6.gameObject:SetActive(true)
					else
						var_148_6.gameObject:SetActive(false)
					end
				end
			end

			local var_148_7 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				var_148_5.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_145_1.time_ - 0) / var_148_7)
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				var_148_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_148_8 = 0
			local var_148_9 = 0.275

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(926021036)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 11 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 11)

				if (11 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 11)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021036", "story_v_out_926021.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021036", "story_v_out_926021.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_926021", "926021036", "story_v_out_926021.awb")

						arg_145_1:RecordAudio("926021036", var_148_15)
						arg_145_1:RecordAudio("926021036", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926021", "926021036", "story_v_out_926021.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926021", "926021036", "story_v_out_926021.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play926021037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926021037
		arg_149_1.duration_ = 11.93

		local var_149_0 = {
			zh = 6.6,
			ja = 11.933
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926021038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10144"]) and arg_149_1.var_.actorSpriteComps10144 == nil then
				arg_149_1.var_.actorSpriteComps10144 = arg_149_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10144"]) then
				if arg_149_1.var_.actorSpriteComps10144 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor1.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor1.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor1.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 1, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10144"]) and arg_149_1.var_.actorSpriteComps10144 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_149_1.var_.actorSpriteComps10144 = nil
			end

			local var_152_2 = arg_149_1.actors_["104701"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps104701 == nil then
				arg_149_1.var_.actorSpriteComps104701 = var_152_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_3 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.actorSpriteComps104701 then
					for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_152_5 then
							if arg_149_1.isInRecall_ then
								iter_152_5.color = Color.New(Mathf.Lerp(iter_152_5.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_3), Mathf.Lerp(iter_152_5.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_3), (Mathf.Lerp(iter_152_5.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_3)))
							else
								local var_152_4 = Mathf.Lerp(iter_152_5.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_3)

								iter_152_5.color = Color.New(var_152_4, var_152_4, var_152_4)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.actorSpriteComps104701 then
				for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_152_7 then
						iter_152_7.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps104701 = nil
			end

			local var_152_5 = 0
			local var_152_6 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(926021037)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 31 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 31)

				if (31 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 31)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021037", "story_v_out_926021.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021037", "story_v_out_926021.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_926021", "926021037", "story_v_out_926021.awb")

						arg_149_1:RecordAudio("926021037", var_152_12)
						arg_149_1:RecordAudio("926021037", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_926021", "926021037", "story_v_out_926021.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_926021", "926021037", "story_v_out_926021.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_13 and arg_149_1.time_ < var_152_5 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926021038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926021038
		arg_153_1.duration_ = 6.37

		local var_153_0 = {
			zh = 5.966,
			ja = 6.366
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play926021039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["104701"]) and arg_153_1.var_.actorSpriteComps104701 == nil then
				arg_153_1.var_.actorSpriteComps104701 = arg_153_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["104701"]) then
				if arg_153_1.var_.actorSpriteComps104701 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_156_1 then
							if arg_153_1.isInRecall_ then
								iter_156_1.color = Color.New(Mathf.Lerp(iter_156_1.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_0), Mathf.Lerp(iter_156_1.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_0), (Mathf.Lerp(iter_156_1.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_0)))
							else
								local var_156_1 = Mathf.Lerp(iter_156_1.color.r, 1, (arg_153_1.time_ - 0) / var_156_0)

								iter_156_1.color = Color.New(var_156_1, var_156_1, var_156_1)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["104701"]) and arg_153_1.var_.actorSpriteComps104701 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps104701 = nil
			end

			local var_156_2 = arg_153_1.actors_["10144"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10144 == nil then
				arg_153_1.var_.actorSpriteComps10144 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps10144 then
					for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_156_5 then
							if arg_153_1.isInRecall_ then
								iter_156_5.color = Color.New(Mathf.Lerp(iter_156_5.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_5.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_5.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_5.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_5.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10144 then
				for iter_156_6, iter_156_7 in pairs(arg_153_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_156_7 then
						iter_156_7.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10144 = nil
			end

			local var_156_5 = arg_153_1.actors_["104701"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos104701 = var_156_5.localPosition
				var_156_5.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("104701", 4)

				for iter_156_8 = 0, var_156_5.childCount - 1 do
					local var_156_6 = var_156_5:GetChild(iter_156_8)

					if var_156_6.name == "split_1" or not string.find(var_156_6.name, "split") then
						var_156_6.gameObject:SetActive(true)
					else
						var_156_6.gameObject:SetActive(false)
					end
				end
			end

			local var_156_7 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				var_156_5.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_153_1.time_ - 0) / var_156_7)
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				var_156_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_156_8 = 0
			local var_156_9 = 0.775

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(926021038)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 31 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 31)

				if (31 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 31)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021038", "story_v_out_926021.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021038", "story_v_out_926021.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_926021", "926021038", "story_v_out_926021.awb")

						arg_153_1:RecordAudio("926021038", var_156_15)
						arg_153_1:RecordAudio("926021038", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926021", "926021038", "story_v_out_926021.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926021", "926021038", "story_v_out_926021.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play926021039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926021039
		arg_157_1.duration_ = 2.8

		local var_157_0 = {
			zh = 1.7,
			ja = 2.8
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926021040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 == nil then
				arg_157_1.var_.actorSpriteComps10144 = arg_157_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10144"]) then
				if arg_157_1.var_.actorSpriteComps10144 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 1, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10144"]) and arg_157_1.var_.actorSpriteComps10144 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10144 = nil
			end

			local var_160_2 = arg_157_1.actors_["104701"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps104701 == nil then
				arg_157_1.var_.actorSpriteComps104701 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps104701 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								iter_160_5.color = Color.New(Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_5.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_5.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps104701 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_160_7 then
						iter_160_7.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps104701 = nil
			end

			local var_160_5 = arg_157_1.actors_["10144"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10144 = var_160_5.localPosition
				var_160_5.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10144", 2)

				for iter_160_8 = 0, var_160_5.childCount - 1 do
					local var_160_6 = var_160_5:GetChild(iter_160_8)

					if var_160_6.name == "" or not string.find(var_160_6.name, "split") then
						var_160_6.gameObject:SetActive(true)
					else
						var_160_6.gameObject:SetActive(false)
					end
				end
			end

			local var_160_7 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_157_1.time_ - 0) / var_160_7)
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_160_8 = 0
			local var_160_9 = 0.2

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(926021039)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 8 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 8)

				if (8 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 8)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021039", "story_v_out_926021.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021039", "story_v_out_926021.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_926021", "926021039", "story_v_out_926021.awb")

						arg_157_1:RecordAudio("926021039", var_160_15)
						arg_157_1:RecordAudio("926021039", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_926021", "926021039", "story_v_out_926021.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_926021", "926021039", "story_v_out_926021.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play926021040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 926021040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play926021041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(arg_161_1.actors_["10144"]) and arg_161_1.var_.actorSpriteComps10144 == nil then
				arg_161_1.var_.actorSpriteComps10144 = arg_161_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_0 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 and not isNil(arg_161_1.actors_["10144"]) then
				if arg_161_1.var_.actorSpriteComps10144 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								iter_164_1.color = Color.New(Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_0), Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_0), (Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_0)))
							else
								local var_164_1 = Mathf.Lerp(iter_164_1.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_0)

								iter_164_1.color = Color.New(var_164_1, var_164_1, var_164_1)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 and not isNil(arg_161_1.actors_["10144"]) and arg_161_1.var_.actorSpriteComps10144 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_164_3 then
						iter_164_3.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10144 = nil
			end

			local var_164_2 = arg_161_1.actors_["104701"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos104701 = var_164_2.localPosition
				var_164_2.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("104701", 7)

				for iter_164_4 = 0, var_164_2.childCount - 1 do
					local var_164_3 = var_164_2:GetChild(iter_164_4)

					if var_164_3.name == "" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_161_1.time_ - 0) / var_164_4)
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_164_5 = arg_161_1.actors_["10144"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10144 = var_164_5.localPosition
				var_164_5.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10144", 7)

				for iter_164_5 = 0, var_164_5.childCount - 1 do
					local var_164_6 = var_164_5:GetChild(iter_164_5)

					if var_164_6.name == "" or not string.find(var_164_6.name, "split") then
						var_164_6.gameObject:SetActive(true)
					else
						var_164_6.gameObject:SetActive(false)
					end
				end
			end

			local var_164_7 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				var_164_5.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_161_1.time_ - 0) / var_164_7)
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				var_164_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_161_1.time_ and arg_161_1.time_ <= 0.166666666666667 + arg_164_0 then
				arg_161_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data01", "")
			end

			local var_164_9 = 0
			local var_164_10 = 1.175

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_11 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(926021040).content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 47 <= 0 and var_164_10 or var_164_10 * (utf8.len(var_164_11) / 47)

				if (47 <= 0 and var_164_10 or var_164_10 * (utf8.len(var_164_11) / 47)) > 0 and var_164_10 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_9 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_9
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_10, arg_161_1.talkMaxDuration)

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_9) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_9 + var_164_14 and arg_161_1.time_ < var_164_9 + var_164_14 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play926021041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 926021041
		arg_165_1.duration_ = 13.8

		local var_165_0 = {
			zh = 7.433,
			ja = 13.8
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play926021042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10144"]) and arg_165_1.var_.actorSpriteComps10144 == nil then
				arg_165_1.var_.actorSpriteComps10144 = arg_165_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10144"]) then
				if arg_165_1.var_.actorSpriteComps10144 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 1, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10144"]) and arg_165_1.var_.actorSpriteComps10144 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10144 = nil
			end

			local var_168_2 = arg_165_1.actors_["10144"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10144 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10144", 3)

				for iter_168_4 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_4)

					if var_168_3.name == "split_8" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_168_5 = 0
			local var_168_6 = 1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(926021041)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 40 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 40)

				if (40 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 40)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021041", "story_v_out_926021.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021041", "story_v_out_926021.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_926021", "926021041", "story_v_out_926021.awb")

						arg_165_1:RecordAudio("926021041", var_168_12)
						arg_165_1:RecordAudio("926021041", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_926021", "926021041", "story_v_out_926021.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_926021", "926021041", "story_v_out_926021.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play926021042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 926021042
		arg_169_1.duration_ = 9.77

		local var_169_0 = {
			zh = 6.666,
			ja = 9.766
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play926021043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.825

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(926021042)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 33 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 33)

				if (33 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 33)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021042", "story_v_out_926021.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021042", "story_v_out_926021.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_926021", "926021042", "story_v_out_926021.awb")

						arg_169_1:RecordAudio("926021042", var_172_6)
						arg_169_1:RecordAudio("926021042", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_926021", "926021042", "story_v_out_926021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_926021", "926021042", "story_v_out_926021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play926021043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 926021043
		arg_173_1.duration_ = 2.43

		local var_173_0 = {
			zh = 2.2,
			ja = 2.433
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play926021044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10144 = arg_173_1.actors_["10144"].transform.localPosition
				arg_173_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10144", 3)

				for iter_176_0 = 0, arg_173_1.actors_["10144"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["10144"].transform:GetChild(iter_176_0)

					if var_176_0.name == "split_8" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_176_2 = 0
			local var_176_3 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:GetWordFromCfg(926021043)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 9 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 9)

				if (9 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 9)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021043", "story_v_out_926021.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021043", "story_v_out_926021.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_926021", "926021043", "story_v_out_926021.awb")

						arg_173_1:RecordAudio("926021043", var_176_9)
						arg_173_1:RecordAudio("926021043", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_926021", "926021043", "story_v_out_926021.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_926021", "926021043", "story_v_out_926021.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play926021044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 926021044
		arg_177_1.duration_ = 1.57

		local var_177_0 = {
			zh = 0.999999999999,
			ja = 1.566
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play926021045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["106103"]) and arg_177_1.var_.actorSpriteComps106103 == nil then
				arg_177_1.var_.actorSpriteComps106103 = arg_177_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_0 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["106103"]) then
				if arg_177_1.var_.actorSpriteComps106103 then
					for iter_180_0, iter_180_1 in pairs(arg_177_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_180_1 then
							if arg_177_1.isInRecall_ then
								iter_180_1.color = Color.New(Mathf.Lerp(iter_180_1.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_0), Mathf.Lerp(iter_180_1.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_0), (Mathf.Lerp(iter_180_1.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_0)))
							else
								local var_180_1 = Mathf.Lerp(iter_180_1.color.r, 1, (arg_177_1.time_ - 0) / var_180_0)

								iter_180_1.color = Color.New(var_180_1, var_180_1, var_180_1)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["106103"]) and arg_177_1.var_.actorSpriteComps106103 then
				for iter_180_2, iter_180_3 in pairs(arg_177_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_180_3 then
						iter_180_3.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps106103 = nil
			end

			local var_180_2 = arg_177_1.actors_["10144"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10144 == nil then
				arg_177_1.var_.actorSpriteComps10144 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps10144 then
					for iter_180_4, iter_180_5 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_180_5 then
							if arg_177_1.isInRecall_ then
								iter_180_5.color = Color.New(Mathf.Lerp(iter_180_5.color.r, arg_177_1.hightColor2.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_5.color.g, arg_177_1.hightColor2.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_5.color.b, arg_177_1.hightColor2.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_5.color.r, 0.5, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_5.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10144 then
				for iter_180_6, iter_180_7 in pairs(arg_177_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_180_7 then
						iter_180_7.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_177_1.var_.actorSpriteComps10144 = nil
			end

			local var_180_5 = 0
			local var_180_6 = 0.075

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_7 = arg_177_1:GetWordFromCfg(926021044)
				local var_180_8 = arg_177_1:FormatText(var_180_7.content)

				arg_177_1.text_.text = var_180_8

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_10 = 3 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 3)

				if (3 <= 0 and var_180_6 or var_180_6 * (utf8.len(var_180_8) / 3)) > 0 and var_180_6 < var_180_10 then
					arg_177_1.talkMaxDuration = var_180_10

					if var_180_10 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_5
					end
				end

				arg_177_1.text_.text = var_180_8
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021044", "story_v_out_926021.awb") ~= 0 then
					local var_180_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021044", "story_v_out_926021.awb") / 1000

					if var_180_11 + var_180_5 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_5
					end

					if var_180_7.prefab_name ~= "" and arg_177_1.actors_[var_180_7.prefab_name] ~= nil then
						local var_180_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_7.prefab_name].transform, "story_v_out_926021", "926021044", "story_v_out_926021.awb")

						arg_177_1:RecordAudio("926021044", var_180_12)
						arg_177_1:RecordAudio("926021044", var_180_12)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_926021", "926021044", "story_v_out_926021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_926021", "926021044", "story_v_out_926021.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_6, arg_177_1.talkMaxDuration)

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_5) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_5 + var_180_13 and arg_177_1.time_ < var_180_5 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play926021045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 926021045
		arg_181_1.duration_ = 15.27

		local var_181_0 = {
			zh = 8.9,
			ja = 15.266
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play926021046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10144"]) and arg_181_1.var_.actorSpriteComps10144 == nil then
				arg_181_1.var_.actorSpriteComps10144 = arg_181_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10144"]) then
				if arg_181_1.var_.actorSpriteComps10144 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								iter_184_1.color = Color.New(Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor1.r, (arg_181_1.time_ - 0) / var_184_0), Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor1.g, (arg_181_1.time_ - 0) / var_184_0), (Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor1.b, (arg_181_1.time_ - 0) / var_184_0)))
							else
								local var_184_1 = Mathf.Lerp(iter_184_1.color.r, 1, (arg_181_1.time_ - 0) / var_184_0)

								iter_184_1.color = Color.New(var_184_1, var_184_1, var_184_1)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10144"]) and arg_181_1.var_.actorSpriteComps10144 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_181_1.var_.actorSpriteComps10144 = nil
			end

			local var_184_2 = arg_181_1.actors_["106103"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps106103 == nil then
				arg_181_1.var_.actorSpriteComps106103 = var_184_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_3 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.actorSpriteComps106103 then
					for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_184_5 then
							if arg_181_1.isInRecall_ then
								iter_184_5.color = Color.New(Mathf.Lerp(iter_184_5.color.r, arg_181_1.hightColor2.r, (arg_181_1.time_ - 0) / var_184_3), Mathf.Lerp(iter_184_5.color.g, arg_181_1.hightColor2.g, (arg_181_1.time_ - 0) / var_184_3), (Mathf.Lerp(iter_184_5.color.b, arg_181_1.hightColor2.b, (arg_181_1.time_ - 0) / var_184_3)))
							else
								local var_184_4 = Mathf.Lerp(iter_184_5.color.r, 0.5, (arg_181_1.time_ - 0) / var_184_3)

								iter_184_5.color = Color.New(var_184_4, var_184_4, var_184_4)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.actorSpriteComps106103 then
				for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_184_7 then
						iter_184_7.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps106103 = nil
			end

			local var_184_5 = 0
			local var_184_6 = 1.1

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_7 = arg_181_1:GetWordFromCfg(926021045)
				local var_184_8 = arg_181_1:FormatText(var_184_7.content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 44 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 44)

				if (44 <= 0 and var_184_6 or var_184_6 * (utf8.len(var_184_8) / 44)) > 0 and var_184_6 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_5
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021045", "story_v_out_926021.awb") ~= 0 then
					local var_184_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021045", "story_v_out_926021.awb") / 1000

					if var_184_11 + var_184_5 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_5
					end

					if var_184_7.prefab_name ~= "" and arg_181_1.actors_[var_184_7.prefab_name] ~= nil then
						local var_184_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_7.prefab_name].transform, "story_v_out_926021", "926021045", "story_v_out_926021.awb")

						arg_181_1:RecordAudio("926021045", var_184_12)
						arg_181_1:RecordAudio("926021045", var_184_12)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_926021", "926021045", "story_v_out_926021.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_926021", "926021045", "story_v_out_926021.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_13 = math.max(var_184_6, arg_181_1.talkMaxDuration)

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_13 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_5) / var_184_13

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_5 + var_184_13 and arg_181_1.time_ < var_184_5 + var_184_13 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play926021046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 926021046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play926021047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["10144"]) and arg_185_1.var_.actorSpriteComps10144 == nil then
				arg_185_1.var_.actorSpriteComps10144 = arg_185_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["10144"]) then
				if arg_185_1.var_.actorSpriteComps10144 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								iter_188_1.color = Color.New(Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_0), Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_0), (Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_0)))
							else
								local var_188_1 = Mathf.Lerp(iter_188_1.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_0)

								iter_188_1.color = Color.New(var_188_1, var_188_1, var_188_1)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["10144"]) and arg_185_1.var_.actorSpriteComps10144 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_188_3 then
						iter_188_3.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10144 = nil
			end

			local var_188_2 = 0
			local var_188_3 = 0.25

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_4 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(926021046).content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_6 = 10 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 10)

				if (10 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_4) / 10)) > 0 and var_188_3 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_7 and arg_185_1.time_ < var_188_2 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play926021047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 926021047
		arg_189_1.duration_ = 7.3

		local var_189_0 = {
			zh = 7.3,
			ja = 6.3
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play926021048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["106103"]) and arg_189_1.var_.actorSpriteComps106103 == nil then
				arg_189_1.var_.actorSpriteComps106103 = arg_189_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["106103"]) then
				if arg_189_1.var_.actorSpriteComps106103 then
					for iter_192_0, iter_192_1 in pairs(arg_189_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_192_1 then
							if arg_189_1.isInRecall_ then
								iter_192_1.color = Color.New(Mathf.Lerp(iter_192_1.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_0), Mathf.Lerp(iter_192_1.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_0), (Mathf.Lerp(iter_192_1.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_0)))
							else
								local var_192_1 = Mathf.Lerp(iter_192_1.color.r, 1, (arg_189_1.time_ - 0) / var_192_0)

								iter_192_1.color = Color.New(var_192_1, var_192_1, var_192_1)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["106103"]) and arg_189_1.var_.actorSpriteComps106103 then
				for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_192_3 then
						iter_192_3.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps106103 = nil
			end

			local var_192_2 = arg_189_1.actors_["10144"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10144 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10144", 7)

				for iter_192_4 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_4)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_192_5 = arg_189_1.actors_["106103"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos106103 = var_192_5.localPosition
				var_192_5.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("106103", 3)

				for iter_192_5 = 0, var_192_5.childCount - 1 do
					local var_192_6 = var_192_5:GetChild(iter_192_5)

					if var_192_6.name == "split_4" or not string.find(var_192_6.name, "split") then
						var_192_6.gameObject:SetActive(true)
					else
						var_192_6.gameObject:SetActive(false)
					end
				end
			end

			local var_192_7 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_189_1.time_ - 0) / var_192_7)
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_192_8 = 0
			local var_192_9 = 0.8

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(926021047)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 32 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 32)

				if (32 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 32)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021047", "story_v_out_926021.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021047", "story_v_out_926021.awb") / 1000

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_926021", "926021047", "story_v_out_926021.awb")

						arg_189_1:RecordAudio("926021047", var_192_15)
						arg_189_1:RecordAudio("926021047", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_926021", "926021047", "story_v_out_926021.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_926021", "926021047", "story_v_out_926021.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play926021048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 926021048
		arg_193_1.duration_ = 8.17

		local var_193_0 = {
			zh = 5.6,
			ja = 8.166
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play926021049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["128404"]) and arg_193_1.var_.actorSpriteComps128404 == nil then
				arg_193_1.var_.actorSpriteComps128404 = arg_193_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["128404"]) then
				if arg_193_1.var_.actorSpriteComps128404 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 1, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["128404"]) and arg_193_1.var_.actorSpriteComps128404 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps128404 = nil
			end

			local var_196_2 = arg_193_1.actors_["106103"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps106103 == nil then
				arg_193_1.var_.actorSpriteComps106103 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps106103 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								iter_196_5.color = Color.New(Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_5.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_5.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps106103 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_196_7 then
						iter_196_7.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps106103 = nil
			end

			local var_196_5 = arg_193_1.actors_["106103"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos106103 = var_196_5.localPosition
				var_196_5.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("106103", 7)

				for iter_196_8 = 0, var_196_5.childCount - 1 do
					local var_196_6 = var_196_5:GetChild(iter_196_8)

					if var_196_6.name == "" or not string.find(var_196_6.name, "split") then
						var_196_6.gameObject:SetActive(true)
					else
						var_196_6.gameObject:SetActive(false)
					end
				end
			end

			local var_196_7 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				var_196_5.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_193_1.time_ - 0) / var_196_7)
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				var_196_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_196_8 = arg_193_1.actors_["128404"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos128404 = var_196_8.localPosition
				var_196_8.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("128404", 3)

				for iter_196_9 = 0, var_196_8.childCount - 1 do
					local var_196_9 = var_196_8:GetChild(iter_196_9)

					if var_196_9.name == "" or not string.find(var_196_9.name, "split") then
						var_196_9.gameObject:SetActive(true)
					else
						var_196_9.gameObject:SetActive(false)
					end
				end
			end

			local var_196_10 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_10 then
				var_196_8.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_193_1.time_ - 0) / var_196_10)
			end

			if arg_193_1.time_ >= 0 + var_196_10 and arg_193_1.time_ < 0 + var_196_10 + arg_196_0 then
				var_196_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_196_11 = 0
			local var_196_12 = 0.7

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(926021048)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 28 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 28)

				if (28 <= 0 and var_196_12 or var_196_12 * (utf8.len(var_196_14) / 28)) > 0 and var_196_12 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16

					if var_196_16 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021048", "story_v_out_926021.awb") ~= 0 then
					local var_196_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021048", "story_v_out_926021.awb") / 1000

					if var_196_17 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_11
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_926021", "926021048", "story_v_out_926021.awb")

						arg_193_1:RecordAudio("926021048", var_196_18)
						arg_193_1:RecordAudio("926021048", var_196_18)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_926021", "926021048", "story_v_out_926021.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_926021", "926021048", "story_v_out_926021.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_19 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_19

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_19 and arg_193_1.time_ < var_196_11 + var_196_19 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play926021049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 926021049
		arg_197_1.duration_ = 11.1

		local var_197_0 = {
			zh = 7.133,
			ja = 11.1
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play926021050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10144"]) and arg_197_1.var_.actorSpriteComps10144 == nil then
				arg_197_1.var_.actorSpriteComps10144 = arg_197_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10144"]) then
				if arg_197_1.var_.actorSpriteComps10144 then
					for iter_200_0, iter_200_1 in pairs(arg_197_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_200_1 then
							if arg_197_1.isInRecall_ then
								iter_200_1.color = Color.New(Mathf.Lerp(iter_200_1.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_0), Mathf.Lerp(iter_200_1.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_0), (Mathf.Lerp(iter_200_1.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_0)))
							else
								local var_200_1 = Mathf.Lerp(iter_200_1.color.r, 1, (arg_197_1.time_ - 0) / var_200_0)

								iter_200_1.color = Color.New(var_200_1, var_200_1, var_200_1)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10144"]) and arg_197_1.var_.actorSpriteComps10144 then
				for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_200_3 then
						iter_200_3.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10144 = nil
			end

			local var_200_2 = arg_197_1.actors_["128404"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps128404 == nil then
				arg_197_1.var_.actorSpriteComps128404 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps128404 then
					for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_200_5 then
							if arg_197_1.isInRecall_ then
								iter_200_5.color = Color.New(Mathf.Lerp(iter_200_5.color.r, arg_197_1.hightColor2.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_5.color.g, arg_197_1.hightColor2.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_5.color.b, arg_197_1.hightColor2.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_5.color.r, 0.5, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_5.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps128404 then
				for iter_200_6, iter_200_7 in pairs(arg_197_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_200_7 then
						iter_200_7.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_197_1.var_.actorSpriteComps128404 = nil
			end

			local var_200_5 = arg_197_1.actors_["128404"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos128404 = var_200_5.localPosition
				var_200_5.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("128404", 7)

				for iter_200_8 = 0, var_200_5.childCount - 1 do
					local var_200_6 = var_200_5:GetChild(iter_200_8)

					if var_200_6.name == "" or not string.find(var_200_6.name, "split") then
						var_200_6.gameObject:SetActive(true)
					else
						var_200_6.gameObject:SetActive(false)
					end
				end
			end

			local var_200_7 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				var_200_5.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_197_1.time_ - 0) / var_200_7)
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				var_200_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_200_8 = arg_197_1.actors_["10144"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10144 = var_200_8.localPosition
				var_200_8.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10144", 3)

				for iter_200_9 = 0, var_200_8.childCount - 1 do
					local var_200_9 = var_200_8:GetChild(iter_200_9)

					if var_200_9.name == "split_10" or not string.find(var_200_9.name, "split") then
						var_200_9.gameObject:SetActive(true)
					else
						var_200_9.gameObject:SetActive(false)
					end
				end
			end

			local var_200_10 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_10 then
				var_200_8.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_197_1.time_ - 0) / var_200_10)
			end

			if arg_197_1.time_ >= 0 + var_200_10 and arg_197_1.time_ < 0 + var_200_10 + arg_200_0 then
				var_200_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_200_11 = 0
			local var_200_12 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_11 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_13 = arg_197_1:GetWordFromCfg(926021049)
				local var_200_14 = arg_197_1:FormatText(var_200_13.content)

				arg_197_1.text_.text = var_200_14

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_16 = 27 <= 0 and var_200_12 or var_200_12 * (utf8.len(var_200_14) / 27)

				if (27 <= 0 and var_200_12 or var_200_12 * (utf8.len(var_200_14) / 27)) > 0 and var_200_12 < var_200_16 then
					arg_197_1.talkMaxDuration = var_200_16

					if var_200_16 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_16 + var_200_11
					end
				end

				arg_197_1.text_.text = var_200_14
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021049", "story_v_out_926021.awb") ~= 0 then
					local var_200_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021049", "story_v_out_926021.awb") / 1000

					if var_200_17 + var_200_11 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_17 + var_200_11
					end

					if var_200_13.prefab_name ~= "" and arg_197_1.actors_[var_200_13.prefab_name] ~= nil then
						local var_200_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_13.prefab_name].transform, "story_v_out_926021", "926021049", "story_v_out_926021.awb")

						arg_197_1:RecordAudio("926021049", var_200_18)
						arg_197_1:RecordAudio("926021049", var_200_18)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_926021", "926021049", "story_v_out_926021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_926021", "926021049", "story_v_out_926021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_19 = math.max(var_200_12, arg_197_1.talkMaxDuration)

			if var_200_11 <= arg_197_1.time_ and arg_197_1.time_ < var_200_11 + var_200_19 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_11) / var_200_19

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_11 + var_200_19 and arg_197_1.time_ < var_200_11 + var_200_19 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play926021050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 926021050
		arg_201_1.duration_ = 9.7

		local var_201_0 = {
			zh = 5.3,
			ja = 9.7
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play926021051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10144 = arg_201_1.actors_["10144"].transform.localPosition
				arg_201_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10144", 3)

				for iter_204_0 = 0, arg_201_1.actors_["10144"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["10144"].transform:GetChild(iter_204_0)

					if var_204_0.name == "split_8" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_204_2 = 0
			local var_204_3 = 0.7

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(926021050)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 28 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 28)

				if (28 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 28)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021050", "story_v_out_926021.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021050", "story_v_out_926021.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_out_926021", "926021050", "story_v_out_926021.awb")

						arg_201_1:RecordAudio("926021050", var_204_9)
						arg_201_1:RecordAudio("926021050", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_926021", "926021050", "story_v_out_926021.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_926021", "926021050", "story_v_out_926021.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_10 and arg_201_1.time_ < var_204_2 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play926021051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 926021051
		arg_205_1.duration_ = 2.13

		local var_205_0 = {
			zh = 2.133,
			ja = 1.6
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play926021052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.175

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(926021051)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 7 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 7)

				if (7 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 7)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021051", "story_v_out_926021.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021051", "story_v_out_926021.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_926021", "926021051", "story_v_out_926021.awb")

						arg_205_1:RecordAudio("926021051", var_208_6)
						arg_205_1:RecordAudio("926021051", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_926021", "926021051", "story_v_out_926021.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_926021", "926021051", "story_v_out_926021.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play926021052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 926021052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play926021053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10144"]) and arg_209_1.var_.actorSpriteComps10144 == nil then
				arg_209_1.var_.actorSpriteComps10144 = arg_209_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10144"]) then
				if arg_209_1.var_.actorSpriteComps10144 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10144"]) and arg_209_1.var_.actorSpriteComps10144 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10144 = nil
			end

			local var_212_2 = 0
			local var_212_3 = 0.325

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_4 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(926021052).content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 13 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 13)

				if (13 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_4) / 13)) > 0 and var_212_3 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_7 and arg_209_1.time_ < var_212_2 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play926021053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 926021053
		arg_213_1.duration_ = 5.8

		local var_213_0 = {
			zh = 4.3,
			ja = 5.8
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play926021054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["128404"]) and arg_213_1.var_.actorSpriteComps128404 == nil then
				arg_213_1.var_.actorSpriteComps128404 = arg_213_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["128404"]) then
				if arg_213_1.var_.actorSpriteComps128404 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["128404"]) and arg_213_1.var_.actorSpriteComps128404 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps128404 = nil
			end

			local var_216_2 = arg_213_1.actors_["128404"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos128404 = var_216_2.localPosition
				var_216_2.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("128404", 3)

				for iter_216_4 = 0, var_216_2.childCount - 1 do
					local var_216_3 = var_216_2:GetChild(iter_216_4)

					if var_216_3.name == "split_6" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				var_216_2.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_213_1.time_ - 0) / var_216_4)
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				var_216_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_216_5 = arg_213_1.actors_["10144"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10144 = var_216_5.localPosition
				var_216_5.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10144", 7)

				for iter_216_5 = 0, var_216_5.childCount - 1 do
					local var_216_6 = var_216_5:GetChild(iter_216_5)

					if var_216_6.name == "" or not string.find(var_216_6.name, "split") then
						var_216_6.gameObject:SetActive(true)
					else
						var_216_6.gameObject:SetActive(false)
					end
				end
			end

			local var_216_7 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				var_216_5.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_213_1.time_ - 0) / var_216_7)
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				var_216_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_216_8 = 0
			local var_216_9 = 0.675

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(926021053)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 27 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 27)

				if (27 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 27)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021053", "story_v_out_926021.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021053", "story_v_out_926021.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_926021", "926021053", "story_v_out_926021.awb")

						arg_213_1:RecordAudio("926021053", var_216_15)
						arg_213_1:RecordAudio("926021053", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_926021", "926021053", "story_v_out_926021.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_926021", "926021053", "story_v_out_926021.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play926021054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 926021054
		arg_217_1.duration_ = 10.67

		local var_217_0 = {
			zh = 8.366,
			ja = 10.666
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play926021055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10144"]) and arg_217_1.var_.actorSpriteComps10144 == nil then
				arg_217_1.var_.actorSpriteComps10144 = arg_217_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10144"]) then
				if arg_217_1.var_.actorSpriteComps10144 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 1, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10144"]) and arg_217_1.var_.actorSpriteComps10144 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10144 = nil
			end

			local var_220_2 = arg_217_1.actors_["128404"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps128404 == nil then
				arg_217_1.var_.actorSpriteComps128404 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps128404 then
					for iter_220_4, iter_220_5 in pairs(arg_217_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_220_5 then
							if arg_217_1.isInRecall_ then
								iter_220_5.color = Color.New(Mathf.Lerp(iter_220_5.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_5.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_5.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_5.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_5.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps128404 then
				for iter_220_6, iter_220_7 in pairs(arg_217_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_220_7 then
						iter_220_7.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps128404 = nil
			end

			local var_220_5 = arg_217_1.actors_["128404"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos128404 = var_220_5.localPosition
				var_220_5.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("128404", 7)

				for iter_220_8 = 0, var_220_5.childCount - 1 do
					local var_220_6 = var_220_5:GetChild(iter_220_8)

					if var_220_6.name == "" or not string.find(var_220_6.name, "split") then
						var_220_6.gameObject:SetActive(true)
					else
						var_220_6.gameObject:SetActive(false)
					end
				end
			end

			local var_220_7 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				var_220_5.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_217_1.time_ - 0) / var_220_7)
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				var_220_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_220_8 = arg_217_1.actors_["10144"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10144 = var_220_8.localPosition
				var_220_8.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10144", 3)

				for iter_220_9 = 0, var_220_8.childCount - 1 do
					local var_220_9 = var_220_8:GetChild(iter_220_9)

					if var_220_9.name == "split_8" or not string.find(var_220_9.name, "split") then
						var_220_9.gameObject:SetActive(true)
					else
						var_220_9.gameObject:SetActive(false)
					end
				end
			end

			local var_220_10 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_10 then
				var_220_8.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_217_1.time_ - 0) / var_220_10)
			end

			if arg_217_1.time_ >= 0 + var_220_10 and arg_217_1.time_ < 0 + var_220_10 + arg_220_0 then
				var_220_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_220_11 = 0
			local var_220_12 = 0.9

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_11 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_13 = arg_217_1:GetWordFromCfg(926021054)
				local var_220_14 = arg_217_1:FormatText(var_220_13.content)

				arg_217_1.text_.text = var_220_14

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_16 = 36 <= 0 and var_220_12 or var_220_12 * (utf8.len(var_220_14) / 36)

				if (36 <= 0 and var_220_12 or var_220_12 * (utf8.len(var_220_14) / 36)) > 0 and var_220_12 < var_220_16 then
					arg_217_1.talkMaxDuration = var_220_16

					if var_220_16 + var_220_11 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_16 + var_220_11
					end
				end

				arg_217_1.text_.text = var_220_14
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021054", "story_v_out_926021.awb") ~= 0 then
					local var_220_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021054", "story_v_out_926021.awb") / 1000

					if var_220_17 + var_220_11 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_17 + var_220_11
					end

					if var_220_13.prefab_name ~= "" and arg_217_1.actors_[var_220_13.prefab_name] ~= nil then
						local var_220_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_13.prefab_name].transform, "story_v_out_926021", "926021054", "story_v_out_926021.awb")

						arg_217_1:RecordAudio("926021054", var_220_18)
						arg_217_1:RecordAudio("926021054", var_220_18)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_926021", "926021054", "story_v_out_926021.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_926021", "926021054", "story_v_out_926021.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_19 = math.max(var_220_12, arg_217_1.talkMaxDuration)

			if var_220_11 <= arg_217_1.time_ and arg_217_1.time_ < var_220_11 + var_220_19 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_11) / var_220_19

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_11 + var_220_19 and arg_217_1.time_ < var_220_11 + var_220_19 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play926021055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 926021055
		arg_221_1.duration_ = 7.83

		local var_221_0 = {
			zh = 5.733,
			ja = 7.833
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play926021056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.475

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(926021055)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 19 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 19)

				if (19 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 19)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021055", "story_v_out_926021.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021055", "story_v_out_926021.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_926021", "926021055", "story_v_out_926021.awb")

						arg_221_1:RecordAudio("926021055", var_224_6)
						arg_221_1:RecordAudio("926021055", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_926021", "926021055", "story_v_out_926021.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_926021", "926021055", "story_v_out_926021.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play926021056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 926021056
		arg_225_1.duration_ = 10.1

		local var_225_0 = {
			zh = 6.866,
			ja = 10.1
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play926021057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.925

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(926021056)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 37 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 37)

				if (37 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 37)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021056", "story_v_out_926021.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021056", "story_v_out_926021.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_926021", "926021056", "story_v_out_926021.awb")

						arg_225_1:RecordAudio("926021056", var_228_6)
						arg_225_1:RecordAudio("926021056", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_926021", "926021056", "story_v_out_926021.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_926021", "926021056", "story_v_out_926021.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play926021057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 926021057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play926021058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10144"]) and arg_229_1.var_.actorSpriteComps10144 == nil then
				arg_229_1.var_.actorSpriteComps10144 = arg_229_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10144"]) then
				if arg_229_1.var_.actorSpriteComps10144 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10144"]) and arg_229_1.var_.actorSpriteComps10144 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps10144 = nil
			end

			local var_232_2 = 0
			local var_232_3 = 0.2

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_4 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(926021057).content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 8 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 8)

				if (8 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 8)) > 0 and var_232_3 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_7 and arg_229_1.time_ < var_232_2 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play926021058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 926021058
		arg_233_1.duration_ = 4.6

		local var_233_0 = {
			zh = 4.033,
			ja = 4.6
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play926021059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10144"]) and arg_233_1.var_.actorSpriteComps10144 == nil then
				arg_233_1.var_.actorSpriteComps10144 = arg_233_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10144"]) then
				if arg_233_1.var_.actorSpriteComps10144 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 1, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10144"]) and arg_233_1.var_.actorSpriteComps10144 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps10144 = nil
			end

			local var_236_2 = 0
			local var_236_3 = 0.525

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(926021058)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 21 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 21)

				if (21 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 21)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021058", "story_v_out_926021.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021058", "story_v_out_926021.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_926021", "926021058", "story_v_out_926021.awb")

						arg_233_1:RecordAudio("926021058", var_236_9)
						arg_233_1:RecordAudio("926021058", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_926021", "926021058", "story_v_out_926021.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_926021", "926021058", "story_v_out_926021.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play926021059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 926021059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play926021060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10144"]) and arg_237_1.var_.actorSpriteComps10144 == nil then
				arg_237_1.var_.actorSpriteComps10144 = arg_237_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10144"]) then
				if arg_237_1.var_.actorSpriteComps10144 then
					for iter_240_0, iter_240_1 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_240_1 then
							if arg_237_1.isInRecall_ then
								iter_240_1.color = Color.New(Mathf.Lerp(iter_240_1.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_0), Mathf.Lerp(iter_240_1.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_0), (Mathf.Lerp(iter_240_1.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_0)))
							else
								local var_240_1 = Mathf.Lerp(iter_240_1.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_0)

								iter_240_1.color = Color.New(var_240_1, var_240_1, var_240_1)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10144"]) and arg_237_1.var_.actorSpriteComps10144 then
				for iter_240_2, iter_240_3 in pairs(arg_237_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_240_3 then
						iter_240_3.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10144 = nil
			end

			local var_240_2 = 0
			local var_240_3 = 0.425

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_4 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(926021059).content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 17 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 17)

				if (17 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 17)) > 0 and var_240_3 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_7 and arg_237_1.time_ < var_240_2 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play926021060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 926021060
		arg_241_1.duration_ = 12.77

		local var_241_0 = {
			zh = 8.233,
			ja = 12.766
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play926021061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10144"]) and arg_241_1.var_.actorSpriteComps10144 == nil then
				arg_241_1.var_.actorSpriteComps10144 = arg_241_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10144"]) then
				if arg_241_1.var_.actorSpriteComps10144 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								iter_244_1.color = Color.New(Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_0), Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_0), (Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_0)))
							else
								local var_244_1 = Mathf.Lerp(iter_244_1.color.r, 1, (arg_241_1.time_ - 0) / var_244_0)

								iter_244_1.color = Color.New(var_244_1, var_244_1, var_244_1)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10144"]) and arg_241_1.var_.actorSpriteComps10144 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps10144 = nil
			end

			local var_244_2 = 0
			local var_244_3 = 1.1

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(926021060)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 44 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 44)

				if (44 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 44)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021060", "story_v_out_926021.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021060", "story_v_out_926021.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_out_926021", "926021060", "story_v_out_926021.awb")

						arg_241_1:RecordAudio("926021060", var_244_9)
						arg_241_1:RecordAudio("926021060", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_926021", "926021060", "story_v_out_926021.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_926021", "926021060", "story_v_out_926021.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play926021061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 926021061
		arg_245_1.duration_ = 7.1

		local var_245_0 = {
			zh = 4.4,
			ja = 7.1
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play926021062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.55

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(926021061)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 22 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 22)

				if (22 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 22)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021061", "story_v_out_926021.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021061", "story_v_out_926021.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_926021", "926021061", "story_v_out_926021.awb")

						arg_245_1:RecordAudio("926021061", var_248_6)
						arg_245_1:RecordAudio("926021061", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_926021", "926021061", "story_v_out_926021.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_926021", "926021061", "story_v_out_926021.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play926021062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 926021062
		arg_249_1.duration_ = 6.9

		local var_249_0 = {
			zh = 4.7,
			ja = 6.9
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play926021063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["106103"]) and arg_249_1.var_.actorSpriteComps106103 == nil then
				arg_249_1.var_.actorSpriteComps106103 = arg_249_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["106103"]) then
				if arg_249_1.var_.actorSpriteComps106103 then
					for iter_252_0, iter_252_1 in pairs(arg_249_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_252_1 then
							if arg_249_1.isInRecall_ then
								iter_252_1.color = Color.New(Mathf.Lerp(iter_252_1.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_0), Mathf.Lerp(iter_252_1.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_0), (Mathf.Lerp(iter_252_1.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_0)))
							else
								local var_252_1 = Mathf.Lerp(iter_252_1.color.r, 1, (arg_249_1.time_ - 0) / var_252_0)

								iter_252_1.color = Color.New(var_252_1, var_252_1, var_252_1)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["106103"]) and arg_249_1.var_.actorSpriteComps106103 then
				for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_252_3 then
						iter_252_3.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps106103 = nil
			end

			local var_252_2 = arg_249_1.actors_["10144"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps10144 == nil then
				arg_249_1.var_.actorSpriteComps10144 = var_252_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_3 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.actorSpriteComps10144 then
					for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_252_5 then
							if arg_249_1.isInRecall_ then
								iter_252_5.color = Color.New(Mathf.Lerp(iter_252_5.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_3), Mathf.Lerp(iter_252_5.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_3), (Mathf.Lerp(iter_252_5.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_3)))
							else
								local var_252_4 = Mathf.Lerp(iter_252_5.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_3)

								iter_252_5.color = Color.New(var_252_4, var_252_4, var_252_4)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.actorSpriteComps10144 then
				for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_252_7 then
						iter_252_7.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10144 = nil
			end

			local var_252_5 = 0
			local var_252_6 = 0.6

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_7 = arg_249_1:GetWordFromCfg(926021062)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 24 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 24)

				if (24 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 24)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021062", "story_v_out_926021.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021062", "story_v_out_926021.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_926021", "926021062", "story_v_out_926021.awb")

						arg_249_1:RecordAudio("926021062", var_252_12)
						arg_249_1:RecordAudio("926021062", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_926021", "926021062", "story_v_out_926021.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_926021", "926021062", "story_v_out_926021.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_13 and arg_249_1.time_ < var_252_5 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play926021063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 926021063
		arg_253_1.duration_ = 8

		local var_253_0 = {
			zh = 5.166,
			ja = 8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play926021064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10144"]) and arg_253_1.var_.actorSpriteComps10144 == nil then
				arg_253_1.var_.actorSpriteComps10144 = arg_253_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10144"]) then
				if arg_253_1.var_.actorSpriteComps10144 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 1, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10144"]) and arg_253_1.var_.actorSpriteComps10144 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10144 = nil
			end

			local var_256_2 = arg_253_1.actors_["106103"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps106103 == nil then
				arg_253_1.var_.actorSpriteComps106103 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps106103 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_5.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_5.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps106103 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps106103 = nil
			end

			local var_256_5 = arg_253_1.actors_["10144"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10144 = var_256_5.localPosition
				var_256_5.localScale = Vector3.New(1, 1, 1)

				arg_253_1:CheckSpriteTmpPos("10144", 3)

				for iter_256_8 = 0, var_256_5.childCount - 1 do
					local var_256_6 = var_256_5:GetChild(iter_256_8)

					if var_256_6.name == "split_10" or not string.find(var_256_6.name, "split") then
						var_256_6.gameObject:SetActive(true)
					else
						var_256_6.gameObject:SetActive(false)
					end
				end
			end

			local var_256_7 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				var_256_5.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_253_1.time_ - 0) / var_256_7)
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				var_256_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_256_8 = 0
			local var_256_9 = 0.65

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(926021063)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 26 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 26)

				if (26 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 26)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021063", "story_v_out_926021.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021063", "story_v_out_926021.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_926021", "926021063", "story_v_out_926021.awb")

						arg_253_1:RecordAudio("926021063", var_256_15)
						arg_253_1:RecordAudio("926021063", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_926021", "926021063", "story_v_out_926021.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_926021", "926021063", "story_v_out_926021.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play926021064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 926021064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play926021065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10144"]) and arg_257_1.var_.actorSpriteComps10144 == nil then
				arg_257_1.var_.actorSpriteComps10144 = arg_257_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10144"]) then
				if arg_257_1.var_.actorSpriteComps10144 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10144"]) and arg_257_1.var_.actorSpriteComps10144 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10144 = nil
			end

			local var_260_2 = 0
			local var_260_3 = 0.2

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_4 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(926021064).content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 8 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 8)

				if (8 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 8)) > 0 and var_260_3 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_7 and arg_257_1.time_ < var_260_2 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play926021065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 926021065
		arg_261_1.duration_ = 5.83

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play926021066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10144 = arg_261_1.actors_["10144"].transform.localPosition
				arg_261_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10144", 7)

				for iter_264_0 = 0, arg_261_1.actors_["10144"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10144"].transform:GetChild(iter_264_0)

					if var_264_0.name == "" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_264_2 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_2 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_3 = 0.833333333333333

			if var_264_2 <= arg_261_1.time_ and arg_261_1.time_ < var_264_2 + var_264_3 then
				local var_264_4 = Color.New(0, 0, 0)

				var_264_4.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_2) / var_264_3)
				arg_261_1.mask_.color = var_264_4
			end

			if arg_261_1.time_ >= var_264_2 + var_264_3 and arg_261_1.time_ < var_264_2 + var_264_3 + arg_264_0 then
				local var_264_5 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_5.a = 0
				arg_261_1.mask_.color = var_264_5
			end

			local var_264_6 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_6 + 1 and arg_261_1.time_ < var_264_6 + 1 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			if 0.3 < arg_261_1.time_ and arg_261_1.time_ <= 0.3 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_143", "se_story_143_hungry02", "")
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_8 = 0.833333333333333
			local var_264_9 = 1.375

			if 0.833333333333333 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_10 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_10:setOnUpdate(LuaHelper.FloatAction(function(arg_265_0)
					arg_261_1.dialogCg_.alpha = arg_265_0
				end))
				var_264_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_11 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(926021065).content)

				arg_261_1.text_.text = var_264_11

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 55 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 55)

				if (55 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 55)) > 0 and var_264_9 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13
					var_264_8 = var_264_8 + 0.3

					if var_264_13 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_11
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = var_264_8 + 0.3
			local var_264_15 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_14 + var_264_15 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_14) / var_264_15

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_14 + var_264_15 and arg_261_1.time_ < var_264_14 + var_264_15 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play926021066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 926021066
		arg_267_1.duration_ = 2.33

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play926021067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["128404"]) and arg_267_1.var_.actorSpriteComps128404 == nil then
				arg_267_1.var_.actorSpriteComps128404 = arg_267_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["128404"]) then
				if arg_267_1.var_.actorSpriteComps128404 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["128404"]) and arg_267_1.var_.actorSpriteComps128404 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps128404 = nil
			end

			local var_270_2 = arg_267_1.actors_["128404"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos128404 = var_270_2.localPosition
				var_270_2.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("128404", 3)

				for iter_270_4 = 0, var_270_2.childCount - 1 do
					local var_270_3 = var_270_2:GetChild(iter_270_4)

					if var_270_3.name == "split_5" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_2.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_267_1.time_ - 0) / var_270_4)
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_270_5 = 0
			local var_270_6 = 0.175

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:GetWordFromCfg(926021066)
				local var_270_8 = arg_267_1:FormatText(var_270_7.content)

				arg_267_1.text_.text = var_270_8

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_10 = 7 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 7)

				if (7 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_8) / 7)) > 0 and var_270_6 < var_270_10 then
					arg_267_1.talkMaxDuration = var_270_10

					if var_270_10 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_8
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021066", "story_v_out_926021.awb") ~= 0 then
					local var_270_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021066", "story_v_out_926021.awb") / 1000

					if var_270_11 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_5
					end

					if var_270_7.prefab_name ~= "" and arg_267_1.actors_[var_270_7.prefab_name] ~= nil then
						local var_270_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_7.prefab_name].transform, "story_v_out_926021", "926021066", "story_v_out_926021.awb")

						arg_267_1:RecordAudio("926021066", var_270_12)
						arg_267_1:RecordAudio("926021066", var_270_12)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_926021", "926021066", "story_v_out_926021.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_926021", "926021066", "story_v_out_926021.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_13 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_13 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_13

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_13 and arg_267_1.time_ < var_270_5 + var_270_13 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play926021067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 926021067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play926021068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["128404"]) and arg_271_1.var_.actorSpriteComps128404 == nil then
				arg_271_1.var_.actorSpriteComps128404 = arg_271_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["128404"]) then
				if arg_271_1.var_.actorSpriteComps128404 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 0.5, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["128404"]) and arg_271_1.var_.actorSpriteComps128404 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps128404 = nil
			end

			local var_274_2 = 0
			local var_274_3 = 0.125

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_4 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(926021067).content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_6 = 5 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_4) / 5)

				if (5 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_4) / 5)) > 0 and var_274_3 < var_274_6 then
					arg_271_1.talkMaxDuration = var_274_6

					if var_274_6 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_7 and arg_271_1.time_ < var_274_2 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play926021068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 926021068
		arg_275_1.duration_ = 5.8

		local var_275_0 = {
			zh = 4.233,
			ja = 5.8
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play926021069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10144"]) and arg_275_1.var_.actorSpriteComps10144 == nil then
				arg_275_1.var_.actorSpriteComps10144 = arg_275_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10144"]) then
				if arg_275_1.var_.actorSpriteComps10144 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 1, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10144"]) and arg_275_1.var_.actorSpriteComps10144 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10144 = nil
			end

			local var_278_2 = arg_275_1.actors_["128404"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos128404 = var_278_2.localPosition
				var_278_2.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("128404", 7)

				for iter_278_4 = 0, var_278_2.childCount - 1 do
					local var_278_3 = var_278_2:GetChild(iter_278_4)

					if var_278_3.name == "" or not string.find(var_278_3.name, "split") then
						var_278_3.gameObject:SetActive(true)
					else
						var_278_3.gameObject:SetActive(false)
					end
				end
			end

			local var_278_4 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				var_278_2.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_275_1.time_ - 0) / var_278_4)
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				var_278_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_278_5 = arg_275_1.actors_["10144"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10144 = var_278_5.localPosition
				var_278_5.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10144", 3)

				for iter_278_5 = 0, var_278_5.childCount - 1 do
					local var_278_6 = var_278_5:GetChild(iter_278_5)

					if var_278_6.name == "split_8" or not string.find(var_278_6.name, "split") then
						var_278_6.gameObject:SetActive(true)
					else
						var_278_6.gameObject:SetActive(false)
					end
				end
			end

			local var_278_7 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				var_278_5.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_275_1.time_ - 0) / var_278_7)
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				var_278_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_278_8 = 0
			local var_278_9 = 0.475

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(926021068)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 19 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 19)

				if (19 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 19)) > 0 and var_278_9 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021068", "story_v_out_926021.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021068", "story_v_out_926021.awb") / 1000

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_926021", "926021068", "story_v_out_926021.awb")

						arg_275_1:RecordAudio("926021068", var_278_15)
						arg_275_1:RecordAudio("926021068", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_926021", "926021068", "story_v_out_926021.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_926021", "926021068", "story_v_out_926021.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play926021069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 926021069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play926021070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10144"]) and arg_279_1.var_.actorSpriteComps10144 == nil then
				arg_279_1.var_.actorSpriteComps10144 = arg_279_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10144"]) then
				if arg_279_1.var_.actorSpriteComps10144 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_282_1 then
							if arg_279_1.isInRecall_ then
								iter_282_1.color = Color.New(Mathf.Lerp(iter_282_1.color.r, arg_279_1.hightColor2.r, (arg_279_1.time_ - 0) / var_282_0), Mathf.Lerp(iter_282_1.color.g, arg_279_1.hightColor2.g, (arg_279_1.time_ - 0) / var_282_0), (Mathf.Lerp(iter_282_1.color.b, arg_279_1.hightColor2.b, (arg_279_1.time_ - 0) / var_282_0)))
							else
								local var_282_1 = Mathf.Lerp(iter_282_1.color.r, 0.5, (arg_279_1.time_ - 0) / var_282_0)

								iter_282_1.color = Color.New(var_282_1, var_282_1, var_282_1)
							end
						end
					end
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10144"]) and arg_279_1.var_.actorSpriteComps10144 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_279_1.var_.actorSpriteComps10144 = nil
			end

			local var_282_2 = 0
			local var_282_3 = 0.175

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_4 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(926021069).content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_6 = 7 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_4) / 7)

				if (7 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_4) / 7)) > 0 and var_282_3 < var_282_6 then
					arg_279_1.talkMaxDuration = var_282_6

					if var_282_6 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_6 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_7 and arg_279_1.time_ < var_282_2 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play926021070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 926021070
		arg_283_1.duration_ = 5.93

		local var_283_0 = {
			zh = 4.233,
			ja = 5.933
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play926021071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10144"]) and arg_283_1.var_.actorSpriteComps10144 == nil then
				arg_283_1.var_.actorSpriteComps10144 = arg_283_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10144"]) then
				if arg_283_1.var_.actorSpriteComps10144 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 1, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10144"]) and arg_283_1.var_.actorSpriteComps10144 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps10144 = nil
			end

			local var_286_2 = 0
			local var_286_3 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(926021070)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 19)

				if (19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 19)) > 0 and var_286_3 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021070", "story_v_out_926021.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021070", "story_v_out_926021.awb") / 1000

					if var_286_8 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_2
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_926021", "926021070", "story_v_out_926021.awb")

						arg_283_1:RecordAudio("926021070", var_286_9)
						arg_283_1:RecordAudio("926021070", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_926021", "926021070", "story_v_out_926021.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_926021", "926021070", "story_v_out_926021.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_10 and arg_283_1.time_ < var_286_2 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play926021071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 926021071
		arg_287_1.duration_ = 6

		local var_287_0 = {
			zh = 6,
			ja = 5.933
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play926021072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.825

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(926021071)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 33 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 33)

				if (33 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 33)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021071", "story_v_out_926021.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021071", "story_v_out_926021.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_926021", "926021071", "story_v_out_926021.awb")

						arg_287_1:RecordAudio("926021071", var_290_6)
						arg_287_1:RecordAudio("926021071", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_926021", "926021071", "story_v_out_926021.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_926021", "926021071", "story_v_out_926021.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play926021072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 926021072
		arg_291_1.duration_ = 6.9

		local var_291_0 = {
			zh = 4.7,
			ja = 6.9
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play926021073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.625

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(926021072)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 25 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 25)

				if (25 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 25)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021072", "story_v_out_926021.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021072", "story_v_out_926021.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_926021", "926021072", "story_v_out_926021.awb")

						arg_291_1:RecordAudio("926021072", var_294_6)
						arg_291_1:RecordAudio("926021072", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_926021", "926021072", "story_v_out_926021.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_926021", "926021072", "story_v_out_926021.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play926021073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 926021073
		arg_295_1.duration_ = 6.6

		local var_295_0 = {
			zh = 4.133,
			ja = 6.6
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play926021074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["128404"]) and arg_295_1.var_.actorSpriteComps128404 == nil then
				arg_295_1.var_.actorSpriteComps128404 = arg_295_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["128404"]) then
				if arg_295_1.var_.actorSpriteComps128404 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["128404"]) and arg_295_1.var_.actorSpriteComps128404 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps128404 = nil
			end

			local var_298_2 = arg_295_1.actors_["10144"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10144 == nil then
				arg_295_1.var_.actorSpriteComps10144 = var_298_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_3 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.actorSpriteComps10144 then
					for iter_298_4, iter_298_5 in pairs(arg_295_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_298_5 then
							if arg_295_1.isInRecall_ then
								iter_298_5.color = Color.New(Mathf.Lerp(iter_298_5.color.r, arg_295_1.hightColor2.r, (arg_295_1.time_ - 0) / var_298_3), Mathf.Lerp(iter_298_5.color.g, arg_295_1.hightColor2.g, (arg_295_1.time_ - 0) / var_298_3), (Mathf.Lerp(iter_298_5.color.b, arg_295_1.hightColor2.b, (arg_295_1.time_ - 0) / var_298_3)))
							else
								local var_298_4 = Mathf.Lerp(iter_298_5.color.r, 0.5, (arg_295_1.time_ - 0) / var_298_3)

								iter_298_5.color = Color.New(var_298_4, var_298_4, var_298_4)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10144 then
				for iter_298_6, iter_298_7 in pairs(arg_295_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_298_7 then
						iter_298_7.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_295_1.var_.actorSpriteComps10144 = nil
			end

			local var_298_5 = arg_295_1.actors_["128404"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos128404 = var_298_5.localPosition
				var_298_5.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("128404", 2)

				for iter_298_8 = 0, var_298_5.childCount - 1 do
					local var_298_6 = var_298_5:GetChild(iter_298_8)

					if var_298_6.name == "split_4" or not string.find(var_298_6.name, "split") then
						var_298_6.gameObject:SetActive(true)
					else
						var_298_6.gameObject:SetActive(false)
					end
				end
			end

			local var_298_7 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				var_298_5.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_295_1.time_ - 0) / var_298_7)
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				var_298_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_298_8 = arg_295_1.actors_["10144"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10144 = var_298_8.localPosition
				var_298_8.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10144", 4)

				for iter_298_9 = 0, var_298_8.childCount - 1 do
					local var_298_9 = var_298_8:GetChild(iter_298_9)

					if var_298_9.name == "split_8" or not string.find(var_298_9.name, "split") then
						var_298_9.gameObject:SetActive(true)
					else
						var_298_9.gameObject:SetActive(false)
					end
				end
			end

			local var_298_10 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_10 then
				var_298_8.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_295_1.time_ - 0) / var_298_10)
			end

			if arg_295_1.time_ >= 0 + var_298_10 and arg_295_1.time_ < 0 + var_298_10 + arg_298_0 then
				var_298_8.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_298_11 = 0
			local var_298_12 = 0.425

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_11 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_13 = arg_295_1:GetWordFromCfg(926021073)
				local var_298_14 = arg_295_1:FormatText(var_298_13.content)

				arg_295_1.text_.text = var_298_14

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_16 = 17 <= 0 and var_298_12 or var_298_12 * (utf8.len(var_298_14) / 17)

				if (17 <= 0 and var_298_12 or var_298_12 * (utf8.len(var_298_14) / 17)) > 0 and var_298_12 < var_298_16 then
					arg_295_1.talkMaxDuration = var_298_16

					if var_298_16 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_16 + var_298_11
					end
				end

				arg_295_1.text_.text = var_298_14
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021073", "story_v_out_926021.awb") ~= 0 then
					local var_298_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021073", "story_v_out_926021.awb") / 1000

					if var_298_17 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_17 + var_298_11
					end

					if var_298_13.prefab_name ~= "" and arg_295_1.actors_[var_298_13.prefab_name] ~= nil then
						local var_298_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_13.prefab_name].transform, "story_v_out_926021", "926021073", "story_v_out_926021.awb")

						arg_295_1:RecordAudio("926021073", var_298_18)
						arg_295_1:RecordAudio("926021073", var_298_18)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_926021", "926021073", "story_v_out_926021.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_926021", "926021073", "story_v_out_926021.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_19 = math.max(var_298_12, arg_295_1.talkMaxDuration)

			if var_298_11 <= arg_295_1.time_ and arg_295_1.time_ < var_298_11 + var_298_19 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_11) / var_298_19

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_11 + var_298_19 and arg_295_1.time_ < var_298_11 + var_298_19 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play926021074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 926021074
		arg_299_1.duration_ = 14.13

		local var_299_0 = {
			zh = 8.4,
			ja = 14.133
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play926021075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["10144"]) and arg_299_1.var_.actorSpriteComps10144 == nil then
				arg_299_1.var_.actorSpriteComps10144 = arg_299_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_0 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["10144"]) then
				if arg_299_1.var_.actorSpriteComps10144 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								iter_302_1.color = Color.New(Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_0), Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_0), (Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_0)))
							else
								local var_302_1 = Mathf.Lerp(iter_302_1.color.r, 1, (arg_299_1.time_ - 0) / var_302_0)

								iter_302_1.color = Color.New(var_302_1, var_302_1, var_302_1)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["10144"]) and arg_299_1.var_.actorSpriteComps10144 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_302_3 then
						iter_302_3.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10144 = nil
			end

			local var_302_2 = arg_299_1.actors_["128404"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps128404 == nil then
				arg_299_1.var_.actorSpriteComps128404 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps128404 then
					for iter_302_4, iter_302_5 in pairs(arg_299_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_302_5 then
							if arg_299_1.isInRecall_ then
								iter_302_5.color = Color.New(Mathf.Lerp(iter_302_5.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_5.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_5.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_5.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_5.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps128404 then
				for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_302_7 then
						iter_302_7.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps128404 = nil
			end

			local var_302_5 = arg_299_1.actors_["10144"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10144 = var_302_5.localPosition
				var_302_5.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10144", 4)

				for iter_302_8 = 0, var_302_5.childCount - 1 do
					local var_302_6 = var_302_5:GetChild(iter_302_8)

					if var_302_6.name == "split_10" or not string.find(var_302_6.name, "split") then
						var_302_6.gameObject:SetActive(true)
					else
						var_302_6.gameObject:SetActive(false)
					end
				end
			end

			local var_302_7 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				var_302_5.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_299_1.time_ - 0) / var_302_7)
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				var_302_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_302_8 = 0
			local var_302_9 = 1.125

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_10 = arg_299_1:GetWordFromCfg(926021074)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_13 = 45 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 45)

				if (45 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 45)) > 0 and var_302_9 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_8
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021074", "story_v_out_926021.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021074", "story_v_out_926021.awb") / 1000

					if var_302_14 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_8
					end

					if var_302_10.prefab_name ~= "" and arg_299_1.actors_[var_302_10.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_10.prefab_name].transform, "story_v_out_926021", "926021074", "story_v_out_926021.awb")

						arg_299_1:RecordAudio("926021074", var_302_15)
						arg_299_1:RecordAudio("926021074", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_926021", "926021074", "story_v_out_926021.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_926021", "926021074", "story_v_out_926021.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_9, arg_299_1.talkMaxDuration)

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_8) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_8 + var_302_16 and arg_299_1.time_ < var_302_8 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play926021075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 926021075
		arg_303_1.duration_ = 12.3

		local var_303_0 = {
			zh = 8.3,
			ja = 12.3
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play926021076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.75

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(926021075)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 46 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 46)

				if (46 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 46)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021075", "story_v_out_926021.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021075", "story_v_out_926021.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_926021", "926021075", "story_v_out_926021.awb")

						arg_303_1:RecordAudio("926021075", var_306_6)
						arg_303_1:RecordAudio("926021075", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_926021", "926021075", "story_v_out_926021.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_926021", "926021075", "story_v_out_926021.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play926021076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 926021076
		arg_307_1.duration_ = 6.1

		local var_307_0 = {
			zh = 4.7,
			ja = 6.1
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play926021077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10144 = arg_307_1.actors_["10144"].transform.localPosition
				arg_307_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10144", 4)

				for iter_310_0 = 0, arg_307_1.actors_["10144"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["10144"].transform:GetChild(iter_310_0)

					if var_310_0.name == "split_8" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["10144"].transform.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_310_2 = 0
			local var_310_3 = 0.6

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:GetWordFromCfg(926021076)
				local var_310_5 = arg_307_1:FormatText(var_310_4.content)

				arg_307_1.text_.text = var_310_5

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_7 = 24 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 24)

				if (24 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_5) / 24)) > 0 and var_310_3 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_5
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021076", "story_v_out_926021.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021076", "story_v_out_926021.awb") / 1000

					if var_310_8 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_2
					end

					if var_310_4.prefab_name ~= "" and arg_307_1.actors_[var_310_4.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_4.prefab_name].transform, "story_v_out_926021", "926021076", "story_v_out_926021.awb")

						arg_307_1:RecordAudio("926021076", var_310_9)
						arg_307_1:RecordAudio("926021076", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_926021", "926021076", "story_v_out_926021.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_926021", "926021076", "story_v_out_926021.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_10 and arg_307_1.time_ < var_310_2 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play926021077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 926021077
		arg_311_1.duration_ = 9.13

		local var_311_0 = {
			zh = 5.766,
			ja = 9.133
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play926021078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["128404"]) and arg_311_1.var_.actorSpriteComps128404 == nil then
				arg_311_1.var_.actorSpriteComps128404 = arg_311_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["128404"]) then
				if arg_311_1.var_.actorSpriteComps128404 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 1, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["128404"]) and arg_311_1.var_.actorSpriteComps128404 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps128404 = nil
			end

			local var_314_2 = arg_311_1.actors_["10144"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10144 == nil then
				arg_311_1.var_.actorSpriteComps10144 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps10144 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								iter_314_5.color = Color.New(Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_5.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_5.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10144 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_314_7 then
						iter_314_7.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps10144 = nil
			end

			local var_314_5 = arg_311_1.actors_["128404"].transform

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos128404 = var_314_5.localPosition
				var_314_5.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("128404", 2)

				for iter_314_8 = 0, var_314_5.childCount - 1 do
					local var_314_6 = var_314_5:GetChild(iter_314_8)

					if var_314_6.name == "split_6" or not string.find(var_314_6.name, "split") then
						var_314_6.gameObject:SetActive(true)
					else
						var_314_6.gameObject:SetActive(false)
					end
				end
			end

			local var_314_7 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				var_314_5.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_311_1.time_ - 0) / var_314_7)
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				var_314_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_314_8 = 0
			local var_314_9 = 0.825

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_10 = arg_311_1:GetWordFromCfg(926021077)
				local var_314_11 = arg_311_1:FormatText(var_314_10.content)

				arg_311_1.text_.text = var_314_11

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_13 = 33 <= 0 and var_314_9 or var_314_9 * (utf8.len(var_314_11) / 33)

				if (33 <= 0 and var_314_9 or var_314_9 * (utf8.len(var_314_11) / 33)) > 0 and var_314_9 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_8
					end
				end

				arg_311_1.text_.text = var_314_11
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021077", "story_v_out_926021.awb") ~= 0 then
					local var_314_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021077", "story_v_out_926021.awb") / 1000

					if var_314_14 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_8
					end

					if var_314_10.prefab_name ~= "" and arg_311_1.actors_[var_314_10.prefab_name] ~= nil then
						local var_314_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_10.prefab_name].transform, "story_v_out_926021", "926021077", "story_v_out_926021.awb")

						arg_311_1:RecordAudio("926021077", var_314_15)
						arg_311_1:RecordAudio("926021077", var_314_15)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_926021", "926021077", "story_v_out_926021.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_926021", "926021077", "story_v_out_926021.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_9, arg_311_1.talkMaxDuration)

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_8) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_8 + var_314_16 and arg_311_1.time_ < var_314_8 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play926021078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 926021078
		arg_315_1.duration_ = 6.77

		local var_315_0 = {
			zh = 5.6,
			ja = 6.766
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play926021079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["104701"]) and arg_315_1.var_.actorSpriteComps104701 == nil then
				arg_315_1.var_.actorSpriteComps104701 = arg_315_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["104701"]) then
				if arg_315_1.var_.actorSpriteComps104701 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 1, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["104701"]) and arg_315_1.var_.actorSpriteComps104701 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps104701 = nil
			end

			local var_318_2 = arg_315_1.actors_["128404"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps128404 == nil then
				arg_315_1.var_.actorSpriteComps128404 = var_318_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_3 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.actorSpriteComps128404 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								iter_318_5.color = Color.New(Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor2.r, (arg_315_1.time_ - 0) / var_318_3), Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor2.g, (arg_315_1.time_ - 0) / var_318_3), (Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor2.b, (arg_315_1.time_ - 0) / var_318_3)))
							else
								local var_318_4 = Mathf.Lerp(iter_318_5.color.r, 0.5, (arg_315_1.time_ - 0) / var_318_3)

								iter_318_5.color = Color.New(var_318_4, var_318_4, var_318_4)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps128404 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_318_7 then
						iter_318_7.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps128404 = nil
			end

			local var_318_5 = 0
			local var_318_6 = 0.65

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104701_split_1")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_7 = arg_315_1:GetWordFromCfg(926021078)
				local var_318_8 = arg_315_1:FormatText(var_318_7.content)

				arg_315_1.text_.text = var_318_8

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 26 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 26)

				if (26 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 26)) > 0 and var_318_6 < var_318_10 then
					arg_315_1.talkMaxDuration = var_318_10

					if var_318_10 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_8
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021078", "story_v_out_926021.awb") ~= 0 then
					local var_318_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021078", "story_v_out_926021.awb") / 1000

					if var_318_11 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_5
					end

					if var_318_7.prefab_name ~= "" and arg_315_1.actors_[var_318_7.prefab_name] ~= nil then
						local var_318_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_7.prefab_name].transform, "story_v_out_926021", "926021078", "story_v_out_926021.awb")

						arg_315_1:RecordAudio("926021078", var_318_12)
						arg_315_1:RecordAudio("926021078", var_318_12)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_926021", "926021078", "story_v_out_926021.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_926021", "926021078", "story_v_out_926021.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_13 and arg_315_1.time_ < var_318_5 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play926021079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 926021079
		arg_319_1.duration_ = 2.2

		local var_319_0 = {
			zh = 1.6,
			ja = 2.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play926021080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["128404"]) and arg_319_1.var_.actorSpriteComps128404 == nil then
				arg_319_1.var_.actorSpriteComps128404 = arg_319_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["128404"]) then
				if arg_319_1.var_.actorSpriteComps128404 then
					for iter_322_0, iter_322_1 in pairs(arg_319_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_322_1 then
							if arg_319_1.isInRecall_ then
								iter_322_1.color = Color.New(Mathf.Lerp(iter_322_1.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_0), Mathf.Lerp(iter_322_1.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_0), (Mathf.Lerp(iter_322_1.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_0)))
							else
								local var_322_1 = Mathf.Lerp(iter_322_1.color.r, 1, (arg_319_1.time_ - 0) / var_322_0)

								iter_322_1.color = Color.New(var_322_1, var_322_1, var_322_1)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["128404"]) and arg_319_1.var_.actorSpriteComps128404 then
				for iter_322_2, iter_322_3 in pairs(arg_319_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_322_3 then
						iter_322_3.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps128404 = nil
			end

			local var_322_2 = arg_319_1.actors_["104701"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps104701 == nil then
				arg_319_1.var_.actorSpriteComps104701 = var_322_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_3 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.actorSpriteComps104701 then
					for iter_322_4, iter_322_5 in pairs(arg_319_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_322_5 then
							if arg_319_1.isInRecall_ then
								iter_322_5.color = Color.New(Mathf.Lerp(iter_322_5.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_3), Mathf.Lerp(iter_322_5.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_3), (Mathf.Lerp(iter_322_5.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_3)))
							else
								local var_322_4 = Mathf.Lerp(iter_322_5.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_3)

								iter_322_5.color = Color.New(var_322_4, var_322_4, var_322_4)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps104701 then
				for iter_322_6, iter_322_7 in pairs(arg_319_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_322_7 then
						iter_322_7.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps104701 = nil
			end

			local var_322_5 = arg_319_1.actors_["128404"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos128404 = var_322_5.localPosition
				var_322_5.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("128404", 2)

				for iter_322_8 = 0, var_322_5.childCount - 1 do
					local var_322_6 = var_322_5:GetChild(iter_322_8)

					if var_322_6.name == "split_4" or not string.find(var_322_6.name, "split") then
						var_322_6.gameObject:SetActive(true)
					else
						var_322_6.gameObject:SetActive(false)
					end
				end
			end

			local var_322_7 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				var_322_5.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_319_1.time_ - 0) / var_322_7)
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				var_322_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_322_8 = 0
			local var_322_9 = 0.1

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(926021079)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 4 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 4)

				if (4 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 4)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021079", "story_v_out_926021.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021079", "story_v_out_926021.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_926021", "926021079", "story_v_out_926021.awb")

						arg_319_1:RecordAudio("926021079", var_322_15)
						arg_319_1:RecordAudio("926021079", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_926021", "926021079", "story_v_out_926021.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_926021", "926021079", "story_v_out_926021.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play926021080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 926021080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play926021081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["128404"]) and arg_323_1.var_.actorSpriteComps128404 == nil then
				arg_323_1.var_.actorSpriteComps128404 = arg_323_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["128404"]) then
				if arg_323_1.var_.actorSpriteComps128404 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								iter_326_1.color = Color.New(Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor2.r, (arg_323_1.time_ - 0) / var_326_0), Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor2.g, (arg_323_1.time_ - 0) / var_326_0), (Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor2.b, (arg_323_1.time_ - 0) / var_326_0)))
							else
								local var_326_1 = Mathf.Lerp(iter_326_1.color.r, 0.5, (arg_323_1.time_ - 0) / var_326_0)

								iter_326_1.color = Color.New(var_326_1, var_326_1, var_326_1)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["128404"]) and arg_323_1.var_.actorSpriteComps128404 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_326_3 then
						iter_326_3.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps128404 = nil
			end

			local var_326_2 = 0
			local var_326_3 = 0.3

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_4 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(926021080).content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_6 = 12 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_4) / 12)

				if (12 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_4) / 12)) > 0 and var_326_3 < var_326_6 then
					arg_323_1.talkMaxDuration = var_326_6

					if var_326_6 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_6 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_4
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_7 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_7 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_7

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_7 and arg_323_1.time_ < var_326_2 + var_326_7 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play926021081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 926021081
		arg_327_1.duration_ = 5.6

		local var_327_0 = {
			zh = 5.3,
			ja = 5.6
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play926021082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["10144"]) and arg_327_1.var_.actorSpriteComps10144 == nil then
				arg_327_1.var_.actorSpriteComps10144 = arg_327_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["10144"]) then
				if arg_327_1.var_.actorSpriteComps10144 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 1, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["10144"]) and arg_327_1.var_.actorSpriteComps10144 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps10144 = nil
			end

			local var_330_2 = 0
			local var_330_3 = 0.7

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_4 = arg_327_1:GetWordFromCfg(926021081)
				local var_330_5 = arg_327_1:FormatText(var_330_4.content)

				arg_327_1.text_.text = var_330_5

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_7 = 27 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 27)

				if (27 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_5) / 27)) > 0 and var_330_3 < var_330_7 then
					arg_327_1.talkMaxDuration = var_330_7

					if var_330_7 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_5
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021081", "story_v_out_926021.awb") ~= 0 then
					local var_330_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021081", "story_v_out_926021.awb") / 1000

					if var_330_8 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_8 + var_330_2
					end

					if var_330_4.prefab_name ~= "" and arg_327_1.actors_[var_330_4.prefab_name] ~= nil then
						local var_330_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_4.prefab_name].transform, "story_v_out_926021", "926021081", "story_v_out_926021.awb")

						arg_327_1:RecordAudio("926021081", var_330_9)
						arg_327_1:RecordAudio("926021081", var_330_9)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_926021", "926021081", "story_v_out_926021.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_926021", "926021081", "story_v_out_926021.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_10 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_10 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_10

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_10 and arg_327_1.time_ < var_330_2 + var_330_10 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play926021082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 926021082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play926021083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10144"]) and arg_331_1.var_.actorSpriteComps10144 == nil then
				arg_331_1.var_.actorSpriteComps10144 = arg_331_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10144"]) then
				if arg_331_1.var_.actorSpriteComps10144 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10144"]) and arg_331_1.var_.actorSpriteComps10144 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps10144 = nil
			end

			local var_334_2 = arg_331_1.actors_["128404"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos128404 = var_334_2.localPosition
				var_334_2.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("128404", 7)

				for iter_334_4 = 0, var_334_2.childCount - 1 do
					local var_334_3 = var_334_2:GetChild(iter_334_4)

					if var_334_3.name == "" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_331_1.time_ - 0) / var_334_4)
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_5 = arg_331_1.actors_["10144"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10144 = var_334_5.localPosition
				var_334_5.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10144", 7)

				for iter_334_5 = 0, var_334_5.childCount - 1 do
					local var_334_6 = var_334_5:GetChild(iter_334_5)

					if var_334_6.name == "" or not string.find(var_334_6.name, "split") then
						var_334_6.gameObject:SetActive(true)
					else
						var_334_6.gameObject:SetActive(false)
					end
				end
			end

			local var_334_7 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				var_334_5.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_331_1.time_ - 0) / var_334_7)
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				var_334_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_334_8 = 0
			local var_334_9 = 0.9

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(926021082).content)

				arg_331_1.text_.text = var_334_10

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_12 = 43 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_10) / 43)

				if (43 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_10) / 43)) > 0 and var_334_9 < var_334_12 then
					arg_331_1.talkMaxDuration = var_334_12

					if var_334_12 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_10
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_13 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_13 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_13

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_13 and arg_331_1.time_ < var_334_8 + var_334_13 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play926021083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 926021083
		arg_335_1.duration_ = 3

		local var_335_0 = {
			zh = 2.366,
			ja = 3
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play926021084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["10144"]) and arg_335_1.var_.actorSpriteComps10144 == nil then
				arg_335_1.var_.actorSpriteComps10144 = arg_335_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["10144"]) then
				if arg_335_1.var_.actorSpriteComps10144 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								iter_338_1.color = Color.New(Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_0), Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_0), (Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_0)))
							else
								local var_338_1 = Mathf.Lerp(iter_338_1.color.r, 1, (arg_335_1.time_ - 0) / var_338_0)

								iter_338_1.color = Color.New(var_338_1, var_338_1, var_338_1)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["10144"]) and arg_335_1.var_.actorSpriteComps10144 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_338_3 then
						iter_338_3.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10144 = nil
			end

			local var_338_2 = arg_335_1.actors_["10144"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10144 = var_338_2.localPosition
				var_338_2.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10144", 3)

				for iter_338_4 = 0, var_338_2.childCount - 1 do
					local var_338_3 = var_338_2:GetChild(iter_338_4)

					if var_338_3.name == "" or not string.find(var_338_3.name, "split") then
						var_338_3.gameObject:SetActive(true)
					else
						var_338_3.gameObject:SetActive(false)
					end
				end
			end

			local var_338_4 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				var_338_2.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_335_1.time_ - 0) / var_338_4)
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				var_338_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_338_5 = 0
			local var_338_6 = 0.275

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_5 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_7 = arg_335_1:GetWordFromCfg(926021083)
				local var_338_8 = arg_335_1:FormatText(var_338_7.content)

				arg_335_1.text_.text = var_338_8

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 11 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 11)

				if (11 <= 0 and var_338_6 or var_338_6 * (utf8.len(var_338_8) / 11)) > 0 and var_338_6 < var_338_10 then
					arg_335_1.talkMaxDuration = var_338_10

					if var_338_10 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_5
					end
				end

				arg_335_1.text_.text = var_338_8
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021083", "story_v_out_926021.awb") ~= 0 then
					local var_338_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021083", "story_v_out_926021.awb") / 1000

					if var_338_11 + var_338_5 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_5
					end

					if var_338_7.prefab_name ~= "" and arg_335_1.actors_[var_338_7.prefab_name] ~= nil then
						local var_338_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_7.prefab_name].transform, "story_v_out_926021", "926021083", "story_v_out_926021.awb")

						arg_335_1:RecordAudio("926021083", var_338_12)
						arg_335_1:RecordAudio("926021083", var_338_12)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_926021", "926021083", "story_v_out_926021.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_926021", "926021083", "story_v_out_926021.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_6, arg_335_1.talkMaxDuration)

			if var_338_5 <= arg_335_1.time_ and arg_335_1.time_ < var_338_5 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_5) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_5 + var_338_13 and arg_335_1.time_ < var_338_5 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play926021084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 926021084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play926021085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10144"]) and arg_339_1.var_.actorSpriteComps10144 == nil then
				arg_339_1.var_.actorSpriteComps10144 = arg_339_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10144"]) then
				if arg_339_1.var_.actorSpriteComps10144 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10144"]) and arg_339_1.var_.actorSpriteComps10144 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps10144 = nil
			end

			local var_342_2 = 0
			local var_342_3 = 0.35

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_4 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(926021084).content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_6 = 14 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_4) / 14)

				if (14 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_4) / 14)) > 0 and var_342_3 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_7 and arg_339_1.time_ < var_342_2 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play926021085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 926021085
		arg_343_1.duration_ = 5.5

		local var_343_0 = {
			zh = 4.9,
			ja = 5.5
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play926021086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["106103"]) and arg_343_1.var_.actorSpriteComps106103 == nil then
				arg_343_1.var_.actorSpriteComps106103 = arg_343_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["106103"]) then
				if arg_343_1.var_.actorSpriteComps106103 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 1, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["106103"]) and arg_343_1.var_.actorSpriteComps106103 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps106103 = nil
			end

			local var_346_2 = arg_343_1.actors_["10144"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10144 = var_346_2.localPosition
				var_346_2.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10144", 4)

				for iter_346_4 = 0, var_346_2.childCount - 1 do
					local var_346_3 = var_346_2:GetChild(iter_346_4)

					if var_346_3.name == "" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				var_346_2.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_343_1.time_ - 0) / var_346_4)
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				var_346_2.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_346_5 = arg_343_1.actors_["106103"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos106103 = var_346_5.localPosition
				var_346_5.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("106103", 2)

				for iter_346_5 = 0, var_346_5.childCount - 1 do
					local var_346_6 = var_346_5:GetChild(iter_346_5)

					if var_346_6.name == "" or not string.find(var_346_6.name, "split") then
						var_346_6.gameObject:SetActive(true)
					else
						var_346_6.gameObject:SetActive(false)
					end
				end
			end

			local var_346_7 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				var_346_5.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos106103, Vector3.New(-428.4, -398.2, -333.7), (arg_343_1.time_ - 0) / var_346_7)
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				var_346_5.localPosition = Vector3.New(-428.4, -398.2, -333.7)
			end

			local var_346_8 = 0
			local var_346_9 = 0.6

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(926021085)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 24 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 24)

				if (24 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 24)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021085", "story_v_out_926021.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021085", "story_v_out_926021.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_out_926021", "926021085", "story_v_out_926021.awb")

						arg_343_1:RecordAudio("926021085", var_346_15)
						arg_343_1:RecordAudio("926021085", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_926021", "926021085", "story_v_out_926021.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_926021", "926021085", "story_v_out_926021.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_16 and arg_343_1.time_ < var_346_8 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play926021086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 926021086
		arg_347_1.duration_ = 5.97

		local var_347_0 = {
			zh = 5.966,
			ja = 5.566
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play926021087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10144"]) and arg_347_1.var_.actorSpriteComps10144 == nil then
				arg_347_1.var_.actorSpriteComps10144 = arg_347_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10144"]) then
				if arg_347_1.var_.actorSpriteComps10144 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 1, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10144"]) and arg_347_1.var_.actorSpriteComps10144 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10144 = nil
			end

			local var_350_2 = arg_347_1.actors_["106103"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps106103 == nil then
				arg_347_1.var_.actorSpriteComps106103 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps106103 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								iter_350_5.color = Color.New(Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_5.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_5.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps106103 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_350_7 then
						iter_350_7.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps106103 = nil
			end

			local var_350_5 = 0
			local var_350_6 = 0.8

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(926021086)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 32 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 32)

				if (32 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 32)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021086", "story_v_out_926021.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021086", "story_v_out_926021.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_926021", "926021086", "story_v_out_926021.awb")

						arg_347_1:RecordAudio("926021086", var_350_12)
						arg_347_1:RecordAudio("926021086", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_926021", "926021086", "story_v_out_926021.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_926021", "926021086", "story_v_out_926021.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play926021087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 926021087
		arg_351_1.duration_ = 6.6

		local var_351_0 = {
			zh = 4.6,
			ja = 6.6
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play926021088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.575

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(926021087)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 23 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 23)

				if (23 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 23)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021087", "story_v_out_926021.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021087", "story_v_out_926021.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_926021", "926021087", "story_v_out_926021.awb")

						arg_351_1:RecordAudio("926021087", var_354_6)
						arg_351_1:RecordAudio("926021087", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_926021", "926021087", "story_v_out_926021.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_926021", "926021087", "story_v_out_926021.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play926021088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 926021088
		arg_355_1.duration_ = 8.87

		local var_355_0 = {
			zh = 5.066,
			ja = 8.866
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play926021089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10144 = arg_355_1.actors_["10144"].transform.localPosition
				arg_355_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10144", 4)

				for iter_358_0 = 0, arg_355_1.actors_["10144"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10144"].transform:GetChild(iter_358_0)

					if var_358_0.name == "split_4" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10144"].transform.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_358_2 = 0
			local var_358_3 = 0.7

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_4 = arg_355_1:GetWordFromCfg(926021088)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_7 = 28 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_5) / 28)

				if (28 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_5) / 28)) > 0 and var_358_3 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_2
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021088", "story_v_out_926021.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021088", "story_v_out_926021.awb") / 1000

					if var_358_8 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_2
					end

					if var_358_4.prefab_name ~= "" and arg_355_1.actors_[var_358_4.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_4.prefab_name].transform, "story_v_out_926021", "926021088", "story_v_out_926021.awb")

						arg_355_1:RecordAudio("926021088", var_358_9)
						arg_355_1:RecordAudio("926021088", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_926021", "926021088", "story_v_out_926021.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_926021", "926021088", "story_v_out_926021.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_3, arg_355_1.talkMaxDuration)

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_2) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_2 + var_358_10 and arg_355_1.time_ < var_358_2 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play926021089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 926021089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play926021090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10144"]) and arg_359_1.var_.actorSpriteComps10144 == nil then
				arg_359_1.var_.actorSpriteComps10144 = arg_359_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_0 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10144"]) then
				if arg_359_1.var_.actorSpriteComps10144 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								iter_362_1.color = Color.New(Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor2.r, (arg_359_1.time_ - 0) / var_362_0), Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor2.g, (arg_359_1.time_ - 0) / var_362_0), (Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor2.b, (arg_359_1.time_ - 0) / var_362_0)))
							else
								local var_362_1 = Mathf.Lerp(iter_362_1.color.r, 0.5, (arg_359_1.time_ - 0) / var_362_0)

								iter_362_1.color = Color.New(var_362_1, var_362_1, var_362_1)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10144"]) and arg_359_1.var_.actorSpriteComps10144 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_362_3 then
						iter_362_3.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_359_1.var_.actorSpriteComps10144 = nil
			end

			local var_362_2 = arg_359_1.actors_["10144"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos10144 = var_362_2.localPosition
				var_362_2.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("10144", 7)

				for iter_362_4 = 0, var_362_2.childCount - 1 do
					local var_362_3 = var_362_2:GetChild(iter_362_4)

					if var_362_3.name == "" or not string.find(var_362_3.name, "split") then
						var_362_3.gameObject:SetActive(true)
					else
						var_362_3.gameObject:SetActive(false)
					end
				end
			end

			local var_362_4 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_2.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_359_1.time_ - 0) / var_362_4)
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_362_5 = arg_359_1.actors_["106103"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos106103 = var_362_5.localPosition
				var_362_5.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("106103", 7)

				for iter_362_5 = 0, var_362_5.childCount - 1 do
					local var_362_6 = var_362_5:GetChild(iter_362_5)

					if var_362_6.name == "" or not string.find(var_362_6.name, "split") then
						var_362_6.gameObject:SetActive(true)
					else
						var_362_6.gameObject:SetActive(false)
					end
				end
			end

			local var_362_7 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				var_362_5.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_359_1.time_ - 0) / var_362_7)
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				var_362_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_362_8 = 0
			local var_362_9 = 0.825

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_10 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(926021089).content)

				arg_359_1.text_.text = var_362_10

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_12 = 33 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_10) / 33)

				if (33 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_10) / 33)) > 0 and var_362_9 < var_362_12 then
					arg_359_1.talkMaxDuration = var_362_12

					if var_362_12 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_12 + var_362_8
					end
				end

				arg_359_1.text_.text = var_362_10
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_13 = math.max(var_362_9, arg_359_1.talkMaxDuration)

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_13 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_8) / var_362_13

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_8 + var_362_13 and arg_359_1.time_ < var_362_8 + var_362_13 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play926021090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 926021090
		arg_363_1.duration_ = 5.4

		local var_363_0 = {
			zh = 4.833,
			ja = 5.4
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play926021091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["10144"]) and arg_363_1.var_.actorSpriteComps10144 == nil then
				arg_363_1.var_.actorSpriteComps10144 = arg_363_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["10144"]) then
				if arg_363_1.var_.actorSpriteComps10144 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								iter_366_1.color = Color.New(Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor1.r, (arg_363_1.time_ - 0) / var_366_0), Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor1.g, (arg_363_1.time_ - 0) / var_366_0), (Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor1.b, (arg_363_1.time_ - 0) / var_366_0)))
							else
								local var_366_1 = Mathf.Lerp(iter_366_1.color.r, 1, (arg_363_1.time_ - 0) / var_366_0)

								iter_366_1.color = Color.New(var_366_1, var_366_1, var_366_1)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["10144"]) and arg_363_1.var_.actorSpriteComps10144 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_363_1.var_.actorSpriteComps10144 = nil
			end

			local var_366_2 = 0
			local var_366_3 = 0.475

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_1")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_4 = arg_363_1:GetWordFromCfg(926021090)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 19 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 19)

				if (19 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 19)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021090", "story_v_out_926021.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021090", "story_v_out_926021.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_out_926021", "926021090", "story_v_out_926021.awb")

						arg_363_1:RecordAudio("926021090", var_366_9)
						arg_363_1:RecordAudio("926021090", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_926021", "926021090", "story_v_out_926021.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_926021", "926021090", "story_v_out_926021.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play926021091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 926021091
		arg_367_1.duration_ = 6.33

		local var_367_0 = {
			zh = 5,
			ja = 6.333
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play926021092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["128404"]) and arg_367_1.var_.actorSpriteComps128404 == nil then
				arg_367_1.var_.actorSpriteComps128404 = arg_367_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["128404"]) then
				if arg_367_1.var_.actorSpriteComps128404 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								iter_370_1.color = Color.New(Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_0), Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_0), (Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_0)))
							else
								local var_370_1 = Mathf.Lerp(iter_370_1.color.r, 1, (arg_367_1.time_ - 0) / var_370_0)

								iter_370_1.color = Color.New(var_370_1, var_370_1, var_370_1)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["128404"]) and arg_367_1.var_.actorSpriteComps128404 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_370_3 then
						iter_370_3.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps128404 = nil
			end

			local var_370_2 = arg_367_1.actors_["10144"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10144 == nil then
				arg_367_1.var_.actorSpriteComps10144 = var_370_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_3 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.actorSpriteComps10144 then
					for iter_370_4, iter_370_5 in pairs(arg_367_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_370_5 then
							if arg_367_1.isInRecall_ then
								iter_370_5.color = Color.New(Mathf.Lerp(iter_370_5.color.r, arg_367_1.hightColor2.r, (arg_367_1.time_ - 0) / var_370_3), Mathf.Lerp(iter_370_5.color.g, arg_367_1.hightColor2.g, (arg_367_1.time_ - 0) / var_370_3), (Mathf.Lerp(iter_370_5.color.b, arg_367_1.hightColor2.b, (arg_367_1.time_ - 0) / var_370_3)))
							else
								local var_370_4 = Mathf.Lerp(iter_370_5.color.r, 0.5, (arg_367_1.time_ - 0) / var_370_3)

								iter_370_5.color = Color.New(var_370_4, var_370_4, var_370_4)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10144 then
				for iter_370_6, iter_370_7 in pairs(arg_367_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_370_7 then
						iter_370_7.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_367_1.var_.actorSpriteComps10144 = nil
			end

			local var_370_5 = arg_367_1.actors_["128404"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos128404 = var_370_5.localPosition
				var_370_5.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("128404", 2)

				for iter_370_8 = 0, var_370_5.childCount - 1 do
					local var_370_6 = var_370_5:GetChild(iter_370_8)

					if var_370_6.name == "split_4" or not string.find(var_370_6.name, "split") then
						var_370_6.gameObject:SetActive(true)
					else
						var_370_6.gameObject:SetActive(false)
					end
				end
			end

			local var_370_7 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				var_370_5.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_367_1.time_ - 0) / var_370_7)
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				var_370_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_370_8 = 0
			local var_370_9 = 0.475

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(926021091)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 19 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 19)

				if (19 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 19)) > 0 and var_370_9 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021091", "story_v_out_926021.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021091", "story_v_out_926021.awb") / 1000

					if var_370_14 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_8
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_out_926021", "926021091", "story_v_out_926021.awb")

						arg_367_1:RecordAudio("926021091", var_370_15)
						arg_367_1:RecordAudio("926021091", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_926021", "926021091", "story_v_out_926021.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_926021", "926021091", "story_v_out_926021.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_9, arg_367_1.talkMaxDuration)

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_8) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_8 + var_370_16 and arg_367_1.time_ < var_370_8 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play926021092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 926021092
		arg_371_1.duration_ = 4.53

		local var_371_0 = {
			zh = 4.533,
			ja = 4.133
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play926021093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["106103"]) and arg_371_1.var_.actorSpriteComps106103 == nil then
				arg_371_1.var_.actorSpriteComps106103 = arg_371_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_0 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["106103"]) then
				if arg_371_1.var_.actorSpriteComps106103 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								iter_374_1.color = Color.New(Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor1.r, (arg_371_1.time_ - 0) / var_374_0), Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor1.g, (arg_371_1.time_ - 0) / var_374_0), (Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor1.b, (arg_371_1.time_ - 0) / var_374_0)))
							else
								local var_374_1 = Mathf.Lerp(iter_374_1.color.r, 1, (arg_371_1.time_ - 0) / var_374_0)

								iter_374_1.color = Color.New(var_374_1, var_374_1, var_374_1)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["106103"]) and arg_371_1.var_.actorSpriteComps106103 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_374_3 then
						iter_374_3.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_371_1.var_.actorSpriteComps106103 = nil
			end

			local var_374_2 = arg_371_1.actors_["128404"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps128404 == nil then
				arg_371_1.var_.actorSpriteComps128404 = var_374_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_3 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.actorSpriteComps128404 then
					for iter_374_4, iter_374_5 in pairs(arg_371_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_374_5 then
							if arg_371_1.isInRecall_ then
								iter_374_5.color = Color.New(Mathf.Lerp(iter_374_5.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_3), Mathf.Lerp(iter_374_5.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_3), (Mathf.Lerp(iter_374_5.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_3)))
							else
								local var_374_4 = Mathf.Lerp(iter_374_5.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_3)

								iter_374_5.color = Color.New(var_374_4, var_374_4, var_374_4)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps128404 then
				for iter_374_6, iter_374_7 in pairs(arg_371_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_374_7 then
						iter_374_7.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps128404 = nil
			end

			local var_374_5 = arg_371_1.actors_["106103"].transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos106103 = var_374_5.localPosition
				var_374_5.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("106103", 4)

				for iter_374_8 = 0, var_374_5.childCount - 1 do
					local var_374_6 = var_374_5:GetChild(iter_374_8)

					if var_374_6.name == "split_3" or not string.find(var_374_6.name, "split") then
						var_374_6.gameObject:SetActive(true)
					else
						var_374_6.gameObject:SetActive(false)
					end
				end
			end

			local var_374_7 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				var_374_5.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos106103, Vector3.New(442.7, -398.2, -333.7), (arg_371_1.time_ - 0) / var_374_7)
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				var_374_5.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_374_8 = 0
			local var_374_9 = 0.475

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_10 = arg_371_1:GetWordFromCfg(926021092)
				local var_374_11 = arg_371_1:FormatText(var_374_10.content)

				arg_371_1.text_.text = var_374_11

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 19 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 19)

				if (19 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 19)) > 0 and var_374_9 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_11
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021092", "story_v_out_926021.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021092", "story_v_out_926021.awb") / 1000

					if var_374_14 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_8
					end

					if var_374_10.prefab_name ~= "" and arg_371_1.actors_[var_374_10.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_10.prefab_name].transform, "story_v_out_926021", "926021092", "story_v_out_926021.awb")

						arg_371_1:RecordAudio("926021092", var_374_15)
						arg_371_1:RecordAudio("926021092", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_926021", "926021092", "story_v_out_926021.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_926021", "926021092", "story_v_out_926021.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_8) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_8 + var_374_16 and arg_371_1.time_ < var_374_8 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play926021093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 926021093
		arg_375_1.duration_ = 2.47

		local var_375_0 = {
			zh = 2.466,
			ja = 2.1
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play926021094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.375

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:GetWordFromCfg(926021093)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 15 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 15)

				if (15 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 15)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021093", "story_v_out_926021.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021093", "story_v_out_926021.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_out_926021", "926021093", "story_v_out_926021.awb")

						arg_375_1:RecordAudio("926021093", var_378_6)
						arg_375_1:RecordAudio("926021093", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_926021", "926021093", "story_v_out_926021.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_926021", "926021093", "story_v_out_926021.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play926021094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 926021094
		arg_379_1.duration_ = 10.17

		local var_379_0 = {
			zh = 5.666,
			ja = 10.166
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play926021095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["104701"]) and arg_379_1.var_.actorSpriteComps104701 == nil then
				arg_379_1.var_.actorSpriteComps104701 = arg_379_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["104701"]) then
				if arg_379_1.var_.actorSpriteComps104701 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								iter_382_1.color = Color.New(Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor1.r, (arg_379_1.time_ - 0) / var_382_0), Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor1.g, (arg_379_1.time_ - 0) / var_382_0), (Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor1.b, (arg_379_1.time_ - 0) / var_382_0)))
							else
								local var_382_1 = Mathf.Lerp(iter_382_1.color.r, 1, (arg_379_1.time_ - 0) / var_382_0)

								iter_382_1.color = Color.New(var_382_1, var_382_1, var_382_1)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["104701"]) and arg_379_1.var_.actorSpriteComps104701 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_382_3 then
						iter_382_3.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_379_1.var_.actorSpriteComps104701 = nil
			end

			local var_382_2 = arg_379_1.actors_["106103"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.actorSpriteComps106103 == nil then
				arg_379_1.var_.actorSpriteComps106103 = var_382_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_3 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_3 and not isNil(var_382_2) then
				if arg_379_1.var_.actorSpriteComps106103 then
					for iter_382_4, iter_382_5 in pairs(arg_379_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_382_5 then
							if arg_379_1.isInRecall_ then
								iter_382_5.color = Color.New(Mathf.Lerp(iter_382_5.color.r, arg_379_1.hightColor2.r, (arg_379_1.time_ - 0) / var_382_3), Mathf.Lerp(iter_382_5.color.g, arg_379_1.hightColor2.g, (arg_379_1.time_ - 0) / var_382_3), (Mathf.Lerp(iter_382_5.color.b, arg_379_1.hightColor2.b, (arg_379_1.time_ - 0) / var_382_3)))
							else
								local var_382_4 = Mathf.Lerp(iter_382_5.color.r, 0.5, (arg_379_1.time_ - 0) / var_382_3)

								iter_382_5.color = Color.New(var_382_4, var_382_4, var_382_4)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_3 and arg_379_1.time_ < 0 + var_382_3 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.actorSpriteComps106103 then
				for iter_382_6, iter_382_7 in pairs(arg_379_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_382_7 then
						iter_382_7.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_379_1.var_.actorSpriteComps106103 = nil
			end

			local var_382_5 = arg_379_1.actors_["128404"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos128404 = var_382_5.localPosition
				var_382_5.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("128404", 7)

				for iter_382_8 = 0, var_382_5.childCount - 1 do
					local var_382_6 = var_382_5:GetChild(iter_382_8)

					if var_382_6.name == "" or not string.find(var_382_6.name, "split") then
						var_382_6.gameObject:SetActive(true)
					else
						var_382_6.gameObject:SetActive(false)
					end
				end
			end

			local var_382_7 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				var_382_5.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_379_1.time_ - 0) / var_382_7)
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				var_382_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_8 = arg_379_1.actors_["106103"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos106103 = var_382_8.localPosition
				var_382_8.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("106103", 7)

				for iter_382_9 = 0, var_382_8.childCount - 1 do
					local var_382_9 = var_382_8:GetChild(iter_382_9)

					if var_382_9.name == "" or not string.find(var_382_9.name, "split") then
						var_382_9.gameObject:SetActive(true)
					else
						var_382_9.gameObject:SetActive(false)
					end
				end
			end

			local var_382_10 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_10 then
				var_382_8.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_379_1.time_ - 0) / var_382_10)
			end

			if arg_379_1.time_ >= 0 + var_382_10 and arg_379_1.time_ < 0 + var_382_10 + arg_382_0 then
				var_382_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_11 = arg_379_1.actors_["104701"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos104701 = var_382_11.localPosition
				var_382_11.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("104701", 2)

				for iter_382_10 = 0, var_382_11.childCount - 1 do
					local var_382_12 = var_382_11:GetChild(iter_382_10)

					if var_382_12.name == "" or not string.find(var_382_12.name, "split") then
						var_382_12.gameObject:SetActive(true)
					else
						var_382_12.gameObject:SetActive(false)
					end
				end
			end

			local var_382_13 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_13 then
				var_382_11.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos104701, Vector3.New(-528.7, -386.8, -295), (arg_379_1.time_ - 0) / var_382_13)
			end

			if arg_379_1.time_ >= 0 + var_382_13 and arg_379_1.time_ < 0 + var_382_13 + arg_382_0 then
				var_382_11.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_382_14 = 0
			local var_382_15 = 0.6

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_16 = arg_379_1:GetWordFromCfg(926021094)
				local var_382_17 = arg_379_1:FormatText(var_382_16.content)

				arg_379_1.text_.text = var_382_17

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_19 = 24 <= 0 and var_382_15 or var_382_15 * (utf8.len(var_382_17) / 24)

				if (24 <= 0 and var_382_15 or var_382_15 * (utf8.len(var_382_17) / 24)) > 0 and var_382_15 < var_382_19 then
					arg_379_1.talkMaxDuration = var_382_19

					if var_382_19 + var_382_14 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_19 + var_382_14
					end
				end

				arg_379_1.text_.text = var_382_17
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021094", "story_v_out_926021.awb") ~= 0 then
					local var_382_20 = manager.audio:GetVoiceLength("story_v_out_926021", "926021094", "story_v_out_926021.awb") / 1000

					if var_382_20 + var_382_14 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_20 + var_382_14
					end

					if var_382_16.prefab_name ~= "" and arg_379_1.actors_[var_382_16.prefab_name] ~= nil then
						local var_382_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_16.prefab_name].transform, "story_v_out_926021", "926021094", "story_v_out_926021.awb")

						arg_379_1:RecordAudio("926021094", var_382_21)
						arg_379_1:RecordAudio("926021094", var_382_21)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_926021", "926021094", "story_v_out_926021.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_926021", "926021094", "story_v_out_926021.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_22 = math.max(var_382_15, arg_379_1.talkMaxDuration)

			if var_382_14 <= arg_379_1.time_ and arg_379_1.time_ < var_382_14 + var_382_22 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_14) / var_382_22

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_14 + var_382_22 and arg_379_1.time_ < var_382_14 + var_382_22 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play926021095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 926021095
		arg_383_1.duration_ = 4.03

		local var_383_0 = {
			zh = 3.266,
			ja = 4.033
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play926021096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["10144"]) and arg_383_1.var_.actorSpriteComps10144 == nil then
				arg_383_1.var_.actorSpriteComps10144 = arg_383_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["10144"]) then
				if arg_383_1.var_.actorSpriteComps10144 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								iter_386_1.color = Color.New(Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_0), Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_0), (Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_0)))
							else
								local var_386_1 = Mathf.Lerp(iter_386_1.color.r, 1, (arg_383_1.time_ - 0) / var_386_0)

								iter_386_1.color = Color.New(var_386_1, var_386_1, var_386_1)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["10144"]) and arg_383_1.var_.actorSpriteComps10144 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_386_3 then
						iter_386_3.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps10144 = nil
			end

			local var_386_2 = arg_383_1.actors_["104701"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps104701 == nil then
				arg_383_1.var_.actorSpriteComps104701 = var_386_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_3 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 and not isNil(var_386_2) then
				if arg_383_1.var_.actorSpriteComps104701 then
					for iter_386_4, iter_386_5 in pairs(arg_383_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_386_5 then
							if arg_383_1.isInRecall_ then
								iter_386_5.color = Color.New(Mathf.Lerp(iter_386_5.color.r, arg_383_1.hightColor2.r, (arg_383_1.time_ - 0) / var_386_3), Mathf.Lerp(iter_386_5.color.g, arg_383_1.hightColor2.g, (arg_383_1.time_ - 0) / var_386_3), (Mathf.Lerp(iter_386_5.color.b, arg_383_1.hightColor2.b, (arg_383_1.time_ - 0) / var_386_3)))
							else
								local var_386_4 = Mathf.Lerp(iter_386_5.color.r, 0.5, (arg_383_1.time_ - 0) / var_386_3)

								iter_386_5.color = Color.New(var_386_4, var_386_4, var_386_4)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps104701 then
				for iter_386_6, iter_386_7 in pairs(arg_383_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_386_7 then
						iter_386_7.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_383_1.var_.actorSpriteComps104701 = nil
			end

			local var_386_5 = arg_383_1.actors_["10144"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10144 = var_386_5.localPosition
				var_386_5.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10144", 4)

				for iter_386_8 = 0, var_386_5.childCount - 1 do
					local var_386_6 = var_386_5:GetChild(iter_386_8)

					if var_386_6.name == "" or not string.find(var_386_6.name, "split") then
						var_386_6.gameObject:SetActive(true)
					else
						var_386_6.gameObject:SetActive(false)
					end
				end
			end

			local var_386_7 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				var_386_5.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_383_1.time_ - 0) / var_386_7)
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				var_386_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_386_8 = 0
			local var_386_9 = 0.35

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_10 = arg_383_1:GetWordFromCfg(926021095)
				local var_386_11 = arg_383_1:FormatText(var_386_10.content)

				arg_383_1.text_.text = var_386_11

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_13 = 14 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 14)

				if (14 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_11) / 14)) > 0 and var_386_9 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_8
					end
				end

				arg_383_1.text_.text = var_386_11
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021095", "story_v_out_926021.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021095", "story_v_out_926021.awb") / 1000

					if var_386_14 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_8
					end

					if var_386_10.prefab_name ~= "" and arg_383_1.actors_[var_386_10.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_10.prefab_name].transform, "story_v_out_926021", "926021095", "story_v_out_926021.awb")

						arg_383_1:RecordAudio("926021095", var_386_15)
						arg_383_1:RecordAudio("926021095", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_926021", "926021095", "story_v_out_926021.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_926021", "926021095", "story_v_out_926021.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_9, arg_383_1.talkMaxDuration)

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_8) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_8 + var_386_16 and arg_383_1.time_ < var_386_8 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play926021096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 926021096
		arg_387_1.duration_ = 5.63

		local var_387_0 = {
			zh = 5.633,
			ja = 5.3
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play926021097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.7

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:GetWordFromCfg(926021096)
				local var_390_2 = arg_387_1:FormatText(var_390_1.content)

				arg_387_1.text_.text = var_390_2

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_4 = 28 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 28)

				if (28 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_2) / 28)) > 0 and var_390_0 < var_390_4 then
					arg_387_1.talkMaxDuration = var_390_4

					if var_390_4 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_4 + 0
					end
				end

				arg_387_1.text_.text = var_390_2
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021096", "story_v_out_926021.awb") ~= 0 then
					local var_390_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021096", "story_v_out_926021.awb") / 1000

					if var_390_5 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + 0
					end

					if var_390_1.prefab_name ~= "" and arg_387_1.actors_[var_390_1.prefab_name] ~= nil then
						local var_390_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_1.prefab_name].transform, "story_v_out_926021", "926021096", "story_v_out_926021.awb")

						arg_387_1:RecordAudio("926021096", var_390_6)
						arg_387_1:RecordAudio("926021096", var_390_6)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_926021", "926021096", "story_v_out_926021.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_926021", "926021096", "story_v_out_926021.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play926021097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 926021097
		arg_391_1.duration_ = 3.7

		local var_391_0 = {
			zh = 3.1,
			ja = 3.7
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play926021098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["104701"]) and arg_391_1.var_.actorSpriteComps104701 == nil then
				arg_391_1.var_.actorSpriteComps104701 = arg_391_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["104701"]) then
				if arg_391_1.var_.actorSpriteComps104701 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								iter_394_1.color = Color.New(Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor1.r, (arg_391_1.time_ - 0) / var_394_0), Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor1.g, (arg_391_1.time_ - 0) / var_394_0), (Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor1.b, (arg_391_1.time_ - 0) / var_394_0)))
							else
								local var_394_1 = Mathf.Lerp(iter_394_1.color.r, 1, (arg_391_1.time_ - 0) / var_394_0)

								iter_394_1.color = Color.New(var_394_1, var_394_1, var_394_1)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["104701"]) and arg_391_1.var_.actorSpriteComps104701 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_394_3 then
						iter_394_3.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_391_1.var_.actorSpriteComps104701 = nil
			end

			local var_394_2 = arg_391_1.actors_["10144"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_2) and arg_391_1.var_.actorSpriteComps10144 == nil then
				arg_391_1.var_.actorSpriteComps10144 = var_394_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_3 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_3 and not isNil(var_394_2) then
				if arg_391_1.var_.actorSpriteComps10144 then
					for iter_394_4, iter_394_5 in pairs(arg_391_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_394_5 then
							if arg_391_1.isInRecall_ then
								iter_394_5.color = Color.New(Mathf.Lerp(iter_394_5.color.r, arg_391_1.hightColor2.r, (arg_391_1.time_ - 0) / var_394_3), Mathf.Lerp(iter_394_5.color.g, arg_391_1.hightColor2.g, (arg_391_1.time_ - 0) / var_394_3), (Mathf.Lerp(iter_394_5.color.b, arg_391_1.hightColor2.b, (arg_391_1.time_ - 0) / var_394_3)))
							else
								local var_394_4 = Mathf.Lerp(iter_394_5.color.r, 0.5, (arg_391_1.time_ - 0) / var_394_3)

								iter_394_5.color = Color.New(var_394_4, var_394_4, var_394_4)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_3 and arg_391_1.time_ < 0 + var_394_3 + arg_394_0 and not isNil(var_394_2) and arg_391_1.var_.actorSpriteComps10144 then
				for iter_394_6, iter_394_7 in pairs(arg_391_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_394_7 then
						iter_394_7.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_391_1.var_.actorSpriteComps10144 = nil
			end

			local var_394_5 = 0
			local var_394_6 = 0.375

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_7 = arg_391_1:GetWordFromCfg(926021097)
				local var_394_8 = arg_391_1:FormatText(var_394_7.content)

				arg_391_1.text_.text = var_394_8

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_10 = 15 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 15)

				if (15 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 15)) > 0 and var_394_6 < var_394_10 then
					arg_391_1.talkMaxDuration = var_394_10

					if var_394_10 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_5
					end
				end

				arg_391_1.text_.text = var_394_8
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021097", "story_v_out_926021.awb") ~= 0 then
					local var_394_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021097", "story_v_out_926021.awb") / 1000

					if var_394_11 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_11 + var_394_5
					end

					if var_394_7.prefab_name ~= "" and arg_391_1.actors_[var_394_7.prefab_name] ~= nil then
						local var_394_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_7.prefab_name].transform, "story_v_out_926021", "926021097", "story_v_out_926021.awb")

						arg_391_1:RecordAudio("926021097", var_394_12)
						arg_391_1:RecordAudio("926021097", var_394_12)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_926021", "926021097", "story_v_out_926021.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_926021", "926021097", "story_v_out_926021.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_13 = math.max(var_394_6, arg_391_1.talkMaxDuration)

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_13 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_5) / var_394_13

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_5 + var_394_13 and arg_391_1.time_ < var_394_5 + var_394_13 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play926021098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 926021098
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play926021099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["104701"]) and arg_395_1.var_.actorSpriteComps104701 == nil then
				arg_395_1.var_.actorSpriteComps104701 = arg_395_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_0 = 0.2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["104701"]) then
				if arg_395_1.var_.actorSpriteComps104701 then
					for iter_398_0, iter_398_1 in pairs(arg_395_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_398_1 then
							if arg_395_1.isInRecall_ then
								iter_398_1.color = Color.New(Mathf.Lerp(iter_398_1.color.r, arg_395_1.hightColor2.r, (arg_395_1.time_ - 0) / var_398_0), Mathf.Lerp(iter_398_1.color.g, arg_395_1.hightColor2.g, (arg_395_1.time_ - 0) / var_398_0), (Mathf.Lerp(iter_398_1.color.b, arg_395_1.hightColor2.b, (arg_395_1.time_ - 0) / var_398_0)))
							else
								local var_398_1 = Mathf.Lerp(iter_398_1.color.r, 0.5, (arg_395_1.time_ - 0) / var_398_0)

								iter_398_1.color = Color.New(var_398_1, var_398_1, var_398_1)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["104701"]) and arg_395_1.var_.actorSpriteComps104701 then
				for iter_398_2, iter_398_3 in pairs(arg_395_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_398_3 then
						iter_398_3.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_395_1.var_.actorSpriteComps104701 = nil
			end

			local var_398_2 = arg_395_1.actors_["10144"].transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos10144 = var_398_2.localPosition
				var_398_2.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10144", 7)

				for iter_398_4 = 0, var_398_2.childCount - 1 do
					local var_398_3 = var_398_2:GetChild(iter_398_4)

					if var_398_3.name == "" or not string.find(var_398_3.name, "split") then
						var_398_3.gameObject:SetActive(true)
					else
						var_398_3.gameObject:SetActive(false)
					end
				end
			end

			local var_398_4 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				var_398_2.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_395_1.time_ - 0) / var_398_4)
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				var_398_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_398_5 = arg_395_1.actors_["104701"].transform

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos104701 = var_398_5.localPosition
				var_398_5.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("104701", 7)

				for iter_398_5 = 0, var_398_5.childCount - 1 do
					local var_398_6 = var_398_5:GetChild(iter_398_5)

					if var_398_6.name == "" or not string.find(var_398_6.name, "split") then
						var_398_6.gameObject:SetActive(true)
					else
						var_398_6.gameObject:SetActive(false)
					end
				end
			end

			local var_398_7 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				var_398_5.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_395_1.time_ - 0) / var_398_7)
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				var_398_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_398_8 = 0
			local var_398_9 = 0.325

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_8 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_10 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(926021098).content)

				arg_395_1.text_.text = var_398_10

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_12 = 13 <= 0 and var_398_9 or var_398_9 * (utf8.len(var_398_10) / 13)

				if (13 <= 0 and var_398_9 or var_398_9 * (utf8.len(var_398_10) / 13)) > 0 and var_398_9 < var_398_12 then
					arg_395_1.talkMaxDuration = var_398_12

					if var_398_12 + var_398_8 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_12 + var_398_8
					end
				end

				arg_395_1.text_.text = var_398_10
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_13 = math.max(var_398_9, arg_395_1.talkMaxDuration)

			if var_398_8 <= arg_395_1.time_ and arg_395_1.time_ < var_398_8 + var_398_13 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_8) / var_398_13

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_8 + var_398_13 and arg_395_1.time_ < var_398_8 + var_398_13 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play926021099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 926021099
		arg_399_1.duration_ = 8.6

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play926021100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if arg_399_1.bgs_.ST0108 == nil then
				local var_402_0 = Object.Instantiate(arg_399_1.paintGo_)

				var_402_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0108")
				var_402_0.name = "ST0108"
				var_402_0.transform.parent = arg_399_1.stage_.transform
				var_402_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_399_1.bgs_.ST0108 = var_402_0
			end

			if 2 < arg_399_1.time_ and arg_399_1.time_ <= 2 + arg_402_0 then
				local var_402_1 = arg_399_1.bgs_.ST0108

				arg_399_1.bgs_.ST0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_402_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_402_2 = var_402_1:GetComponent("SpriteRenderer")

				if var_402_2 and var_402_2.sprite then
					local var_402_3 = 2 * (var_402_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_402_1.transform.localScale = Vector3.New(var_402_3 / var_402_2.sprite.bounds.size.y < var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x and var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x or var_402_3 / var_402_2.sprite.bounds.size.y, var_402_3 / var_402_2.sprite.bounds.size.y < var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x and var_402_3 * manager.ui.mainCameraCom_.aspect / var_402_2.sprite.bounds.size.x or var_402_3 / var_402_2.sprite.bounds.size.y, 0)
				end

				for iter_402_0, iter_402_1 in pairs(arg_399_1.bgs_) do
					if iter_402_0 ~= "ST0108" then
						iter_402_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_402_4 = 0

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.allBtn_.enabled = false
			end

			if arg_399_1.time_ >= var_402_4 + 0.3 and arg_399_1.time_ < var_402_4 + 0.3 + arg_402_0 then
				arg_399_1.allBtn_.enabled = true
			end

			local var_402_5 = 0

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_6 = 2

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_6 then
				local var_402_7 = Color.New(0, 0, 0)

				var_402_7.a = Mathf.Lerp(0, 1, (arg_399_1.time_ - var_402_5) / var_402_6)
				arg_399_1.mask_.color = var_402_7
			end

			if arg_399_1.time_ >= var_402_5 + var_402_6 and arg_399_1.time_ < var_402_5 + var_402_6 + arg_402_0 then
				local var_402_8 = Color.New(0, 0, 0)

				var_402_8.a = 1
				arg_399_1.mask_.color = var_402_8
			end

			local var_402_9 = 2

			if 2 < arg_399_1.time_ and arg_399_1.time_ <= var_402_9 + arg_402_0 then
				arg_399_1.mask_.enabled = true
				arg_399_1.mask_.raycastTarget = true

				arg_399_1:SetGaussion(false)
			end

			local var_402_10 = 2

			if var_402_9 <= arg_399_1.time_ and arg_399_1.time_ < var_402_9 + var_402_10 then
				local var_402_11 = Color.New(0, 0, 0)

				var_402_11.a = Mathf.Lerp(1, 0, (arg_399_1.time_ - var_402_9) / var_402_10)
				arg_399_1.mask_.color = var_402_11
			end

			if arg_399_1.time_ >= var_402_9 + var_402_10 and arg_399_1.time_ < var_402_9 + var_402_10 + arg_402_0 then
				local var_402_12 = Color.New(0, 0, 0)

				arg_399_1.mask_.enabled = false
				var_402_12.a = 0
				arg_399_1.mask_.color = var_402_12
			end

			if 0.166666666666667 < arg_399_1.time_ and arg_399_1.time_ <= 0.166666666666667 + arg_402_0 then
				arg_399_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if 1.5 < arg_399_1.time_ and arg_399_1.time_ <= 1.5 + arg_402_0 then
				arg_399_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_402_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_399_1.bgmTxt_.text ~= var_402_17 and arg_399_1.bgmTxt_.text ~= "" then
						if arg_399_1.bgmTxt2_.text ~= "" then
							arg_399_1.bgmTxt_.text = arg_399_1.bgmTxt2_.text
						end

						arg_399_1.bgmTxt2_.text = var_402_17

						arg_399_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_399_1.bgmTxt_.text = var_402_17
						arg_399_1.bgmTxt2_.text = var_402_17
					end

					if arg_399_1.bgmTimer then
						arg_399_1.bgmTimer:Stop()

						arg_399_1.bgmTimer = nil
					end

					if arg_399_1.settingData.show_music_name == 1 then
						arg_399_1.musicController:SetSelectedState("show")
						arg_399_1.musicAnimator_:Play("open", 0, 0)

						if arg_399_1.settingData.music_time ~= 0 then
							arg_399_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_399_1.settingData.music_time), function()
								if arg_399_1 == nil or isNil(arg_399_1.bgmTxt_) then
									return
								end

								arg_399_1.musicController:SetSelectedState("hide")
								arg_399_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_399_1.frameCnt_ <= 1 then
				arg_399_1.dialog_:SetActive(false)
			end

			local var_402_18 = 3.6
			local var_402_19 = 1.075

			if 3.6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_18 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0

				arg_399_1.dialog_:SetActive(true)

				arg_399_1.dialogCg_.alpha = 0

				local var_402_20 = LeanTween.value(arg_399_1.dialog_, 0, 1, 0.3)

				var_402_20:setOnUpdate(LuaHelper.FloatAction(function(arg_404_0)
					arg_399_1.dialogCg_.alpha = arg_404_0
				end))
				var_402_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_399_1.dialog_)
					var_402_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_399_1.duration_ = arg_399_1.duration_ + 0.3

				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_21 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(926021099).content)

				arg_399_1.text_.text = var_402_21

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_23 = 43 <= 0 and var_402_19 or var_402_19 * (utf8.len(var_402_21) / 43)

				if (43 <= 0 and var_402_19 or var_402_19 * (utf8.len(var_402_21) / 43)) > 0 and var_402_19 < var_402_23 then
					arg_399_1.talkMaxDuration = var_402_23
					var_402_18 = var_402_18 + 0.3

					if var_402_23 + var_402_18 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_23 + var_402_18
					end
				end

				arg_399_1.text_.text = var_402_21
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_24 = var_402_18 + 0.3
			local var_402_25 = math.max(var_402_19, arg_399_1.talkMaxDuration)

			if var_402_18 + 0.3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_24 + var_402_25 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_24) / var_402_25

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_24 + var_402_25 and arg_399_1.time_ < var_402_24 + var_402_25 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play926021100 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 926021100
		arg_406_1.duration_ = 4.4

		local var_406_0 = {
			zh = 3.533,
			ja = 4.4
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play926021101(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["104701"]) and arg_406_1.var_.actorSpriteComps104701 == nil then
				arg_406_1.var_.actorSpriteComps104701 = arg_406_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_409_0 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["104701"]) then
				if arg_406_1.var_.actorSpriteComps104701 then
					for iter_409_0, iter_409_1 in pairs(arg_406_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_409_1 then
							if arg_406_1.isInRecall_ then
								iter_409_1.color = Color.New(Mathf.Lerp(iter_409_1.color.r, arg_406_1.hightColor1.r, (arg_406_1.time_ - 0) / var_409_0), Mathf.Lerp(iter_409_1.color.g, arg_406_1.hightColor1.g, (arg_406_1.time_ - 0) / var_409_0), (Mathf.Lerp(iter_409_1.color.b, arg_406_1.hightColor1.b, (arg_406_1.time_ - 0) / var_409_0)))
							else
								local var_409_1 = Mathf.Lerp(iter_409_1.color.r, 1, (arg_406_1.time_ - 0) / var_409_0)

								iter_409_1.color = Color.New(var_409_1, var_409_1, var_409_1)
							end
						end
					end
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["104701"]) and arg_406_1.var_.actorSpriteComps104701 then
				for iter_409_2, iter_409_3 in pairs(arg_406_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_409_3 then
						iter_409_3.color = arg_406_1.isInRecall_ and (arg_406_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_406_1.var_.actorSpriteComps104701 = nil
			end

			local var_409_2 = arg_406_1.actors_["104701"].transform

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos104701 = var_409_2.localPosition
				var_409_2.localScale = Vector3.New(1, 1, 1)

				arg_406_1:CheckSpriteTmpPos("104701", 2)

				for iter_409_4 = 0, var_409_2.childCount - 1 do
					local var_409_3 = var_409_2:GetChild(iter_409_4)

					if var_409_3.name == "" or not string.find(var_409_3.name, "split") then
						var_409_3.gameObject:SetActive(true)
					else
						var_409_3.gameObject:SetActive(false)
					end
				end
			end

			local var_409_4 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				var_409_2.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos104701, Vector3.New(-528.7, -386.8, -295), (arg_406_1.time_ - 0) / var_409_4)
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				var_409_2.localPosition = Vector3.New(-528.7, -386.8, -295)
			end

			local var_409_5 = 0
			local var_409_6 = 0.35

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_7 = arg_406_1:GetWordFromCfg(926021100)
				local var_409_8 = arg_406_1:FormatText(var_409_7.content)

				arg_406_1.text_.text = var_409_8

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_10 = 14 <= 0 and var_409_6 or var_409_6 * (utf8.len(var_409_8) / 14)

				if (14 <= 0 and var_409_6 or var_409_6 * (utf8.len(var_409_8) / 14)) > 0 and var_409_6 < var_409_10 then
					arg_406_1.talkMaxDuration = var_409_10

					if var_409_10 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_5
					end
				end

				arg_406_1.text_.text = var_409_8
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021100", "story_v_out_926021.awb") ~= 0 then
					local var_409_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021100", "story_v_out_926021.awb") / 1000

					if var_409_11 + var_409_5 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_11 + var_409_5
					end

					if var_409_7.prefab_name ~= "" and arg_406_1.actors_[var_409_7.prefab_name] ~= nil then
						local var_409_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_7.prefab_name].transform, "story_v_out_926021", "926021100", "story_v_out_926021.awb")

						arg_406_1:RecordAudio("926021100", var_409_12)
						arg_406_1:RecordAudio("926021100", var_409_12)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_926021", "926021100", "story_v_out_926021.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_926021", "926021100", "story_v_out_926021.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_13 = math.max(var_409_6, arg_406_1.talkMaxDuration)

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_13 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_5) / var_409_13

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_5 + var_409_13 and arg_406_1.time_ < var_409_5 + var_409_13 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play926021101 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 926021101
		arg_410_1.duration_ = 3.23

		local var_410_0 = {
			zh = 2.166,
			ja = 3.233
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play926021102(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["10144"]) and arg_410_1.var_.actorSpriteComps10144 == nil then
				arg_410_1.var_.actorSpriteComps10144 = arg_410_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["10144"]) then
				if arg_410_1.var_.actorSpriteComps10144 then
					for iter_413_0, iter_413_1 in pairs(arg_410_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_413_1 then
							if arg_410_1.isInRecall_ then
								iter_413_1.color = Color.New(Mathf.Lerp(iter_413_1.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_0), Mathf.Lerp(iter_413_1.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_0), (Mathf.Lerp(iter_413_1.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_0)))
							else
								local var_413_1 = Mathf.Lerp(iter_413_1.color.r, 1, (arg_410_1.time_ - 0) / var_413_0)

								iter_413_1.color = Color.New(var_413_1, var_413_1, var_413_1)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["10144"]) and arg_410_1.var_.actorSpriteComps10144 then
				for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_413_3 then
						iter_413_3.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps10144 = nil
			end

			local var_413_2 = arg_410_1.actors_["104701"]

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps104701 == nil then
				arg_410_1.var_.actorSpriteComps104701 = var_413_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_3 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_3 and not isNil(var_413_2) then
				if arg_410_1.var_.actorSpriteComps104701 then
					for iter_413_4, iter_413_5 in pairs(arg_410_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_413_5 then
							if arg_410_1.isInRecall_ then
								iter_413_5.color = Color.New(Mathf.Lerp(iter_413_5.color.r, arg_410_1.hightColor2.r, (arg_410_1.time_ - 0) / var_413_3), Mathf.Lerp(iter_413_5.color.g, arg_410_1.hightColor2.g, (arg_410_1.time_ - 0) / var_413_3), (Mathf.Lerp(iter_413_5.color.b, arg_410_1.hightColor2.b, (arg_410_1.time_ - 0) / var_413_3)))
							else
								local var_413_4 = Mathf.Lerp(iter_413_5.color.r, 0.5, (arg_410_1.time_ - 0) / var_413_3)

								iter_413_5.color = Color.New(var_413_4, var_413_4, var_413_4)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_3 and arg_410_1.time_ < 0 + var_413_3 + arg_413_0 and not isNil(var_413_2) and arg_410_1.var_.actorSpriteComps104701 then
				for iter_413_6, iter_413_7 in pairs(arg_410_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_413_7 then
						iter_413_7.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_410_1.var_.actorSpriteComps104701 = nil
			end

			local var_413_5 = arg_410_1.actors_["10144"].transform

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.var_.moveOldPos10144 = var_413_5.localPosition
				var_413_5.localScale = Vector3.New(1, 1, 1)

				arg_410_1:CheckSpriteTmpPos("10144", 4)

				for iter_413_8 = 0, var_413_5.childCount - 1 do
					local var_413_6 = var_413_5:GetChild(iter_413_8)

					if var_413_6.name == "" or not string.find(var_413_6.name, "split") then
						var_413_6.gameObject:SetActive(true)
					else
						var_413_6.gameObject:SetActive(false)
					end
				end
			end

			local var_413_7 = 0.001

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				var_413_5.localPosition = Vector3.Lerp(arg_410_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_410_1.time_ - 0) / var_413_7)
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				var_413_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_413_8 = 0
			local var_413_9 = 0.275

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_8 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_10 = arg_410_1:GetWordFromCfg(926021101)
				local var_413_11 = arg_410_1:FormatText(var_413_10.content)

				arg_410_1.text_.text = var_413_11

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_13 = 11 <= 0 and var_413_9 or var_413_9 * (utf8.len(var_413_11) / 11)

				if (11 <= 0 and var_413_9 or var_413_9 * (utf8.len(var_413_11) / 11)) > 0 and var_413_9 < var_413_13 then
					arg_410_1.talkMaxDuration = var_413_13

					if var_413_13 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_13 + var_413_8
					end
				end

				arg_410_1.text_.text = var_413_11
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021101", "story_v_out_926021.awb") ~= 0 then
					local var_413_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021101", "story_v_out_926021.awb") / 1000

					if var_413_14 + var_413_8 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_14 + var_413_8
					end

					if var_413_10.prefab_name ~= "" and arg_410_1.actors_[var_413_10.prefab_name] ~= nil then
						local var_413_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_10.prefab_name].transform, "story_v_out_926021", "926021101", "story_v_out_926021.awb")

						arg_410_1:RecordAudio("926021101", var_413_15)
						arg_410_1:RecordAudio("926021101", var_413_15)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_926021", "926021101", "story_v_out_926021.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_926021", "926021101", "story_v_out_926021.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_16 = math.max(var_413_9, arg_410_1.talkMaxDuration)

			if var_413_8 <= arg_410_1.time_ and arg_410_1.time_ < var_413_8 + var_413_16 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_8) / var_413_16

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_8 + var_413_16 and arg_410_1.time_ < var_413_8 + var_413_16 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_410_1:InitPlayNodeList()
	end,
	Play926021102 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 926021102
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play926021103(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(arg_414_1.actors_["10144"]) and arg_414_1.var_.actorSpriteComps10144 == nil then
				arg_414_1.var_.actorSpriteComps10144 = arg_414_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_417_0 = 0.2

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 and not isNil(arg_414_1.actors_["10144"]) then
				if arg_414_1.var_.actorSpriteComps10144 then
					for iter_417_0, iter_417_1 in pairs(arg_414_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_417_1 then
							if arg_414_1.isInRecall_ then
								iter_417_1.color = Color.New(Mathf.Lerp(iter_417_1.color.r, arg_414_1.hightColor2.r, (arg_414_1.time_ - 0) / var_417_0), Mathf.Lerp(iter_417_1.color.g, arg_414_1.hightColor2.g, (arg_414_1.time_ - 0) / var_417_0), (Mathf.Lerp(iter_417_1.color.b, arg_414_1.hightColor2.b, (arg_414_1.time_ - 0) / var_417_0)))
							else
								local var_417_1 = Mathf.Lerp(iter_417_1.color.r, 0.5, (arg_414_1.time_ - 0) / var_417_0)

								iter_417_1.color = Color.New(var_417_1, var_417_1, var_417_1)
							end
						end
					end
				end
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 and not isNil(arg_414_1.actors_["10144"]) and arg_414_1.var_.actorSpriteComps10144 then
				for iter_417_2, iter_417_3 in pairs(arg_414_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_417_3 then
						iter_417_3.color = arg_414_1.isInRecall_ and (arg_414_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_414_1.var_.actorSpriteComps10144 = nil
			end

			local var_417_2 = 0
			local var_417_3 = 0.275

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_2 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_4 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(926021102).content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_6 = 11 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_4) / 11)

				if (11 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_4) / 11)) > 0 and var_417_3 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_2
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_3, arg_414_1.talkMaxDuration)

			if var_417_2 <= arg_414_1.time_ and arg_414_1.time_ < var_417_2 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_2) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_2 + var_417_7 and arg_414_1.time_ < var_417_2 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play926021103 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 926021103
		arg_418_1.duration_ = 6.8

		local var_418_0 = {
			zh = 3.733,
			ja = 6.8
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play926021104(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["10144"]) and arg_418_1.var_.actorSpriteComps10144 == nil then
				arg_418_1.var_.actorSpriteComps10144 = arg_418_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["10144"]) then
				if arg_418_1.var_.actorSpriteComps10144 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								iter_421_1.color = Color.New(Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor1.r, (arg_418_1.time_ - 0) / var_421_0), Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor1.g, (arg_418_1.time_ - 0) / var_421_0), (Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor1.b, (arg_418_1.time_ - 0) / var_421_0)))
							else
								local var_421_1 = Mathf.Lerp(iter_421_1.color.r, 1, (arg_418_1.time_ - 0) / var_421_0)

								iter_421_1.color = Color.New(var_421_1, var_421_1, var_421_1)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["10144"]) and arg_418_1.var_.actorSpriteComps10144 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_421_3 then
						iter_421_3.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_418_1.var_.actorSpriteComps10144 = nil
			end

			local var_421_2 = 0
			local var_421_3 = 0.45

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_4 = arg_418_1:GetWordFromCfg(926021103)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 18 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 18)

				if (18 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 18)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021103", "story_v_out_926021.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021103", "story_v_out_926021.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_out_926021", "926021103", "story_v_out_926021.awb")

						arg_418_1:RecordAudio("926021103", var_421_9)
						arg_418_1:RecordAudio("926021103", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_926021", "926021103", "story_v_out_926021.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_926021", "926021103", "story_v_out_926021.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play926021104 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 926021104
		arg_422_1.duration_ = 6.93

		local var_422_0 = {
			zh = 3.333,
			ja = 6.933
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play926021105(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["104701"]) and arg_422_1.var_.actorSpriteComps104701 == nil then
				arg_422_1.var_.actorSpriteComps104701 = arg_422_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["104701"]) then
				if arg_422_1.var_.actorSpriteComps104701 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								iter_425_1.color = Color.New(Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor1.r, (arg_422_1.time_ - 0) / var_425_0), Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor1.g, (arg_422_1.time_ - 0) / var_425_0), (Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor1.b, (arg_422_1.time_ - 0) / var_425_0)))
							else
								local var_425_1 = Mathf.Lerp(iter_425_1.color.r, 1, (arg_422_1.time_ - 0) / var_425_0)

								iter_425_1.color = Color.New(var_425_1, var_425_1, var_425_1)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["104701"]) and arg_422_1.var_.actorSpriteComps104701 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_425_3 then
						iter_425_3.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_422_1.var_.actorSpriteComps104701 = nil
			end

			local var_425_2 = arg_422_1.actors_["10144"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_2) and arg_422_1.var_.actorSpriteComps10144 == nil then
				arg_422_1.var_.actorSpriteComps10144 = var_425_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_3 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_3 and not isNil(var_425_2) then
				if arg_422_1.var_.actorSpriteComps10144 then
					for iter_425_4, iter_425_5 in pairs(arg_422_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_425_5 then
							if arg_422_1.isInRecall_ then
								iter_425_5.color = Color.New(Mathf.Lerp(iter_425_5.color.r, arg_422_1.hightColor2.r, (arg_422_1.time_ - 0) / var_425_3), Mathf.Lerp(iter_425_5.color.g, arg_422_1.hightColor2.g, (arg_422_1.time_ - 0) / var_425_3), (Mathf.Lerp(iter_425_5.color.b, arg_422_1.hightColor2.b, (arg_422_1.time_ - 0) / var_425_3)))
							else
								local var_425_4 = Mathf.Lerp(iter_425_5.color.r, 0.5, (arg_422_1.time_ - 0) / var_425_3)

								iter_425_5.color = Color.New(var_425_4, var_425_4, var_425_4)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_3 and arg_422_1.time_ < 0 + var_425_3 + arg_425_0 and not isNil(var_425_2) and arg_422_1.var_.actorSpriteComps10144 then
				for iter_425_6, iter_425_7 in pairs(arg_422_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_425_7 then
						iter_425_7.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_422_1.var_.actorSpriteComps10144 = nil
			end

			local var_425_5 = 0
			local var_425_6 = 0.425

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_5 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_7 = arg_422_1:GetWordFromCfg(926021104)
				local var_425_8 = arg_422_1:FormatText(var_425_7.content)

				arg_422_1.text_.text = var_425_8

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_10 = 17 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_8) / 17)

				if (17 <= 0 and var_425_6 or var_425_6 * (utf8.len(var_425_8) / 17)) > 0 and var_425_6 < var_425_10 then
					arg_422_1.talkMaxDuration = var_425_10

					if var_425_10 + var_425_5 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_10 + var_425_5
					end
				end

				arg_422_1.text_.text = var_425_8
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021104", "story_v_out_926021.awb") ~= 0 then
					local var_425_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021104", "story_v_out_926021.awb") / 1000

					if var_425_11 + var_425_5 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_11 + var_425_5
					end

					if var_425_7.prefab_name ~= "" and arg_422_1.actors_[var_425_7.prefab_name] ~= nil then
						local var_425_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_7.prefab_name].transform, "story_v_out_926021", "926021104", "story_v_out_926021.awb")

						arg_422_1:RecordAudio("926021104", var_425_12)
						arg_422_1:RecordAudio("926021104", var_425_12)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_926021", "926021104", "story_v_out_926021.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_926021", "926021104", "story_v_out_926021.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_13 = math.max(var_425_6, arg_422_1.talkMaxDuration)

			if var_425_5 <= arg_422_1.time_ and arg_422_1.time_ < var_425_5 + var_425_13 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_5) / var_425_13

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_5 + var_425_13 and arg_422_1.time_ < var_425_5 + var_425_13 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play926021105 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 926021105
		arg_426_1.duration_ = 6

		local var_426_0 = {
			zh = 5.066,
			ja = 6
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play926021106(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["10144"]) and arg_426_1.var_.actorSpriteComps10144 == nil then
				arg_426_1.var_.actorSpriteComps10144 = arg_426_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_0 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["10144"]) then
				if arg_426_1.var_.actorSpriteComps10144 then
					for iter_429_0, iter_429_1 in pairs(arg_426_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_429_1 then
							if arg_426_1.isInRecall_ then
								iter_429_1.color = Color.New(Mathf.Lerp(iter_429_1.color.r, arg_426_1.hightColor1.r, (arg_426_1.time_ - 0) / var_429_0), Mathf.Lerp(iter_429_1.color.g, arg_426_1.hightColor1.g, (arg_426_1.time_ - 0) / var_429_0), (Mathf.Lerp(iter_429_1.color.b, arg_426_1.hightColor1.b, (arg_426_1.time_ - 0) / var_429_0)))
							else
								local var_429_1 = Mathf.Lerp(iter_429_1.color.r, 1, (arg_426_1.time_ - 0) / var_429_0)

								iter_429_1.color = Color.New(var_429_1, var_429_1, var_429_1)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["10144"]) and arg_426_1.var_.actorSpriteComps10144 then
				for iter_429_2, iter_429_3 in pairs(arg_426_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_429_3 then
						iter_429_3.color = arg_426_1.isInRecall_ and (arg_426_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_426_1.var_.actorSpriteComps10144 = nil
			end

			local var_429_2 = arg_426_1.actors_["104701"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_2) and arg_426_1.var_.actorSpriteComps104701 == nil then
				arg_426_1.var_.actorSpriteComps104701 = var_429_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_429_3 = 0.2

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_3 and not isNil(var_429_2) then
				if arg_426_1.var_.actorSpriteComps104701 then
					for iter_429_4, iter_429_5 in pairs(arg_426_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_429_5 then
							if arg_426_1.isInRecall_ then
								iter_429_5.color = Color.New(Mathf.Lerp(iter_429_5.color.r, arg_426_1.hightColor2.r, (arg_426_1.time_ - 0) / var_429_3), Mathf.Lerp(iter_429_5.color.g, arg_426_1.hightColor2.g, (arg_426_1.time_ - 0) / var_429_3), (Mathf.Lerp(iter_429_5.color.b, arg_426_1.hightColor2.b, (arg_426_1.time_ - 0) / var_429_3)))
							else
								local var_429_4 = Mathf.Lerp(iter_429_5.color.r, 0.5, (arg_426_1.time_ - 0) / var_429_3)

								iter_429_5.color = Color.New(var_429_4, var_429_4, var_429_4)
							end
						end
					end
				end
			end

			if arg_426_1.time_ >= 0 + var_429_3 and arg_426_1.time_ < 0 + var_429_3 + arg_429_0 and not isNil(var_429_2) and arg_426_1.var_.actorSpriteComps104701 then
				for iter_429_6, iter_429_7 in pairs(arg_426_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_429_7 then
						iter_429_7.color = arg_426_1.isInRecall_ and (arg_426_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_426_1.var_.actorSpriteComps104701 = nil
			end

			local var_429_5 = arg_426_1.actors_["10144"].transform

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos10144 = var_429_5.localPosition
				var_429_5.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("10144", 4)

				for iter_429_8 = 0, var_429_5.childCount - 1 do
					local var_429_6 = var_429_5:GetChild(iter_429_8)

					if var_429_6.name == "split_2" or not string.find(var_429_6.name, "split") then
						var_429_6.gameObject:SetActive(true)
					else
						var_429_6.gameObject:SetActive(false)
					end
				end
			end

			local var_429_7 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				var_429_5.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos10144, Vector3.New(435.8, -381.1, -285.9), (arg_426_1.time_ - 0) / var_429_7)
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				var_429_5.localPosition = Vector3.New(435.8, -381.1, -285.9)
			end

			local var_429_8 = 0
			local var_429_9 = 0.675

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_8 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_10 = arg_426_1:GetWordFromCfg(926021105)
				local var_429_11 = arg_426_1:FormatText(var_429_10.content)

				arg_426_1.text_.text = var_429_11

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_13 = 27 <= 0 and var_429_9 or var_429_9 * (utf8.len(var_429_11) / 27)

				if (27 <= 0 and var_429_9 or var_429_9 * (utf8.len(var_429_11) / 27)) > 0 and var_429_9 < var_429_13 then
					arg_426_1.talkMaxDuration = var_429_13

					if var_429_13 + var_429_8 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_13 + var_429_8
					end
				end

				arg_426_1.text_.text = var_429_11
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021105", "story_v_out_926021.awb") ~= 0 then
					local var_429_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021105", "story_v_out_926021.awb") / 1000

					if var_429_14 + var_429_8 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_14 + var_429_8
					end

					if var_429_10.prefab_name ~= "" and arg_426_1.actors_[var_429_10.prefab_name] ~= nil then
						local var_429_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_10.prefab_name].transform, "story_v_out_926021", "926021105", "story_v_out_926021.awb")

						arg_426_1:RecordAudio("926021105", var_429_15)
						arg_426_1:RecordAudio("926021105", var_429_15)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_926021", "926021105", "story_v_out_926021.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_926021", "926021105", "story_v_out_926021.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_16 = math.max(var_429_9, arg_426_1.talkMaxDuration)

			if var_429_8 <= arg_426_1.time_ and arg_426_1.time_ < var_429_8 + var_429_16 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_8) / var_429_16

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_8 + var_429_16 and arg_426_1.time_ < var_429_8 + var_429_16 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play926021106 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 926021106
		arg_430_1.duration_ = 4.53

		local var_430_0 = {
			zh = 4.533,
			ja = 3.533
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play926021107(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["106103"]) and arg_430_1.var_.actorSpriteComps106103 == nil then
				arg_430_1.var_.actorSpriteComps106103 = arg_430_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_0 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["106103"]) then
				if arg_430_1.var_.actorSpriteComps106103 then
					for iter_433_0, iter_433_1 in pairs(arg_430_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_433_1 then
							if arg_430_1.isInRecall_ then
								iter_433_1.color = Color.New(Mathf.Lerp(iter_433_1.color.r, arg_430_1.hightColor1.r, (arg_430_1.time_ - 0) / var_433_0), Mathf.Lerp(iter_433_1.color.g, arg_430_1.hightColor1.g, (arg_430_1.time_ - 0) / var_433_0), (Mathf.Lerp(iter_433_1.color.b, arg_430_1.hightColor1.b, (arg_430_1.time_ - 0) / var_433_0)))
							else
								local var_433_1 = Mathf.Lerp(iter_433_1.color.r, 1, (arg_430_1.time_ - 0) / var_433_0)

								iter_433_1.color = Color.New(var_433_1, var_433_1, var_433_1)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["106103"]) and arg_430_1.var_.actorSpriteComps106103 then
				for iter_433_2, iter_433_3 in pairs(arg_430_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_433_3 then
						iter_433_3.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_430_1.var_.actorSpriteComps106103 = nil
			end

			local var_433_2 = arg_430_1.actors_["10144"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps10144 == nil then
				arg_430_1.var_.actorSpriteComps10144 = var_433_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_3 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_3 and not isNil(var_433_2) then
				if arg_430_1.var_.actorSpriteComps10144 then
					for iter_433_4, iter_433_5 in pairs(arg_430_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_433_5 then
							if arg_430_1.isInRecall_ then
								iter_433_5.color = Color.New(Mathf.Lerp(iter_433_5.color.r, arg_430_1.hightColor2.r, (arg_430_1.time_ - 0) / var_433_3), Mathf.Lerp(iter_433_5.color.g, arg_430_1.hightColor2.g, (arg_430_1.time_ - 0) / var_433_3), (Mathf.Lerp(iter_433_5.color.b, arg_430_1.hightColor2.b, (arg_430_1.time_ - 0) / var_433_3)))
							else
								local var_433_4 = Mathf.Lerp(iter_433_5.color.r, 0.5, (arg_430_1.time_ - 0) / var_433_3)

								iter_433_5.color = Color.New(var_433_4, var_433_4, var_433_4)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_3 and arg_430_1.time_ < 0 + var_433_3 + arg_433_0 and not isNil(var_433_2) and arg_430_1.var_.actorSpriteComps10144 then
				for iter_433_6, iter_433_7 in pairs(arg_430_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_433_7 then
						iter_433_7.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_430_1.var_.actorSpriteComps10144 = nil
			end

			local var_433_5 = arg_430_1.actors_["10144"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos10144 = var_433_5.localPosition
				var_433_5.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("10144", 7)

				for iter_433_8 = 0, var_433_5.childCount - 1 do
					local var_433_6 = var_433_5:GetChild(iter_433_8)

					if var_433_6.name == "" or not string.find(var_433_6.name, "split") then
						var_433_6.gameObject:SetActive(true)
					else
						var_433_6.gameObject:SetActive(false)
					end
				end
			end

			local var_433_7 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				var_433_5.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_430_1.time_ - 0) / var_433_7)
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				var_433_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_433_8 = arg_430_1.actors_["104701"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos104701 = var_433_8.localPosition
				var_433_8.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("104701", 7)

				for iter_433_9 = 0, var_433_8.childCount - 1 do
					local var_433_9 = var_433_8:GetChild(iter_433_9)

					if var_433_9.name == "" or not string.find(var_433_9.name, "split") then
						var_433_9.gameObject:SetActive(true)
					else
						var_433_9.gameObject:SetActive(false)
					end
				end
			end

			local var_433_10 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_10 then
				var_433_8.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_430_1.time_ - 0) / var_433_10)
			end

			if arg_430_1.time_ >= 0 + var_433_10 and arg_430_1.time_ < 0 + var_433_10 + arg_433_0 then
				var_433_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_433_11 = arg_430_1.actors_["106103"].transform

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos106103 = var_433_11.localPosition
				var_433_11.localScale = Vector3.New(1, 1, 1)

				arg_430_1:CheckSpriteTmpPos("106103", 7)

				for iter_433_10 = 0, var_433_11.childCount - 1 do
					local var_433_12 = var_433_11:GetChild(iter_433_10)

					if var_433_12.name == "split_4" or not string.find(var_433_12.name, "split") then
						var_433_12.gameObject:SetActive(true)
					else
						var_433_12.gameObject:SetActive(false)
					end
				end
			end

			local var_433_13 = 0.1

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_13 then
				var_433_11.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_430_1.time_ - 0) / var_433_13)
			end

			if arg_430_1.time_ >= 0 + var_433_13 and arg_430_1.time_ < 0 + var_433_13 + arg_433_0 then
				var_433_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_433_14 = 0
			local var_433_15 = 0.25

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_14 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0

				arg_430_1.dialog_:SetActive(true)

				arg_430_1.dialogCg_.alpha = 0

				local var_433_16 = LeanTween.value(arg_430_1.dialog_, 0, 1, 0.3)

				var_433_16:setOnUpdate(LuaHelper.FloatAction(function(arg_434_0)
					arg_430_1.dialogCg_.alpha = arg_434_0
				end))
				var_433_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_430_1.dialog_)
					var_433_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_430_1.duration_ = arg_430_1.duration_ + 0.3

				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_4")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_17 = arg_430_1:GetWordFromCfg(926021106)
				local var_433_18 = arg_430_1:FormatText(var_433_17.content)

				arg_430_1.text_.text = var_433_18

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_20 = 10 <= 0 and var_433_15 or var_433_15 * (utf8.len(var_433_18) / 10)

				if (10 <= 0 and var_433_15 or var_433_15 * (utf8.len(var_433_18) / 10)) > 0 and var_433_15 < var_433_20 then
					arg_430_1.talkMaxDuration = var_433_20
					var_433_14 = var_433_14 + 0.3

					if var_433_20 + var_433_14 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_20 + var_433_14
					end
				end

				arg_430_1.text_.text = var_433_18
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021106", "story_v_out_926021.awb") ~= 0 then
					local var_433_21 = manager.audio:GetVoiceLength("story_v_out_926021", "926021106", "story_v_out_926021.awb") / 1000

					if var_433_21 + var_433_14 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_21 + var_433_14
					end

					if var_433_17.prefab_name ~= "" and arg_430_1.actors_[var_433_17.prefab_name] ~= nil then
						local var_433_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_17.prefab_name].transform, "story_v_out_926021", "926021106", "story_v_out_926021.awb")

						arg_430_1:RecordAudio("926021106", var_433_22)
						arg_430_1:RecordAudio("926021106", var_433_22)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_926021", "926021106", "story_v_out_926021.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_926021", "926021106", "story_v_out_926021.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_23 = var_433_14 + 0.3
			local var_433_24 = math.max(var_433_15, arg_430_1.talkMaxDuration)

			if var_433_14 + 0.3 <= arg_430_1.time_ and arg_430_1.time_ < var_433_23 + var_433_24 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_23) / var_433_24

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_23 + var_433_24 and arg_430_1.time_ < var_433_23 + var_433_24 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play926021107 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 926021107
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play926021108(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0.166666666666667 < arg_436_1.time_ and arg_436_1.time_ <= 0.166666666666667 + arg_439_0 then
				arg_436_1:AudioAction("play", "effect", "se_story_143", "se_story_143_walk01", "")
			end

			local var_439_1 = 0
			local var_439_2 = 1.45

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_3 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(926021107).content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 58 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 58)

				if (58 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 58)) > 0 and var_439_2 < var_439_5 then
					arg_436_1.talkMaxDuration = var_439_5

					if var_439_5 + var_439_1 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + var_439_1
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_6 = math.max(var_439_2, arg_436_1.talkMaxDuration)

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_6 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_1) / var_439_6

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_1 + var_439_6 and arg_436_1.time_ < var_439_1 + var_439_6 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play926021108 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 926021108
		arg_440_1.duration_ = 5.63

		local var_440_0 = {
			zh = 3.433,
			ja = 5.633
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play926021109(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["10144"]) and arg_440_1.var_.actorSpriteComps10144 == nil then
				arg_440_1.var_.actorSpriteComps10144 = arg_440_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_0 = 0.2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["10144"]) then
				if arg_440_1.var_.actorSpriteComps10144 then
					for iter_443_0, iter_443_1 in pairs(arg_440_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_443_1 then
							if arg_440_1.isInRecall_ then
								iter_443_1.color = Color.New(Mathf.Lerp(iter_443_1.color.r, arg_440_1.hightColor1.r, (arg_440_1.time_ - 0) / var_443_0), Mathf.Lerp(iter_443_1.color.g, arg_440_1.hightColor1.g, (arg_440_1.time_ - 0) / var_443_0), (Mathf.Lerp(iter_443_1.color.b, arg_440_1.hightColor1.b, (arg_440_1.time_ - 0) / var_443_0)))
							else
								local var_443_1 = Mathf.Lerp(iter_443_1.color.r, 1, (arg_440_1.time_ - 0) / var_443_0)

								iter_443_1.color = Color.New(var_443_1, var_443_1, var_443_1)
							end
						end
					end
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["10144"]) and arg_440_1.var_.actorSpriteComps10144 then
				for iter_443_2, iter_443_3 in pairs(arg_440_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_443_3 then
						iter_443_3.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_440_1.var_.actorSpriteComps10144 = nil
			end

			local var_443_2 = arg_440_1.actors_["10144"].transform

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10144 = var_443_2.localPosition
				var_443_2.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10144", 2)

				for iter_443_4 = 0, var_443_2.childCount - 1 do
					local var_443_3 = var_443_2:GetChild(iter_443_4)

					if var_443_3.name == "" or not string.find(var_443_3.name, "split") then
						var_443_3.gameObject:SetActive(true)
					else
						var_443_3.gameObject:SetActive(false)
					end
				end
			end

			local var_443_4 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				var_443_2.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_440_1.time_ - 0) / var_443_4)
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				var_443_2.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_443_5 = 0
			local var_443_6 = 0.475

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_5 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_7 = arg_440_1:GetWordFromCfg(926021108)
				local var_443_8 = arg_440_1:FormatText(var_443_7.content)

				arg_440_1.text_.text = var_443_8

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_10 = 19 <= 0 and var_443_6 or var_443_6 * (utf8.len(var_443_8) / 19)

				if (19 <= 0 and var_443_6 or var_443_6 * (utf8.len(var_443_8) / 19)) > 0 and var_443_6 < var_443_10 then
					arg_440_1.talkMaxDuration = var_443_10

					if var_443_10 + var_443_5 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_10 + var_443_5
					end
				end

				arg_440_1.text_.text = var_443_8
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021108", "story_v_out_926021.awb") ~= 0 then
					local var_443_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021108", "story_v_out_926021.awb") / 1000

					if var_443_11 + var_443_5 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_5
					end

					if var_443_7.prefab_name ~= "" and arg_440_1.actors_[var_443_7.prefab_name] ~= nil then
						local var_443_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_7.prefab_name].transform, "story_v_out_926021", "926021108", "story_v_out_926021.awb")

						arg_440_1:RecordAudio("926021108", var_443_12)
						arg_440_1:RecordAudio("926021108", var_443_12)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_926021", "926021108", "story_v_out_926021.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_926021", "926021108", "story_v_out_926021.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_13 = math.max(var_443_6, arg_440_1.talkMaxDuration)

			if var_443_5 <= arg_440_1.time_ and arg_440_1.time_ < var_443_5 + var_443_13 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_5) / var_443_13

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_5 + var_443_13 and arg_440_1.time_ < var_443_5 + var_443_13 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play926021109 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 926021109
		arg_444_1.duration_ = 5.97

		local var_444_0 = {
			zh = 5.066,
			ja = 5.966
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play926021110(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["104701"]) and arg_444_1.var_.actorSpriteComps104701 == nil then
				arg_444_1.var_.actorSpriteComps104701 = arg_444_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_0 = 0.2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["104701"]) then
				if arg_444_1.var_.actorSpriteComps104701 then
					for iter_447_0, iter_447_1 in pairs(arg_444_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_447_1 then
							if arg_444_1.isInRecall_ then
								iter_447_1.color = Color.New(Mathf.Lerp(iter_447_1.color.r, arg_444_1.hightColor1.r, (arg_444_1.time_ - 0) / var_447_0), Mathf.Lerp(iter_447_1.color.g, arg_444_1.hightColor1.g, (arg_444_1.time_ - 0) / var_447_0), (Mathf.Lerp(iter_447_1.color.b, arg_444_1.hightColor1.b, (arg_444_1.time_ - 0) / var_447_0)))
							else
								local var_447_1 = Mathf.Lerp(iter_447_1.color.r, 1, (arg_444_1.time_ - 0) / var_447_0)

								iter_447_1.color = Color.New(var_447_1, var_447_1, var_447_1)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["104701"]) and arg_444_1.var_.actorSpriteComps104701 then
				for iter_447_2, iter_447_3 in pairs(arg_444_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_447_3 then
						iter_447_3.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_444_1.var_.actorSpriteComps104701 = nil
			end

			local var_447_2 = arg_444_1.actors_["10144"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10144 == nil then
				arg_444_1.var_.actorSpriteComps10144 = var_447_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_3 = 0.2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_3 and not isNil(var_447_2) then
				if arg_444_1.var_.actorSpriteComps10144 then
					for iter_447_4, iter_447_5 in pairs(arg_444_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_447_5 then
							if arg_444_1.isInRecall_ then
								iter_447_5.color = Color.New(Mathf.Lerp(iter_447_5.color.r, arg_444_1.hightColor2.r, (arg_444_1.time_ - 0) / var_447_3), Mathf.Lerp(iter_447_5.color.g, arg_444_1.hightColor2.g, (arg_444_1.time_ - 0) / var_447_3), (Mathf.Lerp(iter_447_5.color.b, arg_444_1.hightColor2.b, (arg_444_1.time_ - 0) / var_447_3)))
							else
								local var_447_4 = Mathf.Lerp(iter_447_5.color.r, 0.5, (arg_444_1.time_ - 0) / var_447_3)

								iter_447_5.color = Color.New(var_447_4, var_447_4, var_447_4)
							end
						end
					end
				end
			end

			if arg_444_1.time_ >= 0 + var_447_3 and arg_444_1.time_ < 0 + var_447_3 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10144 then
				for iter_447_6, iter_447_7 in pairs(arg_444_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_447_7 then
						iter_447_7.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_444_1.var_.actorSpriteComps10144 = nil
			end

			local var_447_5 = arg_444_1.actors_["104701"].transform

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos104701 = var_447_5.localPosition
				var_447_5.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("104701", 4)

				for iter_447_8 = 0, var_447_5.childCount - 1 do
					local var_447_6 = var_447_5:GetChild(iter_447_8)

					if var_447_6.name == "" or not string.find(var_447_6.name, "split") then
						var_447_6.gameObject:SetActive(true)
					else
						var_447_6.gameObject:SetActive(false)
					end
				end
			end

			local var_447_7 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_7 then
				var_447_5.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_444_1.time_ - 0) / var_447_7)
			end

			if arg_444_1.time_ >= 0 + var_447_7 and arg_444_1.time_ < 0 + var_447_7 + arg_447_0 then
				var_447_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_447_8 = 0
			local var_447_9 = 0.575

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_8 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_10 = arg_444_1:GetWordFromCfg(926021109)
				local var_447_11 = arg_444_1:FormatText(var_447_10.content)

				arg_444_1.text_.text = var_447_11

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_13 = 23 <= 0 and var_447_9 or var_447_9 * (utf8.len(var_447_11) / 23)

				if (23 <= 0 and var_447_9 or var_447_9 * (utf8.len(var_447_11) / 23)) > 0 and var_447_9 < var_447_13 then
					arg_444_1.talkMaxDuration = var_447_13

					if var_447_13 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_13 + var_447_8
					end
				end

				arg_444_1.text_.text = var_447_11
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021109", "story_v_out_926021.awb") ~= 0 then
					local var_447_14 = manager.audio:GetVoiceLength("story_v_out_926021", "926021109", "story_v_out_926021.awb") / 1000

					if var_447_14 + var_447_8 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_14 + var_447_8
					end

					if var_447_10.prefab_name ~= "" and arg_444_1.actors_[var_447_10.prefab_name] ~= nil then
						local var_447_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_10.prefab_name].transform, "story_v_out_926021", "926021109", "story_v_out_926021.awb")

						arg_444_1:RecordAudio("926021109", var_447_15)
						arg_444_1:RecordAudio("926021109", var_447_15)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_926021", "926021109", "story_v_out_926021.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_926021", "926021109", "story_v_out_926021.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_16 = math.max(var_447_9, arg_444_1.talkMaxDuration)

			if var_447_8 <= arg_444_1.time_ and arg_444_1.time_ < var_447_8 + var_447_16 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_8) / var_447_16

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_8 + var_447_16 and arg_444_1.time_ < var_447_8 + var_447_16 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play926021110 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 926021110
		arg_448_1.duration_ = 6.07

		local var_448_0 = {
			zh = 6.066,
			ja = 5.733
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play926021111(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["106103"]) and arg_448_1.var_.actorSpriteComps106103 == nil then
				arg_448_1.var_.actorSpriteComps106103 = arg_448_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_0 = 0.2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["106103"]) then
				if arg_448_1.var_.actorSpriteComps106103 then
					for iter_451_0, iter_451_1 in pairs(arg_448_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_451_1 then
							if arg_448_1.isInRecall_ then
								iter_451_1.color = Color.New(Mathf.Lerp(iter_451_1.color.r, arg_448_1.hightColor1.r, (arg_448_1.time_ - 0) / var_451_0), Mathf.Lerp(iter_451_1.color.g, arg_448_1.hightColor1.g, (arg_448_1.time_ - 0) / var_451_0), (Mathf.Lerp(iter_451_1.color.b, arg_448_1.hightColor1.b, (arg_448_1.time_ - 0) / var_451_0)))
							else
								local var_451_1 = Mathf.Lerp(iter_451_1.color.r, 1, (arg_448_1.time_ - 0) / var_451_0)

								iter_451_1.color = Color.New(var_451_1, var_451_1, var_451_1)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["106103"]) and arg_448_1.var_.actorSpriteComps106103 then
				for iter_451_2, iter_451_3 in pairs(arg_448_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_451_3 then
						iter_451_3.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_448_1.var_.actorSpriteComps106103 = nil
			end

			local var_451_2 = arg_448_1.actors_["104701"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps104701 == nil then
				arg_448_1.var_.actorSpriteComps104701 = var_451_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_3 = 0.2

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_3 and not isNil(var_451_2) then
				if arg_448_1.var_.actorSpriteComps104701 then
					for iter_451_4, iter_451_5 in pairs(arg_448_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_451_5 then
							if arg_448_1.isInRecall_ then
								iter_451_5.color = Color.New(Mathf.Lerp(iter_451_5.color.r, arg_448_1.hightColor2.r, (arg_448_1.time_ - 0) / var_451_3), Mathf.Lerp(iter_451_5.color.g, arg_448_1.hightColor2.g, (arg_448_1.time_ - 0) / var_451_3), (Mathf.Lerp(iter_451_5.color.b, arg_448_1.hightColor2.b, (arg_448_1.time_ - 0) / var_451_3)))
							else
								local var_451_4 = Mathf.Lerp(iter_451_5.color.r, 0.5, (arg_448_1.time_ - 0) / var_451_3)

								iter_451_5.color = Color.New(var_451_4, var_451_4, var_451_4)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 0 + var_451_3 and arg_448_1.time_ < 0 + var_451_3 + arg_451_0 and not isNil(var_451_2) and arg_448_1.var_.actorSpriteComps104701 then
				for iter_451_6, iter_451_7 in pairs(arg_448_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_451_7 then
						iter_451_7.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_448_1.var_.actorSpriteComps104701 = nil
			end

			local var_451_5 = arg_448_1.actors_["10144"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos10144 = var_451_5.localPosition
				var_451_5.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10144", 7)

				for iter_451_8 = 0, var_451_5.childCount - 1 do
					local var_451_6 = var_451_5:GetChild(iter_451_8)

					if var_451_6.name == "" or not string.find(var_451_6.name, "split") then
						var_451_6.gameObject:SetActive(true)
					else
						var_451_6.gameObject:SetActive(false)
					end
				end
			end

			local var_451_7 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				var_451_5.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_448_1.time_ - 0) / var_451_7)
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				var_451_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_451_8 = arg_448_1.actors_["104701"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos104701 = var_451_8.localPosition
				var_451_8.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("104701", 7)

				for iter_451_9 = 0, var_451_8.childCount - 1 do
					local var_451_9 = var_451_8:GetChild(iter_451_9)

					if var_451_9.name == "" or not string.find(var_451_9.name, "split") then
						var_451_9.gameObject:SetActive(true)
					else
						var_451_9.gameObject:SetActive(false)
					end
				end
			end

			local var_451_10 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_10 then
				var_451_8.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_448_1.time_ - 0) / var_451_10)
			end

			if arg_448_1.time_ >= 0 + var_451_10 and arg_448_1.time_ < 0 + var_451_10 + arg_451_0 then
				var_451_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_451_11 = arg_448_1.actors_["106103"].transform

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos106103 = var_451_11.localPosition
				var_451_11.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("106103", 3)

				for iter_451_10 = 0, var_451_11.childCount - 1 do
					local var_451_12 = var_451_11:GetChild(iter_451_10)

					if var_451_12.name == "split_4" or not string.find(var_451_12.name, "split") then
						var_451_12.gameObject:SetActive(true)
					else
						var_451_12.gameObject:SetActive(false)
					end
				end
			end

			local var_451_13 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_13 then
				var_451_11.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_448_1.time_ - 0) / var_451_13)
			end

			if arg_448_1.time_ >= 0 + var_451_13 and arg_448_1.time_ < 0 + var_451_13 + arg_451_0 then
				var_451_11.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_451_14 = 0
			local var_451_15 = 0.475

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_14 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_16 = arg_448_1:GetWordFromCfg(926021110)
				local var_451_17 = arg_448_1:FormatText(var_451_16.content)

				arg_448_1.text_.text = var_451_17

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_19 = 19 <= 0 and var_451_15 or var_451_15 * (utf8.len(var_451_17) / 19)

				if (19 <= 0 and var_451_15 or var_451_15 * (utf8.len(var_451_17) / 19)) > 0 and var_451_15 < var_451_19 then
					arg_448_1.talkMaxDuration = var_451_19

					if var_451_19 + var_451_14 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_19 + var_451_14
					end
				end

				arg_448_1.text_.text = var_451_17
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021110", "story_v_out_926021.awb") ~= 0 then
					local var_451_20 = manager.audio:GetVoiceLength("story_v_out_926021", "926021110", "story_v_out_926021.awb") / 1000

					if var_451_20 + var_451_14 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_20 + var_451_14
					end

					if var_451_16.prefab_name ~= "" and arg_448_1.actors_[var_451_16.prefab_name] ~= nil then
						local var_451_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_16.prefab_name].transform, "story_v_out_926021", "926021110", "story_v_out_926021.awb")

						arg_448_1:RecordAudio("926021110", var_451_21)
						arg_448_1:RecordAudio("926021110", var_451_21)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_926021", "926021110", "story_v_out_926021.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_926021", "926021110", "story_v_out_926021.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_22 = math.max(var_451_15, arg_448_1.talkMaxDuration)

			if var_451_14 <= arg_448_1.time_ and arg_448_1.time_ < var_451_14 + var_451_22 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_14) / var_451_22

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_14 + var_451_22 and arg_448_1.time_ < var_451_14 + var_451_22 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play926021111 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 926021111
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play926021112(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["106103"]) and arg_452_1.var_.actorSpriteComps106103 == nil then
				arg_452_1.var_.actorSpriteComps106103 = arg_452_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_455_0 = 0.2

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["106103"]) then
				if arg_452_1.var_.actorSpriteComps106103 then
					for iter_455_0, iter_455_1 in pairs(arg_452_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_455_1 then
							if arg_452_1.isInRecall_ then
								iter_455_1.color = Color.New(Mathf.Lerp(iter_455_1.color.r, arg_452_1.hightColor2.r, (arg_452_1.time_ - 0) / var_455_0), Mathf.Lerp(iter_455_1.color.g, arg_452_1.hightColor2.g, (arg_452_1.time_ - 0) / var_455_0), (Mathf.Lerp(iter_455_1.color.b, arg_452_1.hightColor2.b, (arg_452_1.time_ - 0) / var_455_0)))
							else
								local var_455_1 = Mathf.Lerp(iter_455_1.color.r, 0.5, (arg_452_1.time_ - 0) / var_455_0)

								iter_455_1.color = Color.New(var_455_1, var_455_1, var_455_1)
							end
						end
					end
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["106103"]) and arg_452_1.var_.actorSpriteComps106103 then
				for iter_455_2, iter_455_3 in pairs(arg_452_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_455_3 then
						iter_455_3.color = arg_452_1.isInRecall_ and (arg_452_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_452_1.var_.actorSpriteComps106103 = nil
			end

			local var_455_2 = 0
			local var_455_3 = 0.825

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_2 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_4 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(926021111).content)

				arg_452_1.text_.text = var_455_4

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_6 = 33 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_4) / 33)

				if (33 <= 0 and var_455_3 or var_455_3 * (utf8.len(var_455_4) / 33)) > 0 and var_455_3 < var_455_6 then
					arg_452_1.talkMaxDuration = var_455_6

					if var_455_6 + var_455_2 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_6 + var_455_2
					end
				end

				arg_452_1.text_.text = var_455_4
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_3, arg_452_1.talkMaxDuration)

			if var_455_2 <= arg_452_1.time_ and arg_452_1.time_ < var_455_2 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_2) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_2 + var_455_7 and arg_452_1.time_ < var_455_2 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play926021112 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 926021112
		arg_456_1.duration_ = 3.87

		local var_456_0 = {
			zh = 3.866,
			ja = 3.6
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play926021113(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["106103"]) and arg_456_1.var_.actorSpriteComps106103 == nil then
				arg_456_1.var_.actorSpriteComps106103 = arg_456_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_0 = 0.2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["106103"]) then
				if arg_456_1.var_.actorSpriteComps106103 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_459_1 then
							if arg_456_1.isInRecall_ then
								iter_459_1.color = Color.New(Mathf.Lerp(iter_459_1.color.r, arg_456_1.hightColor1.r, (arg_456_1.time_ - 0) / var_459_0), Mathf.Lerp(iter_459_1.color.g, arg_456_1.hightColor1.g, (arg_456_1.time_ - 0) / var_459_0), (Mathf.Lerp(iter_459_1.color.b, arg_456_1.hightColor1.b, (arg_456_1.time_ - 0) / var_459_0)))
							else
								local var_459_1 = Mathf.Lerp(iter_459_1.color.r, 1, (arg_456_1.time_ - 0) / var_459_0)

								iter_459_1.color = Color.New(var_459_1, var_459_1, var_459_1)
							end
						end
					end
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["106103"]) and arg_456_1.var_.actorSpriteComps106103 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_459_3 then
						iter_459_3.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_456_1.var_.actorSpriteComps106103 = nil
			end

			local var_459_2 = 0
			local var_459_3 = 0.3

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_2 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_4 = arg_456_1:GetWordFromCfg(926021112)
				local var_459_5 = arg_456_1:FormatText(var_459_4.content)

				arg_456_1.text_.text = var_459_5

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_7 = 12 <= 0 and var_459_3 or var_459_3 * (utf8.len(var_459_5) / 12)

				if (12 <= 0 and var_459_3 or var_459_3 * (utf8.len(var_459_5) / 12)) > 0 and var_459_3 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_2 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_2
					end
				end

				arg_456_1.text_.text = var_459_5
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021112", "story_v_out_926021.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021112", "story_v_out_926021.awb") / 1000

					if var_459_8 + var_459_2 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_2
					end

					if var_459_4.prefab_name ~= "" and arg_456_1.actors_[var_459_4.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_4.prefab_name].transform, "story_v_out_926021", "926021112", "story_v_out_926021.awb")

						arg_456_1:RecordAudio("926021112", var_459_9)
						arg_456_1:RecordAudio("926021112", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_926021", "926021112", "story_v_out_926021.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_926021", "926021112", "story_v_out_926021.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_3, arg_456_1.talkMaxDuration)

			if var_459_2 <= arg_456_1.time_ and arg_456_1.time_ < var_459_2 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_2) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_2 + var_459_10 and arg_456_1.time_ < var_459_2 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play926021113 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 926021113
		arg_460_1.duration_ = 5.13

		local var_460_0 = {
			zh = 4.033,
			ja = 5.133
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play926021114(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["10144"]) and arg_460_1.var_.actorSpriteComps10144 == nil then
				arg_460_1.var_.actorSpriteComps10144 = arg_460_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_0 = 0.2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["10144"]) then
				if arg_460_1.var_.actorSpriteComps10144 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								iter_463_1.color = Color.New(Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor1.r, (arg_460_1.time_ - 0) / var_463_0), Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor1.g, (arg_460_1.time_ - 0) / var_463_0), (Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor1.b, (arg_460_1.time_ - 0) / var_463_0)))
							else
								local var_463_1 = Mathf.Lerp(iter_463_1.color.r, 1, (arg_460_1.time_ - 0) / var_463_0)

								iter_463_1.color = Color.New(var_463_1, var_463_1, var_463_1)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["10144"]) and arg_460_1.var_.actorSpriteComps10144 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_463_3 then
						iter_463_3.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_460_1.var_.actorSpriteComps10144 = nil
			end

			local var_463_2 = arg_460_1.actors_["106103"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_2) and arg_460_1.var_.actorSpriteComps106103 == nil then
				arg_460_1.var_.actorSpriteComps106103 = var_463_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_3 = 0.2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_3 and not isNil(var_463_2) then
				if arg_460_1.var_.actorSpriteComps106103 then
					for iter_463_4, iter_463_5 in pairs(arg_460_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_463_5 then
							if arg_460_1.isInRecall_ then
								iter_463_5.color = Color.New(Mathf.Lerp(iter_463_5.color.r, arg_460_1.hightColor2.r, (arg_460_1.time_ - 0) / var_463_3), Mathf.Lerp(iter_463_5.color.g, arg_460_1.hightColor2.g, (arg_460_1.time_ - 0) / var_463_3), (Mathf.Lerp(iter_463_5.color.b, arg_460_1.hightColor2.b, (arg_460_1.time_ - 0) / var_463_3)))
							else
								local var_463_4 = Mathf.Lerp(iter_463_5.color.r, 0.5, (arg_460_1.time_ - 0) / var_463_3)

								iter_463_5.color = Color.New(var_463_4, var_463_4, var_463_4)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_3 and arg_460_1.time_ < 0 + var_463_3 + arg_463_0 and not isNil(var_463_2) and arg_460_1.var_.actorSpriteComps106103 then
				for iter_463_6, iter_463_7 in pairs(arg_460_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_463_7 then
						iter_463_7.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_460_1.var_.actorSpriteComps106103 = nil
			end

			local var_463_5 = arg_460_1.actors_["10144"].transform

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos10144 = var_463_5.localPosition
				var_463_5.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("10144", 3)

				for iter_463_8 = 0, var_463_5.childCount - 1 do
					local var_463_6 = var_463_5:GetChild(iter_463_8)

					if var_463_6.name == "split_1" or not string.find(var_463_6.name, "split") then
						var_463_6.gameObject:SetActive(true)
					else
						var_463_6.gameObject:SetActive(false)
					end
				end
			end

			local var_463_7 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_7 then
				var_463_5.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_460_1.time_ - 0) / var_463_7)
			end

			if arg_460_1.time_ >= 0 + var_463_7 and arg_460_1.time_ < 0 + var_463_7 + arg_463_0 then
				var_463_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_463_8 = arg_460_1.actors_["106103"].transform

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos106103 = var_463_8.localPosition
				var_463_8.localScale = Vector3.New(1, 1, 1)

				arg_460_1:CheckSpriteTmpPos("106103", 7)

				for iter_463_9 = 0, var_463_8.childCount - 1 do
					local var_463_9 = var_463_8:GetChild(iter_463_9)

					if var_463_9.name == "split_2" or not string.find(var_463_9.name, "split") then
						var_463_9.gameObject:SetActive(true)
					else
						var_463_9.gameObject:SetActive(false)
					end
				end
			end

			local var_463_10 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_10 then
				var_463_8.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_460_1.time_ - 0) / var_463_10)
			end

			if arg_460_1.time_ >= 0 + var_463_10 and arg_460_1.time_ < 0 + var_463_10 + arg_463_0 then
				var_463_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_463_11 = 0
			local var_463_12 = 0.45

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_11 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_13 = arg_460_1:GetWordFromCfg(926021113)
				local var_463_14 = arg_460_1:FormatText(var_463_13.content)

				arg_460_1.text_.text = var_463_14

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_16 = 18 <= 0 and var_463_12 or var_463_12 * (utf8.len(var_463_14) / 18)

				if (18 <= 0 and var_463_12 or var_463_12 * (utf8.len(var_463_14) / 18)) > 0 and var_463_12 < var_463_16 then
					arg_460_1.talkMaxDuration = var_463_16

					if var_463_16 + var_463_11 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_16 + var_463_11
					end
				end

				arg_460_1.text_.text = var_463_14
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021113", "story_v_out_926021.awb") ~= 0 then
					local var_463_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021113", "story_v_out_926021.awb") / 1000

					if var_463_17 + var_463_11 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_17 + var_463_11
					end

					if var_463_13.prefab_name ~= "" and arg_460_1.actors_[var_463_13.prefab_name] ~= nil then
						local var_463_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_13.prefab_name].transform, "story_v_out_926021", "926021113", "story_v_out_926021.awb")

						arg_460_1:RecordAudio("926021113", var_463_18)
						arg_460_1:RecordAudio("926021113", var_463_18)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_926021", "926021113", "story_v_out_926021.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_926021", "926021113", "story_v_out_926021.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_19 = math.max(var_463_12, arg_460_1.talkMaxDuration)

			if var_463_11 <= arg_460_1.time_ and arg_460_1.time_ < var_463_11 + var_463_19 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_11) / var_463_19

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_11 + var_463_19 and arg_460_1.time_ < var_463_11 + var_463_19 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play926021114 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 926021114
		arg_464_1.duration_ = 8.85

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play926021115(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if arg_464_1.bgs_.ST0114 == nil then
				local var_467_0 = Object.Instantiate(arg_464_1.paintGo_)

				var_467_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0114")
				var_467_0.name = "ST0114"
				var_467_0.transform.parent = arg_464_1.stage_.transform
				var_467_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_464_1.bgs_.ST0114 = var_467_0
			end

			if 1.56666666666667 < arg_464_1.time_ and arg_464_1.time_ <= 1.56666666666667 + arg_467_0 then
				local var_467_1 = arg_464_1.bgs_.ST0114

				arg_464_1.bgs_.ST0114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_467_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_467_2 = var_467_1:GetComponent("SpriteRenderer")

				if var_467_2 and var_467_2.sprite then
					local var_467_3 = 2 * (var_467_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_467_1.transform.localScale = Vector3.New(var_467_3 / var_467_2.sprite.bounds.size.y < var_467_3 * manager.ui.mainCameraCom_.aspect / var_467_2.sprite.bounds.size.x and var_467_3 * manager.ui.mainCameraCom_.aspect / var_467_2.sprite.bounds.size.x or var_467_3 / var_467_2.sprite.bounds.size.y, var_467_3 / var_467_2.sprite.bounds.size.y < var_467_3 * manager.ui.mainCameraCom_.aspect / var_467_2.sprite.bounds.size.x and var_467_3 * manager.ui.mainCameraCom_.aspect / var_467_2.sprite.bounds.size.x or var_467_3 / var_467_2.sprite.bounds.size.y, 0)
				end

				for iter_467_0, iter_467_1 in pairs(arg_464_1.bgs_) do
					if iter_467_0 ~= "ST0114" then
						iter_467_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_467_4 = 1.56666666666667

			if 1.56666666666667 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1.allBtn_.enabled = false
			end

			if arg_464_1.time_ >= var_467_4 + 0.3 and arg_464_1.time_ < var_467_4 + 0.3 + arg_467_0 then
				arg_464_1.allBtn_.enabled = true
			end

			local var_467_5 = 0

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_5 + arg_467_0 then
				arg_464_1.mask_.enabled = true
				arg_464_1.mask_.raycastTarget = true

				arg_464_1:SetGaussion(false)
			end

			local var_467_6 = 1.56666666666667

			if var_467_5 <= arg_464_1.time_ and arg_464_1.time_ < var_467_5 + var_467_6 then
				local var_467_7 = Color.New(0, 0, 0)

				var_467_7.a = Mathf.Lerp(0, 1, (arg_464_1.time_ - var_467_5) / var_467_6)
				arg_464_1.mask_.color = var_467_7
			end

			if arg_464_1.time_ >= var_467_5 + var_467_6 and arg_464_1.time_ < var_467_5 + var_467_6 + arg_467_0 then
				local var_467_8 = Color.New(0, 0, 0)

				var_467_8.a = 1
				arg_464_1.mask_.color = var_467_8
			end

			local var_467_9 = 1.56666666666667

			if 1.56666666666667 < arg_464_1.time_ and arg_464_1.time_ <= var_467_9 + arg_467_0 then
				arg_464_1.mask_.enabled = true
				arg_464_1.mask_.raycastTarget = true

				arg_464_1:SetGaussion(false)
			end

			local var_467_10 = 2.28333333333333

			if var_467_9 <= arg_464_1.time_ and arg_464_1.time_ < var_467_9 + var_467_10 then
				local var_467_11 = Color.New(0, 0, 0)

				var_467_11.a = Mathf.Lerp(1, 0, (arg_464_1.time_ - var_467_9) / var_467_10)
				arg_464_1.mask_.color = var_467_11
			end

			if arg_464_1.time_ >= var_467_9 + var_467_10 and arg_464_1.time_ < var_467_9 + var_467_10 + arg_467_0 then
				local var_467_12 = Color.New(0, 0, 0)

				arg_464_1.mask_.enabled = false
				var_467_12.a = 0
				arg_464_1.mask_.color = var_467_12
			end

			local var_467_13 = arg_464_1.actors_["10144"]

			if 1.56666666666667 < arg_464_1.time_ and arg_464_1.time_ <= 1.56666666666667 + arg_467_0 and not isNil(var_467_13) and arg_464_1.var_.actorSpriteComps10144 == nil then
				arg_464_1.var_.actorSpriteComps10144 = var_467_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_14 = 0.2

			if 1.56666666666667 <= arg_464_1.time_ and arg_464_1.time_ < 1.56666666666667 + var_467_14 and not isNil(var_467_13) then
				if arg_464_1.var_.actorSpriteComps10144 then
					for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_467_3 then
							if arg_464_1.isInRecall_ then
								iter_467_3.color = Color.New(Mathf.Lerp(iter_467_3.color.r, arg_464_1.hightColor2.r, (arg_464_1.time_ - 1.56666666666667) / var_467_14), Mathf.Lerp(iter_467_3.color.g, arg_464_1.hightColor2.g, (arg_464_1.time_ - 1.56666666666667) / var_467_14), (Mathf.Lerp(iter_467_3.color.b, arg_464_1.hightColor2.b, (arg_464_1.time_ - 1.56666666666667) / var_467_14)))
							else
								local var_467_15 = Mathf.Lerp(iter_467_3.color.r, 0.5, (arg_464_1.time_ - 1.56666666666667) / var_467_14)

								iter_467_3.color = Color.New(var_467_15, var_467_15, var_467_15)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 1.56666666666667 + var_467_14 and arg_464_1.time_ < 1.56666666666667 + var_467_14 + arg_467_0 and not isNil(var_467_13) and arg_464_1.var_.actorSpriteComps10144 then
				for iter_467_4, iter_467_5 in pairs(arg_464_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_467_5 then
						iter_467_5.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_464_1.var_.actorSpriteComps10144 = nil
			end

			local var_467_16 = arg_464_1.actors_["10144"].transform

			if 1.56666666666667 < arg_464_1.time_ and arg_464_1.time_ <= 1.56666666666667 + arg_467_0 then
				arg_464_1.var_.moveOldPos10144 = var_467_16.localPosition
				var_467_16.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("10144", 7)

				for iter_467_6 = 0, var_467_16.childCount - 1 do
					local var_467_17 = var_467_16:GetChild(iter_467_6)

					if var_467_17.name == "" or not string.find(var_467_17.name, "split") then
						var_467_17.gameObject:SetActive(true)
					else
						var_467_17.gameObject:SetActive(false)
					end
				end
			end

			local var_467_18 = 0.001

			if 1.56666666666667 <= arg_464_1.time_ and arg_464_1.time_ < 1.56666666666667 + var_467_18 then
				var_467_16.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_464_1.time_ - 1.56666666666667) / var_467_18)
			end

			if arg_464_1.time_ >= 1.56666666666667 + var_467_18 and arg_464_1.time_ < 1.56666666666667 + var_467_18 + arg_467_0 then
				var_467_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_467_19 = arg_464_1.actors_["106103"].transform

			if 1.56666666666667 < arg_464_1.time_ and arg_464_1.time_ <= 1.56666666666667 + arg_467_0 then
				arg_464_1.var_.moveOldPos106103 = var_467_19.localPosition
				var_467_19.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("106103", 7)

				for iter_467_7 = 0, var_467_19.childCount - 1 do
					local var_467_20 = var_467_19:GetChild(iter_467_7)

					if var_467_20.name == "" or not string.find(var_467_20.name, "split") then
						var_467_20.gameObject:SetActive(true)
					else
						var_467_20.gameObject:SetActive(false)
					end
				end
			end

			local var_467_21 = 0.001

			if 1.56666666666667 <= arg_464_1.time_ and arg_464_1.time_ < 1.56666666666667 + var_467_21 then
				var_467_19.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_464_1.time_ - 1.56666666666667) / var_467_21)
			end

			if arg_464_1.time_ >= 1.56666666666667 + var_467_21 and arg_464_1.time_ < 1.56666666666667 + var_467_21 + arg_467_0 then
				var_467_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_467_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_464_1.bgmTxt_.text ~= var_467_24 and arg_464_1.bgmTxt_.text ~= "" then
						if arg_464_1.bgmTxt2_.text ~= "" then
							arg_464_1.bgmTxt_.text = arg_464_1.bgmTxt2_.text
						end

						arg_464_1.bgmTxt2_.text = var_467_24

						arg_464_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_464_1.bgmTxt_.text = var_467_24
						arg_464_1.bgmTxt2_.text = var_467_24
					end

					if arg_464_1.bgmTimer then
						arg_464_1.bgmTimer:Stop()

						arg_464_1.bgmTimer = nil
					end

					if arg_464_1.settingData.show_music_name == 1 then
						arg_464_1.musicController:SetSelectedState("show")
						arg_464_1.musicAnimator_:Play("open", 0, 0)

						if arg_464_1.settingData.music_time ~= 0 then
							arg_464_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_464_1.settingData.music_time), function()
								if arg_464_1 == nil or isNil(arg_464_1.bgmTxt_) then
									return
								end

								arg_464_1.musicController:SetSelectedState("hide")
								arg_464_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.60066666666667 < arg_464_1.time_ and arg_464_1.time_ <= 1.60066666666667 + arg_467_0 then
				arg_464_1:AudioAction("play", "music", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_467_27 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if "" ~= "" then
					if arg_464_1.bgmTxt_.text ~= var_467_27 and arg_464_1.bgmTxt_.text ~= "" then
						if arg_464_1.bgmTxt2_.text ~= "" then
							arg_464_1.bgmTxt_.text = arg_464_1.bgmTxt2_.text
						end

						arg_464_1.bgmTxt2_.text = var_467_27

						arg_464_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_464_1.bgmTxt_.text = var_467_27
						arg_464_1.bgmTxt2_.text = var_467_27
					end

					if arg_464_1.bgmTimer then
						arg_464_1.bgmTimer:Stop()

						arg_464_1.bgmTimer = nil
					end

					if arg_464_1.settingData.show_music_name == 1 then
						arg_464_1.musicController:SetSelectedState("show")
						arg_464_1.musicAnimator_:Play("open", 0, 0)

						if arg_464_1.settingData.music_time ~= 0 then
							arg_464_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_464_1.settingData.music_time), function()
								if arg_464_1 == nil or isNil(arg_464_1.bgmTxt_) then
									return
								end

								arg_464_1.musicController:SetSelectedState("hide")
								arg_464_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666667 < arg_464_1.time_ and arg_464_1.time_ <= 0.566666666666667 + arg_467_0 then
				arg_464_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 1.60066666666667 < arg_464_1.time_ and arg_464_1.time_ <= 1.60066666666667 + arg_467_0 then
				arg_464_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 2 < arg_464_1.time_ and arg_464_1.time_ <= 2 + arg_467_0 then
				arg_464_1:AudioAction("play", "effect", "se_story_143", "se_story_143_door", "")
			end

			if arg_464_1.frameCnt_ <= 1 then
				arg_464_1.dialog_:SetActive(false)
			end

			local var_467_31 = 3.85
			local var_467_32 = 0.65

			if 3.85 < arg_464_1.time_ and arg_464_1.time_ <= var_467_31 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0

				arg_464_1.dialog_:SetActive(true)

				arg_464_1.dialogCg_.alpha = 0

				local var_467_33 = LeanTween.value(arg_464_1.dialog_, 0, 1, 0.3)

				var_467_33:setOnUpdate(LuaHelper.FloatAction(function(arg_470_0)
					arg_464_1.dialogCg_.alpha = arg_470_0
				end))
				var_467_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_464_1.dialog_)
					var_467_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_464_1.duration_ = arg_464_1.duration_ + 0.3

				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_34 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(926021114).content)

				arg_464_1.text_.text = var_467_34

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_36 = 26 <= 0 and var_467_32 or var_467_32 * (utf8.len(var_467_34) / 26)

				if (26 <= 0 and var_467_32 or var_467_32 * (utf8.len(var_467_34) / 26)) > 0 and var_467_32 < var_467_36 then
					arg_464_1.talkMaxDuration = var_467_36
					var_467_31 = var_467_31 + 0.3

					if var_467_36 + var_467_31 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_36 + var_467_31
					end
				end

				arg_464_1.text_.text = var_467_34
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_37 = var_467_31 + 0.3
			local var_467_38 = math.max(var_467_32, arg_464_1.talkMaxDuration)

			if var_467_31 + 0.3 <= arg_464_1.time_ and arg_464_1.time_ < var_467_37 + var_467_38 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_37) / var_467_38

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_37 + var_467_38 and arg_464_1.time_ < var_467_37 + var_467_38 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play926021115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 926021115
		arg_472_1.duration_ = 3.63

		local var_472_0 = {
			zh = 3.633,
			ja = 2.233
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play926021116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["106103"]) and arg_472_1.var_.actorSpriteComps106103 == nil then
				arg_472_1.var_.actorSpriteComps106103 = arg_472_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_0 = 0.2

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["106103"]) then
				if arg_472_1.var_.actorSpriteComps106103 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								iter_475_1.color = Color.New(Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor1.r, (arg_472_1.time_ - 0) / var_475_0), Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor1.g, (arg_472_1.time_ - 0) / var_475_0), (Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor1.b, (arg_472_1.time_ - 0) / var_475_0)))
							else
								local var_475_1 = Mathf.Lerp(iter_475_1.color.r, 1, (arg_472_1.time_ - 0) / var_475_0)

								iter_475_1.color = Color.New(var_475_1, var_475_1, var_475_1)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["106103"]) and arg_472_1.var_.actorSpriteComps106103 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_475_3 then
						iter_475_3.color = arg_472_1.isInRecall_ and (arg_472_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_472_1.var_.actorSpriteComps106103 = nil
			end

			local var_475_2 = 0
			local var_475_3 = 0.15

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_2 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_4 = arg_472_1:GetWordFromCfg(926021115)
				local var_475_5 = arg_472_1:FormatText(var_475_4.content)

				arg_472_1.text_.text = var_475_5

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_7 = 6 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 6)

				if (6 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 6)) > 0 and var_475_3 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_2
					end
				end

				arg_472_1.text_.text = var_475_5
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021115", "story_v_out_926021.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021115", "story_v_out_926021.awb") / 1000

					if var_475_8 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_2
					end

					if var_475_4.prefab_name ~= "" and arg_472_1.actors_[var_475_4.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_4.prefab_name].transform, "story_v_out_926021", "926021115", "story_v_out_926021.awb")

						arg_472_1:RecordAudio("926021115", var_475_9)
						arg_472_1:RecordAudio("926021115", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_926021", "926021115", "story_v_out_926021.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_926021", "926021115", "story_v_out_926021.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_3, arg_472_1.talkMaxDuration)

			if var_475_2 <= arg_472_1.time_ and arg_472_1.time_ < var_475_2 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_2) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_2 + var_475_10 and arg_472_1.time_ < var_475_2 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play926021116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 926021116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play926021117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["106103"]) and arg_476_1.var_.actorSpriteComps106103 == nil then
				arg_476_1.var_.actorSpriteComps106103 = arg_476_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_479_0 = 0.2

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["106103"]) then
				if arg_476_1.var_.actorSpriteComps106103 then
					for iter_479_0, iter_479_1 in pairs(arg_476_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_479_1 then
							if arg_476_1.isInRecall_ then
								iter_479_1.color = Color.New(Mathf.Lerp(iter_479_1.color.r, arg_476_1.hightColor2.r, (arg_476_1.time_ - 0) / var_479_0), Mathf.Lerp(iter_479_1.color.g, arg_476_1.hightColor2.g, (arg_476_1.time_ - 0) / var_479_0), (Mathf.Lerp(iter_479_1.color.b, arg_476_1.hightColor2.b, (arg_476_1.time_ - 0) / var_479_0)))
							else
								local var_479_1 = Mathf.Lerp(iter_479_1.color.r, 0.5, (arg_476_1.time_ - 0) / var_479_0)

								iter_479_1.color = Color.New(var_479_1, var_479_1, var_479_1)
							end
						end
					end
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["106103"]) and arg_476_1.var_.actorSpriteComps106103 then
				for iter_479_2, iter_479_3 in pairs(arg_476_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_479_3 then
						iter_479_3.color = arg_476_1.isInRecall_ and (arg_476_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_476_1.var_.actorSpriteComps106103 = nil
			end

			local var_479_2 = 0
			local var_479_3 = 0.9

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_2 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_4 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(926021116).content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_6 = 36 <= 0 and var_479_3 or var_479_3 * (utf8.len(var_479_4) / 36)

				if (36 <= 0 and var_479_3 or var_479_3 * (utf8.len(var_479_4) / 36)) > 0 and var_479_3 < var_479_6 then
					arg_476_1.talkMaxDuration = var_479_6

					if var_479_6 + var_479_2 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_6 + var_479_2
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_3, arg_476_1.talkMaxDuration)

			if var_479_2 <= arg_476_1.time_ and arg_476_1.time_ < var_479_2 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_2) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_2 + var_479_7 and arg_476_1.time_ < var_479_2 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play926021117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 926021117
		arg_480_1.duration_ = 4.03

		local var_480_0 = {
			zh = 2.666,
			ja = 4.033
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play926021118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(arg_480_1.actors_["10144"]) and arg_480_1.var_.actorSpriteComps10144 == nil then
				arg_480_1.var_.actorSpriteComps10144 = arg_480_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_0 = 0.2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 and not isNil(arg_480_1.actors_["10144"]) then
				if arg_480_1.var_.actorSpriteComps10144 then
					for iter_483_0, iter_483_1 in pairs(arg_480_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_483_1 then
							if arg_480_1.isInRecall_ then
								iter_483_1.color = Color.New(Mathf.Lerp(iter_483_1.color.r, arg_480_1.hightColor1.r, (arg_480_1.time_ - 0) / var_483_0), Mathf.Lerp(iter_483_1.color.g, arg_480_1.hightColor1.g, (arg_480_1.time_ - 0) / var_483_0), (Mathf.Lerp(iter_483_1.color.b, arg_480_1.hightColor1.b, (arg_480_1.time_ - 0) / var_483_0)))
							else
								local var_483_1 = Mathf.Lerp(iter_483_1.color.r, 1, (arg_480_1.time_ - 0) / var_483_0)

								iter_483_1.color = Color.New(var_483_1, var_483_1, var_483_1)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 and not isNil(arg_480_1.actors_["10144"]) and arg_480_1.var_.actorSpriteComps10144 then
				for iter_483_2, iter_483_3 in pairs(arg_480_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_483_3 then
						iter_483_3.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_480_1.var_.actorSpriteComps10144 = nil
			end

			local var_483_2 = arg_480_1.actors_["10144"].transform

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos10144 = var_483_2.localPosition
				var_483_2.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("10144", 3)

				for iter_483_4 = 0, var_483_2.childCount - 1 do
					local var_483_3 = var_483_2:GetChild(iter_483_4)

					if var_483_3.name == "" or not string.find(var_483_3.name, "split") then
						var_483_3.gameObject:SetActive(true)
					else
						var_483_3.gameObject:SetActive(false)
					end
				end
			end

			local var_483_4 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 then
				var_483_2.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_480_1.time_ - 0) / var_483_4)
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 then
				var_483_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_483_5 = 0
			local var_483_6 = 0.425

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_5 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_7 = arg_480_1:GetWordFromCfg(926021117)
				local var_483_8 = arg_480_1:FormatText(var_483_7.content)

				arg_480_1.text_.text = var_483_8

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_10 = 17 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 17)

				if (17 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 17)) > 0 and var_483_6 < var_483_10 then
					arg_480_1.talkMaxDuration = var_483_10

					if var_483_10 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_5
					end
				end

				arg_480_1.text_.text = var_483_8
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021117", "story_v_out_926021.awb") ~= 0 then
					local var_483_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021117", "story_v_out_926021.awb") / 1000

					if var_483_11 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_11 + var_483_5
					end

					if var_483_7.prefab_name ~= "" and arg_480_1.actors_[var_483_7.prefab_name] ~= nil then
						local var_483_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_7.prefab_name].transform, "story_v_out_926021", "926021117", "story_v_out_926021.awb")

						arg_480_1:RecordAudio("926021117", var_483_12)
						arg_480_1:RecordAudio("926021117", var_483_12)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_926021", "926021117", "story_v_out_926021.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_926021", "926021117", "story_v_out_926021.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_13 = math.max(var_483_6, arg_480_1.talkMaxDuration)

			if var_483_5 <= arg_480_1.time_ and arg_480_1.time_ < var_483_5 + var_483_13 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_5) / var_483_13

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_5 + var_483_13 and arg_480_1.time_ < var_483_5 + var_483_13 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play926021118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 926021118
		arg_484_1.duration_ = 1.57

		local var_484_0 = {
			zh = 1.033,
			ja = 1.566
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play926021119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["106103"]) and arg_484_1.var_.actorSpriteComps106103 == nil then
				arg_484_1.var_.actorSpriteComps106103 = arg_484_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_0 = 0.2

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["106103"]) then
				if arg_484_1.var_.actorSpriteComps106103 then
					for iter_487_0, iter_487_1 in pairs(arg_484_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_487_1 then
							if arg_484_1.isInRecall_ then
								iter_487_1.color = Color.New(Mathf.Lerp(iter_487_1.color.r, arg_484_1.hightColor1.r, (arg_484_1.time_ - 0) / var_487_0), Mathf.Lerp(iter_487_1.color.g, arg_484_1.hightColor1.g, (arg_484_1.time_ - 0) / var_487_0), (Mathf.Lerp(iter_487_1.color.b, arg_484_1.hightColor1.b, (arg_484_1.time_ - 0) / var_487_0)))
							else
								local var_487_1 = Mathf.Lerp(iter_487_1.color.r, 1, (arg_484_1.time_ - 0) / var_487_0)

								iter_487_1.color = Color.New(var_487_1, var_487_1, var_487_1)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["106103"]) and arg_484_1.var_.actorSpriteComps106103 then
				for iter_487_2, iter_487_3 in pairs(arg_484_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_487_3 then
						iter_487_3.color = arg_484_1.isInRecall_ and (arg_484_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_484_1.var_.actorSpriteComps106103 = nil
			end

			local var_487_2 = arg_484_1.actors_["10144"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_2) and arg_484_1.var_.actorSpriteComps10144 == nil then
				arg_484_1.var_.actorSpriteComps10144 = var_487_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_3 = 0.2

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_3 and not isNil(var_487_2) then
				if arg_484_1.var_.actorSpriteComps10144 then
					for iter_487_4, iter_487_5 in pairs(arg_484_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_487_5 then
							if arg_484_1.isInRecall_ then
								iter_487_5.color = Color.New(Mathf.Lerp(iter_487_5.color.r, arg_484_1.hightColor2.r, (arg_484_1.time_ - 0) / var_487_3), Mathf.Lerp(iter_487_5.color.g, arg_484_1.hightColor2.g, (arg_484_1.time_ - 0) / var_487_3), (Mathf.Lerp(iter_487_5.color.b, arg_484_1.hightColor2.b, (arg_484_1.time_ - 0) / var_487_3)))
							else
								local var_487_4 = Mathf.Lerp(iter_487_5.color.r, 0.5, (arg_484_1.time_ - 0) / var_487_3)

								iter_487_5.color = Color.New(var_487_4, var_487_4, var_487_4)
							end
						end
					end
				end
			end

			if arg_484_1.time_ >= 0 + var_487_3 and arg_484_1.time_ < 0 + var_487_3 + arg_487_0 and not isNil(var_487_2) and arg_484_1.var_.actorSpriteComps10144 then
				for iter_487_6, iter_487_7 in pairs(arg_484_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_487_7 then
						iter_487_7.color = arg_484_1.isInRecall_ and (arg_484_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_484_1.var_.actorSpriteComps10144 = nil
			end

			local var_487_5 = 0
			local var_487_6 = 0.05

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_5 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106103_split_1")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_7 = arg_484_1:GetWordFromCfg(926021118)
				local var_487_8 = arg_484_1:FormatText(var_487_7.content)

				arg_484_1.text_.text = var_487_8

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_10 = 2 <= 0 and var_487_6 or var_487_6 * (utf8.len(var_487_8) / 2)

				if (2 <= 0 and var_487_6 or var_487_6 * (utf8.len(var_487_8) / 2)) > 0 and var_487_6 < var_487_10 then
					arg_484_1.talkMaxDuration = var_487_10

					if var_487_10 + var_487_5 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_10 + var_487_5
					end
				end

				arg_484_1.text_.text = var_487_8
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021118", "story_v_out_926021.awb") ~= 0 then
					local var_487_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021118", "story_v_out_926021.awb") / 1000

					if var_487_11 + var_487_5 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_11 + var_487_5
					end

					if var_487_7.prefab_name ~= "" and arg_484_1.actors_[var_487_7.prefab_name] ~= nil then
						local var_487_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_7.prefab_name].transform, "story_v_out_926021", "926021118", "story_v_out_926021.awb")

						arg_484_1:RecordAudio("926021118", var_487_12)
						arg_484_1:RecordAudio("926021118", var_487_12)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_926021", "926021118", "story_v_out_926021.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_926021", "926021118", "story_v_out_926021.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_13 = math.max(var_487_6, arg_484_1.talkMaxDuration)

			if var_487_5 <= arg_484_1.time_ and arg_484_1.time_ < var_487_5 + var_487_13 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_5) / var_487_13

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_5 + var_487_13 and arg_484_1.time_ < var_487_5 + var_487_13 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play926021119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 926021119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play926021120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["106103"]) and arg_488_1.var_.actorSpriteComps106103 == nil then
				arg_488_1.var_.actorSpriteComps106103 = arg_488_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_0 = 0.2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["106103"]) then
				if arg_488_1.var_.actorSpriteComps106103 then
					for iter_491_0, iter_491_1 in pairs(arg_488_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_491_1 then
							if arg_488_1.isInRecall_ then
								iter_491_1.color = Color.New(Mathf.Lerp(iter_491_1.color.r, arg_488_1.hightColor2.r, (arg_488_1.time_ - 0) / var_491_0), Mathf.Lerp(iter_491_1.color.g, arg_488_1.hightColor2.g, (arg_488_1.time_ - 0) / var_491_0), (Mathf.Lerp(iter_491_1.color.b, arg_488_1.hightColor2.b, (arg_488_1.time_ - 0) / var_491_0)))
							else
								local var_491_1 = Mathf.Lerp(iter_491_1.color.r, 0.5, (arg_488_1.time_ - 0) / var_491_0)

								iter_491_1.color = Color.New(var_491_1, var_491_1, var_491_1)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["106103"]) and arg_488_1.var_.actorSpriteComps106103 then
				for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_491_3 then
						iter_491_3.color = arg_488_1.isInRecall_ and (arg_488_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_488_1.var_.actorSpriteComps106103 = nil
			end

			local var_491_2 = 0
			local var_491_3 = 1.225

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_2 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, false)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_4 = arg_488_1:FormatText(arg_488_1:GetWordFromCfg(926021119).content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_6 = 49 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_4) / 49)

				if (49 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_4) / 49)) > 0 and var_491_3 < var_491_6 then
					arg_488_1.talkMaxDuration = var_491_6

					if var_491_6 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_6 + var_491_2
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_3, arg_488_1.talkMaxDuration)

			if var_491_2 <= arg_488_1.time_ and arg_488_1.time_ < var_491_2 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_2) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_2 + var_491_7 and arg_488_1.time_ < var_491_2 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play926021120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 926021120
		arg_492_1.duration_ = 4.17

		local var_492_0 = {
			zh = 2.566,
			ja = 4.166
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play926021121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["10144"]) and arg_492_1.var_.actorSpriteComps10144 == nil then
				arg_492_1.var_.actorSpriteComps10144 = arg_492_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_0 = 0.2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["10144"]) then
				if arg_492_1.var_.actorSpriteComps10144 then
					for iter_495_0, iter_495_1 in pairs(arg_492_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_495_1 then
							if arg_492_1.isInRecall_ then
								iter_495_1.color = Color.New(Mathf.Lerp(iter_495_1.color.r, arg_492_1.hightColor1.r, (arg_492_1.time_ - 0) / var_495_0), Mathf.Lerp(iter_495_1.color.g, arg_492_1.hightColor1.g, (arg_492_1.time_ - 0) / var_495_0), (Mathf.Lerp(iter_495_1.color.b, arg_492_1.hightColor1.b, (arg_492_1.time_ - 0) / var_495_0)))
							else
								local var_495_1 = Mathf.Lerp(iter_495_1.color.r, 1, (arg_492_1.time_ - 0) / var_495_0)

								iter_495_1.color = Color.New(var_495_1, var_495_1, var_495_1)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["10144"]) and arg_492_1.var_.actorSpriteComps10144 then
				for iter_495_2, iter_495_3 in pairs(arg_492_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_495_3 then
						iter_495_3.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_492_1.var_.actorSpriteComps10144 = nil
			end

			local var_495_2 = arg_492_1.actors_["10144"].transform

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos10144 = var_495_2.localPosition
				var_495_2.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10144", 3)

				for iter_495_4 = 0, var_495_2.childCount - 1 do
					local var_495_3 = var_495_2:GetChild(iter_495_4)

					if var_495_3.name == "split_2" or not string.find(var_495_3.name, "split") then
						var_495_3.gameObject:SetActive(true)
					else
						var_495_3.gameObject:SetActive(false)
					end
				end
			end

			local var_495_4 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_4 then
				var_495_2.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_492_1.time_ - 0) / var_495_4)
			end

			if arg_492_1.time_ >= 0 + var_495_4 and arg_492_1.time_ < 0 + var_495_4 + arg_495_0 then
				var_495_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_495_5 = 0
			local var_495_6 = 0.3

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_5 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_7 = arg_492_1:GetWordFromCfg(926021120)
				local var_495_8 = arg_492_1:FormatText(var_495_7.content)

				arg_492_1.text_.text = var_495_8

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_10 = 12 <= 0 and var_495_6 or var_495_6 * (utf8.len(var_495_8) / 12)

				if (12 <= 0 and var_495_6 or var_495_6 * (utf8.len(var_495_8) / 12)) > 0 and var_495_6 < var_495_10 then
					arg_492_1.talkMaxDuration = var_495_10

					if var_495_10 + var_495_5 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_10 + var_495_5
					end
				end

				arg_492_1.text_.text = var_495_8
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021120", "story_v_out_926021.awb") ~= 0 then
					local var_495_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021120", "story_v_out_926021.awb") / 1000

					if var_495_11 + var_495_5 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_11 + var_495_5
					end

					if var_495_7.prefab_name ~= "" and arg_492_1.actors_[var_495_7.prefab_name] ~= nil then
						local var_495_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_7.prefab_name].transform, "story_v_out_926021", "926021120", "story_v_out_926021.awb")

						arg_492_1:RecordAudio("926021120", var_495_12)
						arg_492_1:RecordAudio("926021120", var_495_12)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_926021", "926021120", "story_v_out_926021.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_926021", "926021120", "story_v_out_926021.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_13 = math.max(var_495_6, arg_492_1.talkMaxDuration)

			if var_495_5 <= arg_492_1.time_ and arg_492_1.time_ < var_495_5 + var_495_13 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_5) / var_495_13

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_5 + var_495_13 and arg_492_1.time_ < var_495_5 + var_495_13 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play926021121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 926021121
		arg_496_1.duration_ = 5.43

		local var_496_0 = {
			zh = 5.266,
			ja = 5.433
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play926021122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(arg_496_1.actors_["106103"]) and arg_496_1.var_.actorSpriteComps106103 == nil then
				arg_496_1.var_.actorSpriteComps106103 = arg_496_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_0 = 0.2

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 and not isNil(arg_496_1.actors_["106103"]) then
				if arg_496_1.var_.actorSpriteComps106103 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_499_1 then
							if arg_496_1.isInRecall_ then
								iter_499_1.color = Color.New(Mathf.Lerp(iter_499_1.color.r, arg_496_1.hightColor1.r, (arg_496_1.time_ - 0) / var_499_0), Mathf.Lerp(iter_499_1.color.g, arg_496_1.hightColor1.g, (arg_496_1.time_ - 0) / var_499_0), (Mathf.Lerp(iter_499_1.color.b, arg_496_1.hightColor1.b, (arg_496_1.time_ - 0) / var_499_0)))
							else
								local var_499_1 = Mathf.Lerp(iter_499_1.color.r, 1, (arg_496_1.time_ - 0) / var_499_0)

								iter_499_1.color = Color.New(var_499_1, var_499_1, var_499_1)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 and not isNil(arg_496_1.actors_["106103"]) and arg_496_1.var_.actorSpriteComps106103 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_499_3 then
						iter_499_3.color = arg_496_1.isInRecall_ and (arg_496_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_496_1.var_.actorSpriteComps106103 = nil
			end

			local var_499_2 = arg_496_1.actors_["10144"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_2) and arg_496_1.var_.actorSpriteComps10144 == nil then
				arg_496_1.var_.actorSpriteComps10144 = var_499_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_3 = 0.2

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_3 and not isNil(var_499_2) then
				if arg_496_1.var_.actorSpriteComps10144 then
					for iter_499_4, iter_499_5 in pairs(arg_496_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_499_5 then
							if arg_496_1.isInRecall_ then
								iter_499_5.color = Color.New(Mathf.Lerp(iter_499_5.color.r, arg_496_1.hightColor2.r, (arg_496_1.time_ - 0) / var_499_3), Mathf.Lerp(iter_499_5.color.g, arg_496_1.hightColor2.g, (arg_496_1.time_ - 0) / var_499_3), (Mathf.Lerp(iter_499_5.color.b, arg_496_1.hightColor2.b, (arg_496_1.time_ - 0) / var_499_3)))
							else
								local var_499_4 = Mathf.Lerp(iter_499_5.color.r, 0.5, (arg_496_1.time_ - 0) / var_499_3)

								iter_499_5.color = Color.New(var_499_4, var_499_4, var_499_4)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= 0 + var_499_3 and arg_496_1.time_ < 0 + var_499_3 + arg_499_0 and not isNil(var_499_2) and arg_496_1.var_.actorSpriteComps10144 then
				for iter_499_6, iter_499_7 in pairs(arg_496_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_499_7 then
						iter_499_7.color = arg_496_1.isInRecall_ and (arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_496_1.var_.actorSpriteComps10144 = nil
			end

			local var_499_5 = arg_496_1.actors_["106103"].transform

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos106103 = var_499_5.localPosition
				var_499_5.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("106103", 4)

				for iter_499_8 = 0, var_499_5.childCount - 1 do
					local var_499_6 = var_499_5:GetChild(iter_499_8)

					if var_499_6.name == "split_4" or not string.find(var_499_6.name, "split") then
						var_499_6.gameObject:SetActive(true)
					else
						var_499_6.gameObject:SetActive(false)
					end
				end
			end

			local var_499_7 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_7 then
				var_499_5.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos106103, Vector3.New(442.7, -398.2, -333.7), (arg_496_1.time_ - 0) / var_499_7)
			end

			if arg_496_1.time_ >= 0 + var_499_7 and arg_496_1.time_ < 0 + var_499_7 + arg_499_0 then
				var_499_5.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_499_8 = arg_496_1.actors_["10144"].transform

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos10144 = var_499_8.localPosition
				var_499_8.localScale = Vector3.New(1, 1, 1)

				arg_496_1:CheckSpriteTmpPos("10144", 2)

				for iter_499_9 = 0, var_499_8.childCount - 1 do
					local var_499_9 = var_499_8:GetChild(iter_499_9)

					if var_499_9.name == "split_1" or not string.find(var_499_9.name, "split") then
						var_499_9.gameObject:SetActive(true)
					else
						var_499_9.gameObject:SetActive(false)
					end
				end
			end

			local var_499_10 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_10 then
				var_499_8.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_496_1.time_ - 0) / var_499_10)
			end

			if arg_496_1.time_ >= 0 + var_499_10 and arg_496_1.time_ < 0 + var_499_10 + arg_499_0 then
				var_499_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_499_11 = 0
			local var_499_12 = 0.6

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_11 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_13 = arg_496_1:GetWordFromCfg(926021121)
				local var_499_14 = arg_496_1:FormatText(var_499_13.content)

				arg_496_1.text_.text = var_499_14

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_16 = 24 <= 0 and var_499_12 or var_499_12 * (utf8.len(var_499_14) / 24)

				if (24 <= 0 and var_499_12 or var_499_12 * (utf8.len(var_499_14) / 24)) > 0 and var_499_12 < var_499_16 then
					arg_496_1.talkMaxDuration = var_499_16

					if var_499_16 + var_499_11 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_16 + var_499_11
					end
				end

				arg_496_1.text_.text = var_499_14
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021121", "story_v_out_926021.awb") ~= 0 then
					local var_499_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021121", "story_v_out_926021.awb") / 1000

					if var_499_17 + var_499_11 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_17 + var_499_11
					end

					if var_499_13.prefab_name ~= "" and arg_496_1.actors_[var_499_13.prefab_name] ~= nil then
						local var_499_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_13.prefab_name].transform, "story_v_out_926021", "926021121", "story_v_out_926021.awb")

						arg_496_1:RecordAudio("926021121", var_499_18)
						arg_496_1:RecordAudio("926021121", var_499_18)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_926021", "926021121", "story_v_out_926021.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_926021", "926021121", "story_v_out_926021.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_19 = math.max(var_499_12, arg_496_1.talkMaxDuration)

			if var_499_11 <= arg_496_1.time_ and arg_496_1.time_ < var_499_11 + var_499_19 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_11) / var_499_19

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_11 + var_499_19 and arg_496_1.time_ < var_499_11 + var_499_19 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play926021122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 926021122
		arg_500_1.duration_ = 5.33

		local var_500_0 = {
			zh = 2.466,
			ja = 5.333
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play926021123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["10144"]) and arg_500_1.var_.actorSpriteComps10144 == nil then
				arg_500_1.var_.actorSpriteComps10144 = arg_500_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_0 = 0.2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["10144"]) then
				if arg_500_1.var_.actorSpriteComps10144 then
					for iter_503_0, iter_503_1 in pairs(arg_500_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_503_1 then
							if arg_500_1.isInRecall_ then
								iter_503_1.color = Color.New(Mathf.Lerp(iter_503_1.color.r, arg_500_1.hightColor1.r, (arg_500_1.time_ - 0) / var_503_0), Mathf.Lerp(iter_503_1.color.g, arg_500_1.hightColor1.g, (arg_500_1.time_ - 0) / var_503_0), (Mathf.Lerp(iter_503_1.color.b, arg_500_1.hightColor1.b, (arg_500_1.time_ - 0) / var_503_0)))
							else
								local var_503_1 = Mathf.Lerp(iter_503_1.color.r, 1, (arg_500_1.time_ - 0) / var_503_0)

								iter_503_1.color = Color.New(var_503_1, var_503_1, var_503_1)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["10144"]) and arg_500_1.var_.actorSpriteComps10144 then
				for iter_503_2, iter_503_3 in pairs(arg_500_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_503_3 then
						iter_503_3.color = arg_500_1.isInRecall_ and (arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_500_1.var_.actorSpriteComps10144 = nil
			end

			local var_503_2 = arg_500_1.actors_["106103"]

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(var_503_2) and arg_500_1.var_.actorSpriteComps106103 == nil then
				arg_500_1.var_.actorSpriteComps106103 = var_503_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_3 = 0.2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_3 and not isNil(var_503_2) then
				if arg_500_1.var_.actorSpriteComps106103 then
					for iter_503_4, iter_503_5 in pairs(arg_500_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_503_5 then
							if arg_500_1.isInRecall_ then
								iter_503_5.color = Color.New(Mathf.Lerp(iter_503_5.color.r, arg_500_1.hightColor2.r, (arg_500_1.time_ - 0) / var_503_3), Mathf.Lerp(iter_503_5.color.g, arg_500_1.hightColor2.g, (arg_500_1.time_ - 0) / var_503_3), (Mathf.Lerp(iter_503_5.color.b, arg_500_1.hightColor2.b, (arg_500_1.time_ - 0) / var_503_3)))
							else
								local var_503_4 = Mathf.Lerp(iter_503_5.color.r, 0.5, (arg_500_1.time_ - 0) / var_503_3)

								iter_503_5.color = Color.New(var_503_4, var_503_4, var_503_4)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= 0 + var_503_3 and arg_500_1.time_ < 0 + var_503_3 + arg_503_0 and not isNil(var_503_2) and arg_500_1.var_.actorSpriteComps106103 then
				for iter_503_6, iter_503_7 in pairs(arg_500_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_503_7 then
						iter_503_7.color = arg_500_1.isInRecall_ and (arg_500_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_500_1.var_.actorSpriteComps106103 = nil
			end

			local var_503_5 = 0
			local var_503_6 = 0.275

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_5 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_7 = arg_500_1:GetWordFromCfg(926021122)
				local var_503_8 = arg_500_1:FormatText(var_503_7.content)

				arg_500_1.text_.text = var_503_8

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_10 = 11 <= 0 and var_503_6 or var_503_6 * (utf8.len(var_503_8) / 11)

				if (11 <= 0 and var_503_6 or var_503_6 * (utf8.len(var_503_8) / 11)) > 0 and var_503_6 < var_503_10 then
					arg_500_1.talkMaxDuration = var_503_10

					if var_503_10 + var_503_5 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_10 + var_503_5
					end
				end

				arg_500_1.text_.text = var_503_8
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021122", "story_v_out_926021.awb") ~= 0 then
					local var_503_11 = manager.audio:GetVoiceLength("story_v_out_926021", "926021122", "story_v_out_926021.awb") / 1000

					if var_503_11 + var_503_5 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_11 + var_503_5
					end

					if var_503_7.prefab_name ~= "" and arg_500_1.actors_[var_503_7.prefab_name] ~= nil then
						local var_503_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_7.prefab_name].transform, "story_v_out_926021", "926021122", "story_v_out_926021.awb")

						arg_500_1:RecordAudio("926021122", var_503_12)
						arg_500_1:RecordAudio("926021122", var_503_12)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_926021", "926021122", "story_v_out_926021.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_926021", "926021122", "story_v_out_926021.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_13 = math.max(var_503_6, arg_500_1.talkMaxDuration)

			if var_503_5 <= arg_500_1.time_ and arg_500_1.time_ < var_503_5 + var_503_13 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_5) / var_503_13

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_5 + var_503_13 and arg_500_1.time_ < var_503_5 + var_503_13 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play926021123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 926021123
		arg_504_1.duration_ = 6.07

		local var_504_0 = {
			zh = 3.933,
			ja = 6.066
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play926021124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0.55

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_1 = arg_504_1:GetWordFromCfg(926021123)
				local var_507_2 = arg_504_1:FormatText(var_507_1.content)

				arg_504_1.text_.text = var_507_2

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_4 = 22 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_2) / 22)

				if (22 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_2) / 22)) > 0 and var_507_0 < var_507_4 then
					arg_504_1.talkMaxDuration = var_507_4

					if var_507_4 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_4 + 0
					end
				end

				arg_504_1.text_.text = var_507_2
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021123", "story_v_out_926021.awb") ~= 0 then
					local var_507_5 = manager.audio:GetVoiceLength("story_v_out_926021", "926021123", "story_v_out_926021.awb") / 1000

					if var_507_5 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_5 + 0
					end

					if var_507_1.prefab_name ~= "" and arg_504_1.actors_[var_507_1.prefab_name] ~= nil then
						local var_507_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_1.prefab_name].transform, "story_v_out_926021", "926021123", "story_v_out_926021.awb")

						arg_504_1:RecordAudio("926021123", var_507_6)
						arg_504_1:RecordAudio("926021123", var_507_6)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_926021", "926021123", "story_v_out_926021.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_926021", "926021123", "story_v_out_926021.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_7 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_7 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_7

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_7 and arg_504_1.time_ < 0 + var_507_7 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play926021124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 926021124
		arg_508_1.duration_ = 5.7

		local var_508_0 = {
			zh = 4.033,
			ja = 5.7
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play926021125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["104701"]) and arg_508_1.var_.actorSpriteComps104701 == nil then
				arg_508_1.var_.actorSpriteComps104701 = arg_508_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_0 = 0.2

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["104701"]) then
				if arg_508_1.var_.actorSpriteComps104701 then
					for iter_511_0, iter_511_1 in pairs(arg_508_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_511_1 then
							if arg_508_1.isInRecall_ then
								iter_511_1.color = Color.New(Mathf.Lerp(iter_511_1.color.r, arg_508_1.hightColor1.r, (arg_508_1.time_ - 0) / var_511_0), Mathf.Lerp(iter_511_1.color.g, arg_508_1.hightColor1.g, (arg_508_1.time_ - 0) / var_511_0), (Mathf.Lerp(iter_511_1.color.b, arg_508_1.hightColor1.b, (arg_508_1.time_ - 0) / var_511_0)))
							else
								local var_511_1 = Mathf.Lerp(iter_511_1.color.r, 1, (arg_508_1.time_ - 0) / var_511_0)

								iter_511_1.color = Color.New(var_511_1, var_511_1, var_511_1)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["104701"]) and arg_508_1.var_.actorSpriteComps104701 then
				for iter_511_2, iter_511_3 in pairs(arg_508_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_511_3 then
						iter_511_3.color = arg_508_1.isInRecall_ and (arg_508_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_508_1.var_.actorSpriteComps104701 = nil
			end

			local var_511_2 = arg_508_1.actors_["10144"]

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(var_511_2) and arg_508_1.var_.actorSpriteComps10144 == nil then
				arg_508_1.var_.actorSpriteComps10144 = var_511_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_511_3 = 0.2

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_3 and not isNil(var_511_2) then
				if arg_508_1.var_.actorSpriteComps10144 then
					for iter_511_4, iter_511_5 in pairs(arg_508_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_511_5 then
							if arg_508_1.isInRecall_ then
								iter_511_5.color = Color.New(Mathf.Lerp(iter_511_5.color.r, arg_508_1.hightColor2.r, (arg_508_1.time_ - 0) / var_511_3), Mathf.Lerp(iter_511_5.color.g, arg_508_1.hightColor2.g, (arg_508_1.time_ - 0) / var_511_3), (Mathf.Lerp(iter_511_5.color.b, arg_508_1.hightColor2.b, (arg_508_1.time_ - 0) / var_511_3)))
							else
								local var_511_4 = Mathf.Lerp(iter_511_5.color.r, 0.5, (arg_508_1.time_ - 0) / var_511_3)

								iter_511_5.color = Color.New(var_511_4, var_511_4, var_511_4)
							end
						end
					end
				end
			end

			if arg_508_1.time_ >= 0 + var_511_3 and arg_508_1.time_ < 0 + var_511_3 + arg_511_0 and not isNil(var_511_2) and arg_508_1.var_.actorSpriteComps10144 then
				for iter_511_6, iter_511_7 in pairs(arg_508_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_511_7 then
						iter_511_7.color = arg_508_1.isInRecall_ and (arg_508_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_508_1.var_.actorSpriteComps10144 = nil
			end

			local var_511_5 = arg_508_1.actors_["106103"].transform

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos106103 = var_511_5.localPosition
				var_511_5.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("106103", 7)

				for iter_511_8 = 0, var_511_5.childCount - 1 do
					local var_511_6 = var_511_5:GetChild(iter_511_8)

					if var_511_6.name == "" or not string.find(var_511_6.name, "split") then
						var_511_6.gameObject:SetActive(true)
					else
						var_511_6.gameObject:SetActive(false)
					end
				end
			end

			local var_511_7 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_7 then
				var_511_5.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_508_1.time_ - 0) / var_511_7)
			end

			if arg_508_1.time_ >= 0 + var_511_7 and arg_508_1.time_ < 0 + var_511_7 + arg_511_0 then
				var_511_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_511_8 = arg_508_1.actors_["104701"].transform

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos104701 = var_511_8.localPosition
				var_511_8.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("104701", 3)

				for iter_511_9 = 0, var_511_8.childCount - 1 do
					local var_511_9 = var_511_8:GetChild(iter_511_9)

					if var_511_9.name == "" or not string.find(var_511_9.name, "split") then
						var_511_9.gameObject:SetActive(true)
					else
						var_511_9.gameObject:SetActive(false)
					end
				end
			end

			local var_511_10 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_10 then
				var_511_8.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_508_1.time_ - 0) / var_511_10)
			end

			if arg_508_1.time_ >= 0 + var_511_10 and arg_508_1.time_ < 0 + var_511_10 + arg_511_0 then
				var_511_8.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_511_11 = arg_508_1.actors_["10144"].transform

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos10144 = var_511_11.localPosition
				var_511_11.localScale = Vector3.New(1, 1, 1)

				arg_508_1:CheckSpriteTmpPos("10144", 7)

				for iter_511_10 = 0, var_511_11.childCount - 1 do
					local var_511_12 = var_511_11:GetChild(iter_511_10)

					if var_511_12.name == "split_4" or not string.find(var_511_12.name, "split") then
						var_511_12.gameObject:SetActive(true)
					else
						var_511_12.gameObject:SetActive(false)
					end
				end
			end

			local var_511_13 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_13 then
				var_511_11.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_508_1.time_ - 0) / var_511_13)
			end

			if arg_508_1.time_ >= 0 + var_511_13 and arg_508_1.time_ < 0 + var_511_13 + arg_511_0 then
				var_511_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_511_14 = 0
			local var_511_15 = 0.425

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_14 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_16 = arg_508_1:GetWordFromCfg(926021124)
				local var_511_17 = arg_508_1:FormatText(var_511_16.content)

				arg_508_1.text_.text = var_511_17

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_19 = 17 <= 0 and var_511_15 or var_511_15 * (utf8.len(var_511_17) / 17)

				if (17 <= 0 and var_511_15 or var_511_15 * (utf8.len(var_511_17) / 17)) > 0 and var_511_15 < var_511_19 then
					arg_508_1.talkMaxDuration = var_511_19

					if var_511_19 + var_511_14 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_19 + var_511_14
					end
				end

				arg_508_1.text_.text = var_511_17
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021124", "story_v_out_926021.awb") ~= 0 then
					local var_511_20 = manager.audio:GetVoiceLength("story_v_out_926021", "926021124", "story_v_out_926021.awb") / 1000

					if var_511_20 + var_511_14 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_20 + var_511_14
					end

					if var_511_16.prefab_name ~= "" and arg_508_1.actors_[var_511_16.prefab_name] ~= nil then
						local var_511_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_16.prefab_name].transform, "story_v_out_926021", "926021124", "story_v_out_926021.awb")

						arg_508_1:RecordAudio("926021124", var_511_21)
						arg_508_1:RecordAudio("926021124", var_511_21)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_926021", "926021124", "story_v_out_926021.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_926021", "926021124", "story_v_out_926021.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_22 = math.max(var_511_15, arg_508_1.talkMaxDuration)

			if var_511_14 <= arg_508_1.time_ and arg_508_1.time_ < var_511_14 + var_511_22 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_14) / var_511_22

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_14 + var_511_22 and arg_508_1.time_ < var_511_14 + var_511_22 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play926021125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 926021125
		arg_512_1.duration_ = 5.43

		local var_512_0 = {
			zh = 5.066,
			ja = 5.433
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play926021126(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["10144"]) and arg_512_1.var_.actorSpriteComps10144 == nil then
				arg_512_1.var_.actorSpriteComps10144 = arg_512_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_0 = 0.2

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["10144"]) then
				if arg_512_1.var_.actorSpriteComps10144 then
					for iter_515_0, iter_515_1 in pairs(arg_512_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_515_1 then
							if arg_512_1.isInRecall_ then
								iter_515_1.color = Color.New(Mathf.Lerp(iter_515_1.color.r, arg_512_1.hightColor1.r, (arg_512_1.time_ - 0) / var_515_0), Mathf.Lerp(iter_515_1.color.g, arg_512_1.hightColor1.g, (arg_512_1.time_ - 0) / var_515_0), (Mathf.Lerp(iter_515_1.color.b, arg_512_1.hightColor1.b, (arg_512_1.time_ - 0) / var_515_0)))
							else
								local var_515_1 = Mathf.Lerp(iter_515_1.color.r, 1, (arg_512_1.time_ - 0) / var_515_0)

								iter_515_1.color = Color.New(var_515_1, var_515_1, var_515_1)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["10144"]) and arg_512_1.var_.actorSpriteComps10144 then
				for iter_515_2, iter_515_3 in pairs(arg_512_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_515_3 then
						iter_515_3.color = arg_512_1.isInRecall_ and (arg_512_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_512_1.var_.actorSpriteComps10144 = nil
			end

			local var_515_2 = arg_512_1.actors_["104701"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_2) and arg_512_1.var_.actorSpriteComps104701 == nil then
				arg_512_1.var_.actorSpriteComps104701 = var_515_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_515_3 = 0.2

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_3 and not isNil(var_515_2) then
				if arg_512_1.var_.actorSpriteComps104701 then
					for iter_515_4, iter_515_5 in pairs(arg_512_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_515_5 then
							if arg_512_1.isInRecall_ then
								iter_515_5.color = Color.New(Mathf.Lerp(iter_515_5.color.r, arg_512_1.hightColor2.r, (arg_512_1.time_ - 0) / var_515_3), Mathf.Lerp(iter_515_5.color.g, arg_512_1.hightColor2.g, (arg_512_1.time_ - 0) / var_515_3), (Mathf.Lerp(iter_515_5.color.b, arg_512_1.hightColor2.b, (arg_512_1.time_ - 0) / var_515_3)))
							else
								local var_515_4 = Mathf.Lerp(iter_515_5.color.r, 0.5, (arg_512_1.time_ - 0) / var_515_3)

								iter_515_5.color = Color.New(var_515_4, var_515_4, var_515_4)
							end
						end
					end
				end
			end

			if arg_512_1.time_ >= 0 + var_515_3 and arg_512_1.time_ < 0 + var_515_3 + arg_515_0 and not isNil(var_515_2) and arg_512_1.var_.actorSpriteComps104701 then
				for iter_515_6, iter_515_7 in pairs(arg_512_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_515_7 then
						iter_515_7.color = arg_512_1.isInRecall_ and (arg_512_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_512_1.var_.actorSpriteComps104701 = nil
			end

			local var_515_5 = arg_512_1.actors_["104701"].transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos104701 = var_515_5.localPosition
				var_515_5.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("104701", 3)

				for iter_515_8 = 0, var_515_5.childCount - 1 do
					local var_515_6 = var_515_5:GetChild(iter_515_8)

					if var_515_6.name == "split_4" or not string.find(var_515_6.name, "split") then
						var_515_6.gameObject:SetActive(true)
					else
						var_515_6.gameObject:SetActive(false)
					end
				end
			end

			local var_515_7 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_7 then
				var_515_5.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_512_1.time_ - 0) / var_515_7)
			end

			if arg_512_1.time_ >= 0 + var_515_7 and arg_512_1.time_ < 0 + var_515_7 + arg_515_0 then
				var_515_5.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_515_8 = arg_512_1.actors_["10144"].transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos10144 = var_515_8.localPosition
				var_515_8.localScale = Vector3.New(1, 1, 1)

				arg_512_1:CheckSpriteTmpPos("10144", 3)

				for iter_515_9 = 0, var_515_8.childCount - 1 do
					local var_515_9 = var_515_8:GetChild(iter_515_9)

					if var_515_9.name == "split_1" or not string.find(var_515_9.name, "split") then
						var_515_9.gameObject:SetActive(true)
					else
						var_515_9.gameObject:SetActive(false)
					end
				end
			end

			local var_515_10 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_10 then
				var_515_8.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_512_1.time_ - 0) / var_515_10)
			end

			if arg_512_1.time_ >= 0 + var_515_10 and arg_512_1.time_ < 0 + var_515_10 + arg_515_0 then
				var_515_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_515_11 = 0
			local var_515_12 = 0.7

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_11 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_13 = arg_512_1:GetWordFromCfg(926021125)
				local var_515_14 = arg_512_1:FormatText(var_515_13.content)

				arg_512_1.text_.text = var_515_14

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_16 = 28 <= 0 and var_515_12 or var_515_12 * (utf8.len(var_515_14) / 28)

				if (28 <= 0 and var_515_12 or var_515_12 * (utf8.len(var_515_14) / 28)) > 0 and var_515_12 < var_515_16 then
					arg_512_1.talkMaxDuration = var_515_16

					if var_515_16 + var_515_11 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_16 + var_515_11
					end
				end

				arg_512_1.text_.text = var_515_14
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021125", "story_v_out_926021.awb") ~= 0 then
					local var_515_17 = manager.audio:GetVoiceLength("story_v_out_926021", "926021125", "story_v_out_926021.awb") / 1000

					if var_515_17 + var_515_11 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_17 + var_515_11
					end

					if var_515_13.prefab_name ~= "" and arg_512_1.actors_[var_515_13.prefab_name] ~= nil then
						local var_515_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_13.prefab_name].transform, "story_v_out_926021", "926021125", "story_v_out_926021.awb")

						arg_512_1:RecordAudio("926021125", var_515_18)
						arg_512_1:RecordAudio("926021125", var_515_18)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_926021", "926021125", "story_v_out_926021.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_926021", "926021125", "story_v_out_926021.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_19 = math.max(var_515_12, arg_512_1.talkMaxDuration)

			if var_515_11 <= arg_512_1.time_ and arg_512_1.time_ < var_515_11 + var_515_19 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_11) / var_515_19

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_11 + var_515_19 and arg_512_1.time_ < var_515_11 + var_515_19 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play926021126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 926021126
		arg_516_1.duration_ = 4.23

		local var_516_0 = {
			zh = 3.633,
			ja = 4.233
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play926021127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos10144 = arg_516_1.actors_["10144"].transform.localPosition
				arg_516_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_516_1:CheckSpriteTmpPos("10144", 3)

				for iter_519_0 = 0, arg_516_1.actors_["10144"].transform.childCount - 1 do
					local var_519_0 = arg_516_1.actors_["10144"].transform:GetChild(iter_519_0)

					if var_519_0.name == "split_4" or not string.find(var_519_0.name, "split") then
						var_519_0.gameObject:SetActive(true)
					else
						var_519_0.gameObject:SetActive(false)
					end
				end
			end

			local var_519_1 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_1 then
				arg_516_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_516_1.time_ - 0) / var_519_1)
			end

			if arg_516_1.time_ >= 0 + var_519_1 and arg_516_1.time_ < 0 + var_519_1 + arg_519_0 then
				arg_516_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_519_2 = 0
			local var_519_3 = 0.525

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_2 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_4 = arg_516_1:GetWordFromCfg(926021126)
				local var_519_5 = arg_516_1:FormatText(var_519_4.content)

				arg_516_1.text_.text = var_519_5

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_7 = 21 <= 0 and var_519_3 or var_519_3 * (utf8.len(var_519_5) / 21)

				if (21 <= 0 and var_519_3 or var_519_3 * (utf8.len(var_519_5) / 21)) > 0 and var_519_3 < var_519_7 then
					arg_516_1.talkMaxDuration = var_519_7

					if var_519_7 + var_519_2 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_7 + var_519_2
					end
				end

				arg_516_1.text_.text = var_519_5
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926021", "926021126", "story_v_out_926021.awb") ~= 0 then
					local var_519_8 = manager.audio:GetVoiceLength("story_v_out_926021", "926021126", "story_v_out_926021.awb") / 1000

					if var_519_8 + var_519_2 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_8 + var_519_2
					end

					if var_519_4.prefab_name ~= "" and arg_516_1.actors_[var_519_4.prefab_name] ~= nil then
						local var_519_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_4.prefab_name].transform, "story_v_out_926021", "926021126", "story_v_out_926021.awb")

						arg_516_1:RecordAudio("926021126", var_519_9)
						arg_516_1:RecordAudio("926021126", var_519_9)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_926021", "926021126", "story_v_out_926021.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_926021", "926021126", "story_v_out_926021.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_10 = math.max(var_519_3, arg_516_1.talkMaxDuration)

			if var_519_2 <= arg_516_1.time_ and arg_516_1.time_ < var_519_2 + var_519_10 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_2) / var_519_10

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_2 + var_519_10 and arg_516_1.time_ < var_519_2 + var_519_10 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play926021127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 926021127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play926021128(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(arg_520_1.actors_["10144"]) and arg_520_1.var_.actorSpriteComps10144 == nil then
				arg_520_1.var_.actorSpriteComps10144 = arg_520_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_523_0 = 0.2

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 and not isNil(arg_520_1.actors_["10144"]) then
				if arg_520_1.var_.actorSpriteComps10144 then
					for iter_523_0, iter_523_1 in pairs(arg_520_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_523_1 then
							if arg_520_1.isInRecall_ then
								iter_523_1.color = Color.New(Mathf.Lerp(iter_523_1.color.r, arg_520_1.hightColor2.r, (arg_520_1.time_ - 0) / var_523_0), Mathf.Lerp(iter_523_1.color.g, arg_520_1.hightColor2.g, (arg_520_1.time_ - 0) / var_523_0), (Mathf.Lerp(iter_523_1.color.b, arg_520_1.hightColor2.b, (arg_520_1.time_ - 0) / var_523_0)))
							else
								local var_523_1 = Mathf.Lerp(iter_523_1.color.r, 0.5, (arg_520_1.time_ - 0) / var_523_0)

								iter_523_1.color = Color.New(var_523_1, var_523_1, var_523_1)
							end
						end
					end
				end
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 and not isNil(arg_520_1.actors_["10144"]) and arg_520_1.var_.actorSpriteComps10144 then
				for iter_523_2, iter_523_3 in pairs(arg_520_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_523_3 then
						iter_523_3.color = arg_520_1.isInRecall_ and (arg_520_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_520_1.var_.actorSpriteComps10144 = nil
			end

			local var_523_2 = 0
			local var_523_3 = 0.325

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_2 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_4 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(926021127).content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_6 = 13 <= 0 and var_523_3 or var_523_3 * (utf8.len(var_523_4) / 13)

				if (13 <= 0 and var_523_3 or var_523_3 * (utf8.len(var_523_4) / 13)) > 0 and var_523_3 < var_523_6 then
					arg_520_1.talkMaxDuration = var_523_6

					if var_523_6 + var_523_2 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_6 + var_523_2
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_3, arg_520_1.talkMaxDuration)

			if var_523_2 <= arg_520_1.time_ and arg_520_1.time_ < var_523_2 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_2) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_2 + var_523_7 and arg_520_1.time_ < var_523_2 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play926021128 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 926021128
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
			arg_524_1.auto_ = false
		end

		function arg_524_1.playNext_(arg_526_0)
			arg_524_1.onStoryFinished_()
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.575

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_1 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(926021128).content)

				arg_524_1.text_.text = var_527_1

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_3 = 23 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 23)

				if (23 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 23)) > 0 and var_527_0 < var_527_3 then
					arg_524_1.talkMaxDuration = var_527_3

					if var_527_3 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_3 + 0
					end
				end

				arg_524_1.text_.text = var_527_1
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_4 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_4

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I22g",
		"TextureConfig/Background/ST0108",
		"TextureConfig/Background/ST0114"
	},
	voices = {
		"story_v_out_926021.awb"
	}
}
