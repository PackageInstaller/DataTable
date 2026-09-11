return {
	Play123121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K05g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05g")
				var_4_0.name = "K05g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K05g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K05g

				arg_1_1.bgs_.K05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K05g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.975

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123121001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 39 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 39)

				if (39 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 39)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play123121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123121002
		arg_9_1.duration_ = 3.2

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1055ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1055ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1055ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1055ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1055ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1055ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1055ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1055ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1055ui_story == nil then
				arg_9_1.var_.characterEffect1055ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1055ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1055ui_story then
				arg_9_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(123121002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 11 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 11)

				if (11 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 11)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121002", "story_v_out_123121.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_123121", "123121002", "story_v_out_123121.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_123121", "123121002", "story_v_out_123121.awb")

						arg_9_1:RecordAudio("123121002", var_12_15)
						arg_9_1:RecordAudio("123121002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_123121", "123121002", "story_v_out_123121.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_123121", "123121002", "story_v_out_123121.awb")
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play123121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123121003
		arg_13_1.duration_ = 10.33

		local var_13_0 = {
			zh = 10.333,
			ja = 8.1
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
				arg_13_0:Play123121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1055ui_story"]) and arg_13_1.var_.characterEffect1055ui_story == nil then
				arg_13_1.var_.characterEffect1055ui_story = arg_13_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1055ui_story"]) then
				if arg_13_1.var_.characterEffect1055ui_story and not isNil(arg_13_1.actors_["1055ui_story"]) then
					arg_13_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1055ui_story"]) and arg_13_1.var_.characterEffect1055ui_story then
				arg_13_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 1.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(123121003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 51 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 51)

				if (51 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 51)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121003", "story_v_out_123121.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121003", "story_v_out_123121.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_123121", "123121003", "story_v_out_123121.awb")

						arg_13_1:RecordAudio("123121003", var_16_8)
						arg_13_1:RecordAudio("123121003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_123121", "123121003", "story_v_out_123121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_123121", "123121003", "story_v_out_123121.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123121004
		arg_17_1.duration_ = 3.4

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play123121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1055ui_story"]) and arg_17_1.var_.characterEffect1055ui_story == nil then
				arg_17_1.var_.characterEffect1055ui_story = arg_17_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1055ui_story"]) then
				if arg_17_1.var_.characterEffect1055ui_story and not isNil(arg_17_1.actors_["1055ui_story"]) then
					arg_17_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1055ui_story"]) and arg_17_1.var_.characterEffect1055ui_story then
				arg_17_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(123121004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 8 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 8)

				if (8 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 8)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121004", "story_v_out_123121.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121004", "story_v_out_123121.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_123121", "123121004", "story_v_out_123121.awb")

						arg_17_1:RecordAudio("123121004", var_20_9)
						arg_17_1:RecordAudio("123121004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123121", "123121004", "story_v_out_123121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123121", "123121004", "story_v_out_123121.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play123121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123121005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1055ui_story"]) and arg_21_1.var_.characterEffect1055ui_story == nil then
				arg_21_1.var_.characterEffect1055ui_story = arg_21_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1055ui_story"]) then
				if arg_21_1.var_.characterEffect1055ui_story and not isNil(arg_21_1.actors_["1055ui_story"]) then
					arg_21_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1055ui_story"]) and arg_21_1.var_.characterEffect1055ui_story then
				arg_21_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.775

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(123121005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 31 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 31)

				if (31 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 31)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123121006
		arg_25_1.duration_ = 3.13

		local var_25_0 = {
			zh = 3.133,
			ja = 2.733
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
				arg_25_0:Play123121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(123121006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 14 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 14)

				if (14 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 14)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121006", "story_v_out_123121.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121006", "story_v_out_123121.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_123121", "123121006", "story_v_out_123121.awb")

						arg_25_1:RecordAudio("123121006", var_28_6)
						arg_25_1:RecordAudio("123121006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_123121", "123121006", "story_v_out_123121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_123121", "123121006", "story_v_out_123121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play123121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123121007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1055ui_story = arg_29_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1055ui_story"].transform.position).z)
				arg_29_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1055ui_story"].transform.localEulerAngles = arg_29_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1055ui_story"].transform.position).z)
				arg_29_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1055ui_story"].transform.localEulerAngles = arg_29_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1055ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1055ui_story == nil then
				arg_29_1.var_.characterEffect1055ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1055ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_2)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1055ui_story then
				arg_29_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_32_3 = 0
			local var_32_4 = 0.625

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(123121007).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 25 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 25)

				if (25 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 25)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play123121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123121008
		arg_33_1.duration_ = 9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.K06g == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06g")
				var_36_0.name = "K06g"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.K06g = var_36_0
			end

			if 1.999999999999 < arg_33_1.time_ and arg_33_1.time_ <= 1.999999999999 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.K06g

				arg_33_1.bgs_.K06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "K06g" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 2

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = 1
				arg_33_1.mask_.color = var_36_7
			end

			local var_36_8 = 2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 then
				local var_36_10 = Color.New(0, 0, 0)

				var_36_10.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_8) / var_36_9)
				arg_33_1.mask_.color = var_36_10
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 then
				local var_36_11 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_11.a = 0
				arg_33_1.mask_.color = var_36_11
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_12 = 4
			local var_36_13 = 1.4

			if 4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_14 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_14:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(123121008).content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 56 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 56)

				if (56 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 56)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17
					var_36_12 = var_36_12 + 0.3

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = var_36_12 + 0.3
			local var_36_19 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_19 and arg_33_1.time_ < var_36_18 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123121009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 123121009
		arg_39_1.duration_ = 6.37

		local var_39_0 = {
			zh = 4.6,
			ja = 6.366
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play123121010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1055ui_story = arg_39_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1055ui_story"].transform.position).z)
				arg_39_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1055ui_story"].transform.localEulerAngles = arg_39_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_39_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1055ui_story"].transform.position).z)
				arg_39_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1055ui_story"].transform.localEulerAngles = arg_39_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1055ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1055ui_story == nil then
				arg_39_1.var_.characterEffect1055ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1055ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1055ui_story then
				arg_39_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_42_4 = 0
			local var_42_5 = 0.625

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(123121009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 25 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 25)

				if (25 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 25)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121009", "story_v_out_123121.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121009", "story_v_out_123121.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_123121", "123121009", "story_v_out_123121.awb")

						arg_39_1:RecordAudio("123121009", var_42_11)
						arg_39_1:RecordAudio("123121009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_123121", "123121009", "story_v_out_123121.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_123121", "123121009", "story_v_out_123121.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play123121010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 123121010
		arg_43_1.duration_ = 7.13

		local var_43_0 = {
			zh = 6.2,
			ja = 7.133
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play123121011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1055ui_story"]) and arg_43_1.var_.characterEffect1055ui_story == nil then
				arg_43_1.var_.characterEffect1055ui_story = arg_43_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1055ui_story"]) then
				if arg_43_1.var_.characterEffect1055ui_story and not isNil(arg_43_1.actors_["1055ui_story"]) then
					arg_43_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1055ui_story"]) and arg_43_1.var_.characterEffect1055ui_story then
				arg_43_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.45

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:GetWordFromCfg(123121010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 18 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 18)

				if (18 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 18)) > 0 and var_46_2 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121010", "story_v_out_123121.awb") ~= 0 then
					local var_46_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121010", "story_v_out_123121.awb") / 1000

					if var_46_7 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_1
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_123121", "123121010", "story_v_out_123121.awb")

						arg_43_1:RecordAudio("123121010", var_46_8)
						arg_43_1:RecordAudio("123121010", var_46_8)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_123121", "123121010", "story_v_out_123121.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_123121", "123121010", "story_v_out_123121.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_9 and arg_43_1.time_ < var_46_1 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play123121011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 123121011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play123121012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(123121011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 21 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 21)

				if (21 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 21)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play123121012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 123121012
		arg_51_1.duration_ = 6.07

		local var_51_0 = {
			zh = 4.633,
			ja = 6.066
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play123121013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1055ui_story"]) and arg_51_1.var_.characterEffect1055ui_story == nil then
				arg_51_1.var_.characterEffect1055ui_story = arg_51_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1055ui_story"]) then
				if arg_51_1.var_.characterEffect1055ui_story and not isNil(arg_51_1.actors_["1055ui_story"]) then
					arg_51_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1055ui_story"]) and arg_51_1.var_.characterEffect1055ui_story then
				arg_51_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_54_2 = 0
			local var_54_3 = 0.5

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(123121012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 20 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 20)

				if (20 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 20)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121012", "story_v_out_123121.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121012", "story_v_out_123121.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_123121", "123121012", "story_v_out_123121.awb")

						arg_51_1:RecordAudio("123121012", var_54_9)
						arg_51_1:RecordAudio("123121012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_123121", "123121012", "story_v_out_123121.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_123121", "123121012", "story_v_out_123121.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play123121013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 123121013
		arg_55_1.duration_ = 17.93

		local var_55_0 = {
			zh = 13.566,
			ja = 17.933
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play123121014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1055ui_story"]) and arg_55_1.var_.characterEffect1055ui_story == nil then
				arg_55_1.var_.characterEffect1055ui_story = arg_55_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1055ui_story"]) then
				if arg_55_1.var_.characterEffect1055ui_story and not isNil(arg_55_1.actors_["1055ui_story"]) then
					arg_55_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1055ui_story"]) and arg_55_1.var_.characterEffect1055ui_story then
				arg_55_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 1.35

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:GetWordFromCfg(123121013)
				local var_58_4 = arg_55_1:FormatText(var_58_3.content)

				arg_55_1.text_.text = var_58_4

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_6 = 54 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_4) / 54)

				if (54 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_4) / 54)) > 0 and var_58_2 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_4
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121013", "story_v_out_123121.awb") ~= 0 then
					local var_58_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121013", "story_v_out_123121.awb") / 1000

					if var_58_7 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_7 + var_58_1
					end

					if var_58_3.prefab_name ~= "" and arg_55_1.actors_[var_58_3.prefab_name] ~= nil then
						local var_58_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_3.prefab_name].transform, "story_v_out_123121", "123121013", "story_v_out_123121.awb")

						arg_55_1:RecordAudio("123121013", var_58_8)
						arg_55_1:RecordAudio("123121013", var_58_8)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_123121", "123121013", "story_v_out_123121.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_123121", "123121013", "story_v_out_123121.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_9 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_9 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_9

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_9 and arg_55_1.time_ < var_58_1 + var_58_9 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play123121014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 123121014
		arg_59_1.duration_ = 2.93

		local var_59_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play123121015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1055ui_story"]) and arg_59_1.var_.characterEffect1055ui_story == nil then
				arg_59_1.var_.characterEffect1055ui_story = arg_59_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1055ui_story"]) then
				if arg_59_1.var_.characterEffect1055ui_story and not isNil(arg_59_1.actors_["1055ui_story"]) then
					arg_59_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1055ui_story"]) and arg_59_1.var_.characterEffect1055ui_story then
				arg_59_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_62_2 = 0
			local var_62_3 = 0.075

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(123121014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 3 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 3)

				if (3 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 3)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121014", "story_v_out_123121.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121014", "story_v_out_123121.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_123121", "123121014", "story_v_out_123121.awb")

						arg_59_1:RecordAudio("123121014", var_62_9)
						arg_59_1:RecordAudio("123121014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_123121", "123121014", "story_v_out_123121.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_123121", "123121014", "story_v_out_123121.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play123121015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 123121015
		arg_63_1.duration_ = 9.37

		local var_63_0 = {
			zh = 9,
			ja = 9.366
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play123121016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1055ui_story"]) and arg_63_1.var_.characterEffect1055ui_story == nil then
				arg_63_1.var_.characterEffect1055ui_story = arg_63_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1055ui_story"]) then
				if arg_63_1.var_.characterEffect1055ui_story and not isNil(arg_63_1.actors_["1055ui_story"]) then
					arg_63_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1055ui_story"]) and arg_63_1.var_.characterEffect1055ui_story then
				arg_63_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_66_1 = 0
			local var_66_2 = 0.925

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(123121015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_6 = 37 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 37)

				if (37 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_4) / 37)) > 0 and var_66_2 < var_66_6 then
					arg_63_1.talkMaxDuration = var_66_6

					if var_66_6 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121015", "story_v_out_123121.awb") ~= 0 then
					local var_66_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121015", "story_v_out_123121.awb") / 1000

					if var_66_7 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_1
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_123121", "123121015", "story_v_out_123121.awb")

						arg_63_1:RecordAudio("123121015", var_66_8)
						arg_63_1:RecordAudio("123121015", var_66_8)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_123121", "123121015", "story_v_out_123121.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_123121", "123121015", "story_v_out_123121.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_9 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_9 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_9

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_9 and arg_63_1.time_ < var_66_1 + var_66_9 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play123121016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 123121016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play123121017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(123121016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 9 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 9)

				if (9 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 9)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play123121017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 123121017
		arg_71_1.duration_ = 11.8

		local var_71_0 = {
			zh = 11.733,
			ja = 11.8
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play123121018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.25

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(123121017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 50 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 50)

				if (50 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 50)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121017", "story_v_out_123121.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121017", "story_v_out_123121.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_123121", "123121017", "story_v_out_123121.awb")

						arg_71_1:RecordAudio("123121017", var_74_6)
						arg_71_1:RecordAudio("123121017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_123121", "123121017", "story_v_out_123121.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_123121", "123121017", "story_v_out_123121.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play123121018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 123121018
		arg_75_1.duration_ = 9.93

		local var_75_0 = {
			zh = 9.666,
			ja = 9.933
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play123121019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.05

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:GetWordFromCfg(123121018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 42 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 42)

				if (42 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 42)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121018", "story_v_out_123121.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121018", "story_v_out_123121.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_123121", "123121018", "story_v_out_123121.awb")

						arg_75_1:RecordAudio("123121018", var_78_6)
						arg_75_1:RecordAudio("123121018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_123121", "123121018", "story_v_out_123121.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_123121", "123121018", "story_v_out_123121.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play123121019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 123121019
		arg_79_1.duration_ = 10.2

		local var_79_0 = {
			zh = 8.7,
			ja = 10.2
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play123121020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1055ui_story"]) and arg_79_1.var_.characterEffect1055ui_story == nil then
				arg_79_1.var_.characterEffect1055ui_story = arg_79_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1055ui_story"]) then
				if arg_79_1.var_.characterEffect1055ui_story and not isNil(arg_79_1.actors_["1055ui_story"]) then
					arg_79_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1055ui_story"]) and arg_79_1.var_.characterEffect1055ui_story then
				arg_79_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_82_2 = 0
			local var_82_3 = 1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(123121019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 40 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 40)

				if (40 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 40)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121019", "story_v_out_123121.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121019", "story_v_out_123121.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_123121", "123121019", "story_v_out_123121.awb")

						arg_79_1:RecordAudio("123121019", var_82_9)
						arg_79_1:RecordAudio("123121019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_123121", "123121019", "story_v_out_123121.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_123121", "123121019", "story_v_out_123121.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play123121020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 123121020
		arg_83_1.duration_ = 12.63

		local var_83_0 = {
			zh = 12.633,
			ja = 7.633
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play123121021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1055ui_story"]) and arg_83_1.var_.characterEffect1055ui_story == nil then
				arg_83_1.var_.characterEffect1055ui_story = arg_83_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1055ui_story"]) then
				if arg_83_1.var_.characterEffect1055ui_story and not isNil(arg_83_1.actors_["1055ui_story"]) then
					arg_83_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1055ui_story"]) and arg_83_1.var_.characterEffect1055ui_story then
				arg_83_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 1.175

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(123121020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 48 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 48)

				if (48 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 48)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121020", "story_v_out_123121.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121020", "story_v_out_123121.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_123121", "123121020", "story_v_out_123121.awb")

						arg_83_1:RecordAudio("123121020", var_86_8)
						arg_83_1:RecordAudio("123121020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_123121", "123121020", "story_v_out_123121.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_123121", "123121020", "story_v_out_123121.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play123121021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 123121021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play123121022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.375

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(123121021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 15 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 15)

				if (15 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 15)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play123121022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 123121022
		arg_91_1.duration_ = 6.07

		local var_91_0 = {
			zh = 6.066,
			ja = 5.233
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play123121023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1055ui_story"]) and arg_91_1.var_.characterEffect1055ui_story == nil then
				arg_91_1.var_.characterEffect1055ui_story = arg_91_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1055ui_story"]) then
				if arg_91_1.var_.characterEffect1055ui_story and not isNil(arg_91_1.actors_["1055ui_story"]) then
					arg_91_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1055ui_story"]) and arg_91_1.var_.characterEffect1055ui_story then
				arg_91_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_2")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_94_2 = 0
			local var_94_3 = 0.725

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(123121022)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 29 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 29)

				if (29 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 29)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121022", "story_v_out_123121.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121022", "story_v_out_123121.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_123121", "123121022", "story_v_out_123121.awb")

						arg_91_1:RecordAudio("123121022", var_94_9)
						arg_91_1:RecordAudio("123121022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_123121", "123121022", "story_v_out_123121.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_123121", "123121022", "story_v_out_123121.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play123121023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 123121023
		arg_95_1.duration_ = 10.1

		local var_95_0 = {
			zh = 9.966,
			ja = 10.1
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play123121024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1055ui_story"]) and arg_95_1.var_.characterEffect1055ui_story == nil then
				arg_95_1.var_.characterEffect1055ui_story = arg_95_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1055ui_story"]) then
				if arg_95_1.var_.characterEffect1055ui_story and not isNil(arg_95_1.actors_["1055ui_story"]) then
					arg_95_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1055ui_story"]) and arg_95_1.var_.characterEffect1055ui_story then
				arg_95_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 1.125

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(123121023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 45 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_4) / 45)

				if (45 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_4) / 45)) > 0 and var_98_2 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121023", "story_v_out_123121.awb") ~= 0 then
					local var_98_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121023", "story_v_out_123121.awb") / 1000

					if var_98_7 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_1
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_123121", "123121023", "story_v_out_123121.awb")

						arg_95_1:RecordAudio("123121023", var_98_8)
						arg_95_1:RecordAudio("123121023", var_98_8)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_123121", "123121023", "story_v_out_123121.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_123121", "123121023", "story_v_out_123121.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_9 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_9 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_9

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_9 and arg_95_1.time_ < var_98_1 + var_98_9 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play123121024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 123121024
		arg_99_1.duration_ = 7.2

		local var_99_0 = {
			zh = 6.466,
			ja = 7.2
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play123121025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.5

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(123121024)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 20 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 20)

				if (20 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 20)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121024", "story_v_out_123121.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121024", "story_v_out_123121.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_123121", "123121024", "story_v_out_123121.awb")

						arg_99_1:RecordAudio("123121024", var_102_6)
						arg_99_1:RecordAudio("123121024", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_123121", "123121024", "story_v_out_123121.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_123121", "123121024", "story_v_out_123121.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play123121025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 123121025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play123121026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1055ui_story = arg_103_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1055ui_story"].transform.position).z)
				arg_103_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1055ui_story"].transform.localEulerAngles = arg_103_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1055ui_story"].transform.position).z)
				arg_103_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1055ui_story"].transform.localEulerAngles = arg_103_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1055ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1055ui_story == nil then
				arg_103_1.var_.characterEffect1055ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1055ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_2)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1055ui_story then
				arg_103_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_106_3 = 0
			local var_106_4 = 0.375

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_5 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(123121025).content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 15 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 15)

				if (15 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 15)) > 0 and var_106_4 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_8 and arg_103_1.time_ < var_106_3 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play123121026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 123121026
		arg_107_1.duration_ = 3.83

		local var_107_0 = {
			zh = 3.833,
			ja = 3.366
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play123121027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.35

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(123121026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 14 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 14)

				if (14 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 14)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121026", "story_v_out_123121.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121026", "story_v_out_123121.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_123121", "123121026", "story_v_out_123121.awb")

						arg_107_1:RecordAudio("123121026", var_110_6)
						arg_107_1:RecordAudio("123121026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_123121", "123121026", "story_v_out_123121.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_123121", "123121026", "story_v_out_123121.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play123121027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 123121027
		arg_111_1.duration_ = 12.77

		local var_111_0 = {
			zh = 12.766,
			ja = 10.633
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play123121028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.65

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(123121027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 66 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 66)

				if (66 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 66)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121027", "story_v_out_123121.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121027", "story_v_out_123121.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_123121", "123121027", "story_v_out_123121.awb")

						arg_111_1:RecordAudio("123121027", var_114_6)
						arg_111_1:RecordAudio("123121027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_123121", "123121027", "story_v_out_123121.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_123121", "123121027", "story_v_out_123121.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play123121028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 123121028
		arg_115_1.duration_ = 2.13

		local var_115_0 = {
			zh = 2.133,
			ja = 1.999999999999
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play123121029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1055ui_story = arg_115_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1055ui_story"].transform.position).z)
				arg_115_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1055ui_story"].transform.localEulerAngles = arg_115_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_115_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1055ui_story"].transform.position).z)
				arg_115_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1055ui_story"].transform.localEulerAngles = arg_115_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1055ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1055ui_story == nil then
				arg_115_1.var_.characterEffect1055ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1055ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1055ui_story then
				arg_115_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.15

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(123121028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 6 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 6)

				if (6 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 6)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121028", "story_v_out_123121.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121028", "story_v_out_123121.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_123121", "123121028", "story_v_out_123121.awb")

						arg_115_1:RecordAudio("123121028", var_118_11)
						arg_115_1:RecordAudio("123121028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_123121", "123121028", "story_v_out_123121.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_123121", "123121028", "story_v_out_123121.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play123121029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 123121029
		arg_119_1.duration_ = 18.43

		local var_119_0 = {
			zh = 18.433,
			ja = 16.933
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play123121030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1055ui_story = arg_119_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).z)
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles = arg_119_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).z)
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles = arg_119_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1055ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1055ui_story == nil then
				arg_119_1.var_.characterEffect1055ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1055ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_2)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1055ui_story then
				arg_119_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_122_3 = 0
			local var_122_4 = 2.025

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_5 = arg_119_1:GetWordFromCfg(123121029)
				local var_122_6 = arg_119_1:FormatText(var_122_5.content)

				arg_119_1.text_.text = var_122_6

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_8 = 81 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_6) / 81)

				if (81 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_6) / 81)) > 0 and var_122_4 < var_122_8 then
					arg_119_1.talkMaxDuration = var_122_8

					if var_122_8 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_3
					end
				end

				arg_119_1.text_.text = var_122_6
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121029", "story_v_out_123121.awb") ~= 0 then
					local var_122_9 = manager.audio:GetVoiceLength("story_v_out_123121", "123121029", "story_v_out_123121.awb") / 1000

					if var_122_9 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_3
					end

					if var_122_5.prefab_name ~= "" and arg_119_1.actors_[var_122_5.prefab_name] ~= nil then
						local var_122_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_5.prefab_name].transform, "story_v_out_123121", "123121029", "story_v_out_123121.awb")

						arg_119_1:RecordAudio("123121029", var_122_10)
						arg_119_1:RecordAudio("123121029", var_122_10)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_123121", "123121029", "story_v_out_123121.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_123121", "123121029", "story_v_out_123121.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_11 = math.max(var_122_4, arg_119_1.talkMaxDuration)

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_11 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_3) / var_122_11

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_3 + var_122_11 and arg_119_1.time_ < var_122_3 + var_122_11 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play123121030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 123121030
		arg_123_1.duration_ = 16.77

		local var_123_0 = {
			zh = 16.766,
			ja = 15.133
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play123121031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.675

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(123121030)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 67 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 67)

				if (67 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 67)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121030", "story_v_out_123121.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121030", "story_v_out_123121.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_123121", "123121030", "story_v_out_123121.awb")

						arg_123_1:RecordAudio("123121030", var_126_6)
						arg_123_1:RecordAudio("123121030", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_123121", "123121030", "story_v_out_123121.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_123121", "123121030", "story_v_out_123121.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play123121031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 123121031
		arg_127_1.duration_ = 6.73

		local var_127_0 = {
			zh = 6.733,
			ja = 6.366
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play123121032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.825

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(123121031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 33 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 33)

				if (33 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 33)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121031", "story_v_out_123121.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121031", "story_v_out_123121.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_123121", "123121031", "story_v_out_123121.awb")

						arg_127_1:RecordAudio("123121031", var_130_6)
						arg_127_1:RecordAudio("123121031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_123121", "123121031", "story_v_out_123121.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_123121", "123121031", "story_v_out_123121.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play123121032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 123121032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play123121033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.675

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(123121032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 27 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 27)

				if (27 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 27)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play123121033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 123121033
		arg_135_1.duration_ = 2.2

		local var_135_0 = {
			zh = 1.633,
			ja = 2.2
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play123121034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.125

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(123121033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 5 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 5)

				if (5 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 5)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121033", "story_v_out_123121.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121033", "story_v_out_123121.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_123121", "123121033", "story_v_out_123121.awb")

						arg_135_1:RecordAudio("123121033", var_138_6)
						arg_135_1:RecordAudio("123121033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_123121", "123121033", "story_v_out_123121.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_123121", "123121033", "story_v_out_123121.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play123121034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 123121034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play123121035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.45

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(123121034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 18 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 18)

				if (18 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 18)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play123121035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 123121035
		arg_143_1.duration_ = 5.4

		local var_143_0 = {
			zh = 4.866,
			ja = 5.4
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play123121036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.475

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(123121035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 19 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 19)

				if (19 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 19)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121035", "story_v_out_123121.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121035", "story_v_out_123121.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_123121", "123121035", "story_v_out_123121.awb")

						arg_143_1:RecordAudio("123121035", var_146_6)
						arg_143_1:RecordAudio("123121035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_123121", "123121035", "story_v_out_123121.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_123121", "123121035", "story_v_out_123121.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play123121036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 123121036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play123121037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.175

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(123121036).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 7 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 7)

				if (7 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 7)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play123121037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 123121037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play123121038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.825

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(123121037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 33 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 33)

				if (33 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 33)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play123121038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 123121038
		arg_155_1.duration_ = 11.77

		local var_155_0 = {
			zh = 8.666,
			ja = 11.766
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play123121039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.725

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(123121038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 29 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 29)

				if (29 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 29)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121038", "story_v_out_123121.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121038", "story_v_out_123121.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_123121", "123121038", "story_v_out_123121.awb")

						arg_155_1:RecordAudio("123121038", var_158_6)
						arg_155_1:RecordAudio("123121038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_123121", "123121038", "story_v_out_123121.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_123121", "123121038", "story_v_out_123121.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play123121039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 123121039
		arg_159_1.duration_ = 7.67

		local var_159_0 = {
			zh = 7.533,
			ja = 7.666
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play123121040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if arg_159_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_162_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_159_1.stage_.transform)

				var_162_0.name = "1093ui_story"
				var_162_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["1093ui_story"] = var_162_0

				local var_162_1 = var_162_0:GetComponentInChildren(typeof(CharacterEffect))

				var_162_1.enabled = true

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end

				arg_159_1:ShowWeapon(var_162_1.transform, false)

				arg_159_1.var_["1093ui_story" .. "Animator"] = var_162_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_159_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_159_1.var_["1093ui_story" .. "LipSync"] = var_162_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_162_3 = arg_159_1.actors_["1093ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1093ui_story = var_162_3.localPosition
			end

			local var_162_4 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_159_1.time_ - 0) / var_162_4)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			local var_162_5 = arg_159_1.actors_["1093ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect1093ui_story == nil then
				arg_159_1.var_.characterEffect1093ui_story = var_162_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_6 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_6 and not isNil(var_162_5) then
				if arg_159_1.var_.characterEffect1093ui_story and not isNil(var_162_5) then
					arg_159_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_6 and arg_159_1.time_ < 0 + var_162_6 + arg_162_0 and not isNil(var_162_5) and arg_159_1.var_.characterEffect1093ui_story then
				arg_159_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_162_8 = 0
			local var_162_9 = 0.85

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(123121039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 34 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 34)

				if (34 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 34)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121039", "story_v_out_123121.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_123121", "123121039", "story_v_out_123121.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_123121", "123121039", "story_v_out_123121.awb")

						arg_159_1:RecordAudio("123121039", var_162_15)
						arg_159_1:RecordAudio("123121039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_123121", "123121039", "story_v_out_123121.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_123121", "123121039", "story_v_out_123121.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play123121040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 123121040
		arg_163_1.duration_ = 9.83

		local var_163_0 = {
			zh = 9.833,
			ja = 8.333
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play123121041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1093ui_story = arg_163_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1093ui_story"].transform.position).z)
				arg_163_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1093ui_story"].transform.localEulerAngles = arg_163_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1093ui_story"].transform.position).z)
				arg_163_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1093ui_story"].transform.localEulerAngles = arg_163_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1093ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1093ui_story == nil then
				arg_163_1.var_.characterEffect1093ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1093ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_2)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1093ui_story then
				arg_163_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_166_3 = 0
			local var_166_4 = 1.15

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_5 = arg_163_1:GetWordFromCfg(123121040)
				local var_166_6 = arg_163_1:FormatText(var_166_5.content)

				arg_163_1.text_.text = var_166_6

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_8 = 46 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_6) / 46)

				if (46 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_6) / 46)) > 0 and var_166_4 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_6
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121040", "story_v_out_123121.awb") ~= 0 then
					local var_166_9 = manager.audio:GetVoiceLength("story_v_out_123121", "123121040", "story_v_out_123121.awb") / 1000

					if var_166_9 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_3
					end

					if var_166_5.prefab_name ~= "" and arg_163_1.actors_[var_166_5.prefab_name] ~= nil then
						local var_166_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_5.prefab_name].transform, "story_v_out_123121", "123121040", "story_v_out_123121.awb")

						arg_163_1:RecordAudio("123121040", var_166_10)
						arg_163_1:RecordAudio("123121040", var_166_10)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_123121", "123121040", "story_v_out_123121.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_123121", "123121040", "story_v_out_123121.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_11 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_11 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_3) / var_166_11

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_3 + var_166_11 and arg_163_1.time_ < var_166_3 + var_166_11 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play123121041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 123121041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play123121042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.425

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(123121041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 57 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 57)

				if (57 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 57)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play123121042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 123121042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play123121043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.05

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(123121042).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 42 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 42)

				if (42 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 42)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play123121043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 123121043
		arg_175_1.duration_ = 8.73

		local var_175_0 = {
			zh = 4.533,
			ja = 8.733
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play123121044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(123121043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121043", "story_v_out_123121.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121043", "story_v_out_123121.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_123121", "123121043", "story_v_out_123121.awb")

						arg_175_1:RecordAudio("123121043", var_178_6)
						arg_175_1:RecordAudio("123121043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_123121", "123121043", "story_v_out_123121.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_123121", "123121043", "story_v_out_123121.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play123121044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 123121044
		arg_179_1.duration_ = 15.8

		local var_179_0 = {
			zh = 15.8,
			ja = 11.933
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play123121045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.65

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:GetWordFromCfg(123121044)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 66 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 66)

				if (66 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 66)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121044", "story_v_out_123121.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121044", "story_v_out_123121.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_123121", "123121044", "story_v_out_123121.awb")

						arg_179_1:RecordAudio("123121044", var_182_6)
						arg_179_1:RecordAudio("123121044", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_123121", "123121044", "story_v_out_123121.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_123121", "123121044", "story_v_out_123121.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play123121045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 123121045
		arg_183_1.duration_ = 8.23

		local var_183_0 = {
			zh = 8.233,
			ja = 5.066
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play123121046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.725

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(123121045)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 29 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 29)

				if (29 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 29)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121045", "story_v_out_123121.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121045", "story_v_out_123121.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_123121", "123121045", "story_v_out_123121.awb")

						arg_183_1:RecordAudio("123121045", var_186_6)
						arg_183_1:RecordAudio("123121045", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_123121", "123121045", "story_v_out_123121.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_123121", "123121045", "story_v_out_123121.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play123121046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 123121046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play123121047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(123121046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 11 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 11)

				if (11 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 11)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play123121047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 123121047
		arg_191_1.duration_ = 18.97

		local var_191_0 = {
			zh = 18.966,
			ja = 17
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play123121048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.625

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:GetWordFromCfg(123121047)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 65 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 65)

				if (65 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 65)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121047", "story_v_out_123121.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121047", "story_v_out_123121.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_123121", "123121047", "story_v_out_123121.awb")

						arg_191_1:RecordAudio("123121047", var_194_6)
						arg_191_1:RecordAudio("123121047", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_123121", "123121047", "story_v_out_123121.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_123121", "123121047", "story_v_out_123121.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play123121048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 123121048
		arg_195_1.duration_ = 0.5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"

			SetActive(arg_195_1.choicesGo_, true)

			for iter_196_0, iter_196_1 in ipairs(arg_195_1.choices_) do
				SetActive(iter_196_1.go, iter_196_0 <= 1)
			end

			arg_195_1.choices_[1].txt.text = arg_195_1:FormatText(StoryChoiceCfg[507].name)
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play123121049(arg_195_1)
			end

			arg_195_1:RecordChoiceLog(123121048, 507)
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= 0 + 0.5 and arg_195_1.time_ < 0 + 0.5 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play123121049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 123121049
		arg_199_1.duration_ = 2

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play123121050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1055ui_story = arg_199_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1055ui_story"].transform.position).z)
				arg_199_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1055ui_story"].transform.localEulerAngles = arg_199_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				arg_199_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1055ui_story"].transform.position).z)
				arg_199_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1055ui_story"].transform.localEulerAngles = arg_199_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1055ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1055ui_story == nil then
				arg_199_1.var_.characterEffect1055ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1055ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1055ui_story then
				arg_199_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_202_4 = 0
			local var_202_5 = 0.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(123121049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 6 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 6)

				if (6 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 6)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121049", "story_v_out_123121.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121049", "story_v_out_123121.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_123121", "123121049", "story_v_out_123121.awb")

						arg_199_1:RecordAudio("123121049", var_202_11)
						arg_199_1:RecordAudio("123121049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_123121", "123121049", "story_v_out_123121.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_123121", "123121049", "story_v_out_123121.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play123121050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 123121050
		arg_203_1.duration_ = 3.2

		local var_203_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play123121051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1093ui_story = arg_203_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1093ui_story"].transform.position).z)
				arg_203_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1093ui_story"].transform.localEulerAngles = arg_203_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_203_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1093ui_story"].transform.position).z)
				arg_203_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1093ui_story"].transform.localEulerAngles = arg_203_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1093ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1093ui_story == nil then
				arg_203_1.var_.characterEffect1093ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1093ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1093ui_story then
				arg_203_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = arg_203_1.actors_["1055ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1055ui_story == nil then
				arg_203_1.var_.characterEffect1055ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect1055ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1055ui_story then
				arg_203_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.225

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(123121050)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 9 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 9)

				if (9 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 9)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121050", "story_v_out_123121.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_123121", "123121050", "story_v_out_123121.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_123121", "123121050", "story_v_out_123121.awb")

						arg_203_1:RecordAudio("123121050", var_206_13)
						arg_203_1:RecordAudio("123121050", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_123121", "123121050", "story_v_out_123121.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_123121", "123121050", "story_v_out_123121.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play123121051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 123121051
		arg_207_1.duration_ = 5.57

		local var_207_0 = {
			zh = 5.566,
			ja = 4.533
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play123121052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1055ui_story = arg_207_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1055ui_story"].transform.position).z)
				arg_207_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1055ui_story"].transform.localEulerAngles = arg_207_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1055ui_story"].transform.position).z)
				arg_207_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1055ui_story"].transform.localEulerAngles = arg_207_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1055ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1055ui_story == nil then
				arg_207_1.var_.characterEffect1055ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1055ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1055ui_story then
				arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_210_3 = arg_207_1.actors_["1093ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1093ui_story = var_210_3.localPosition
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_3.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_4)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_3.localPosition = Vector3.New(0, 100, 0)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			local var_210_5 = arg_207_1.actors_["1093ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1093ui_story == nil then
				arg_207_1.var_.characterEffect1093ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect1093ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_6)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1093ui_story then
				arg_207_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_210_7 = 0
			local var_210_8 = 0.35

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(123121051)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_12 = 14 <= 0 and var_210_8 or var_210_8 * (utf8.len(var_210_10) / 14)

				if (14 <= 0 and var_210_8 or var_210_8 * (utf8.len(var_210_10) / 14)) > 0 and var_210_8 < var_210_12 then
					arg_207_1.talkMaxDuration = var_210_12

					if var_210_12 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_7
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121051", "story_v_out_123121.awb") ~= 0 then
					local var_210_13 = manager.audio:GetVoiceLength("story_v_out_123121", "123121051", "story_v_out_123121.awb") / 1000

					if var_210_13 + var_210_7 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_7
					end

					if var_210_9.prefab_name ~= "" and arg_207_1.actors_[var_210_9.prefab_name] ~= nil then
						local var_210_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_9.prefab_name].transform, "story_v_out_123121", "123121051", "story_v_out_123121.awb")

						arg_207_1:RecordAudio("123121051", var_210_14)
						arg_207_1:RecordAudio("123121051", var_210_14)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_123121", "123121051", "story_v_out_123121.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_123121", "123121051", "story_v_out_123121.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_15 = math.max(var_210_8, arg_207_1.talkMaxDuration)

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_15 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_7) / var_210_15

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_7 + var_210_15 and arg_207_1.time_ < var_210_7 + var_210_15 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play123121052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 123121052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play123121053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.9

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(123121052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 76 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 76)

				if (76 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 76)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play123121053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 123121053
		arg_215_1.duration_ = 16.7

		local var_215_0 = {
			zh = 16.7,
			ja = 13.8
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play123121054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.825

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(123121053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 73 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 73)

				if (73 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 73)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121053", "story_v_out_123121.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121053", "story_v_out_123121.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_123121", "123121053", "story_v_out_123121.awb")

						arg_215_1:RecordAudio("123121053", var_218_6)
						arg_215_1:RecordAudio("123121053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_123121", "123121053", "story_v_out_123121.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_123121", "123121053", "story_v_out_123121.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play123121054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 123121054
		arg_219_1.duration_ = 13.03

		local var_219_0 = {
			zh = 13.033,
			ja = 11.033
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play123121055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:GetWordFromCfg(123121054)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 52 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 52)

				if (52 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 52)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121054", "story_v_out_123121.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121054", "story_v_out_123121.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_123121", "123121054", "story_v_out_123121.awb")

						arg_219_1:RecordAudio("123121054", var_222_6)
						arg_219_1:RecordAudio("123121054", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_123121", "123121054", "story_v_out_123121.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_123121", "123121054", "story_v_out_123121.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play123121055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 123121055
		arg_223_1.duration_ = 4.07

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play123121056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1093ui_story = arg_223_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).z)
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles = arg_223_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_223_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).z)
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles = arg_223_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1093ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1093ui_story == nil then
				arg_223_1.var_.characterEffect1093ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1093ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1093ui_story then
				arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.55

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(123121055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 22 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 22)

				if (22 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 22)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121055", "story_v_out_123121.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121055", "story_v_out_123121.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_123121", "123121055", "story_v_out_123121.awb")

						arg_223_1:RecordAudio("123121055", var_226_11)
						arg_223_1:RecordAudio("123121055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_123121", "123121055", "story_v_out_123121.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_123121", "123121055", "story_v_out_123121.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play123121056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 123121056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play123121057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1093ui_story = arg_227_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1093ui_story"].transform.position).z)
				arg_227_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1093ui_story"].transform.localEulerAngles = arg_227_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1093ui_story"].transform.position).z)
				arg_227_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1093ui_story"].transform.localEulerAngles = arg_227_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1093ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1093ui_story == nil then
				arg_227_1.var_.characterEffect1093ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1093ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_2)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1093ui_story then
				arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_230_3 = 0
			local var_230_4 = 0.225

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(123121056).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 9 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 9)

				if (9 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 9)) > 0 and var_230_4 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_3
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_4, arg_227_1.talkMaxDuration)

			if var_230_3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_3 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_3) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_3 + var_230_8 and arg_227_1.time_ < var_230_3 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play123121057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 123121057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play123121058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.925

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(123121057).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 37 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 37)

				if (37 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 37)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play123121058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 123121058
		arg_235_1.duration_ = 9

		local var_235_0 = {
			zh = 8.666,
			ja = 9
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play123121059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.825

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(123121058)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 33 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 33)

				if (33 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 33)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121058", "story_v_out_123121.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121058", "story_v_out_123121.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_123121", "123121058", "story_v_out_123121.awb")

						arg_235_1:RecordAudio("123121058", var_238_6)
						arg_235_1:RecordAudio("123121058", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_123121", "123121058", "story_v_out_123121.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_123121", "123121058", "story_v_out_123121.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play123121059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 123121059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play123121060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.15

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(123121059).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 46 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 46)

				if (46 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 46)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play123121060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 123121060
		arg_243_1.duration_ = 4.2

		local var_243_0 = {
			zh = 2.5,
			ja = 4.2
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play123121061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1093ui_story = arg_243_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).z)
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles = arg_243_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_243_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1093ui_story"].transform.position).z)
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1093ui_story"].transform.localEulerAngles = arg_243_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1093ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1093ui_story == nil then
				arg_243_1.var_.characterEffect1093ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1093ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1093ui_story then
				arg_243_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_246_4 = 0
			local var_246_5 = 0.3

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_6 = arg_243_1:GetWordFromCfg(123121060)
				local var_246_7 = arg_243_1:FormatText(var_246_6.content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 12 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 12)

				if (12 <= 0 and var_246_5 or var_246_5 * (utf8.len(var_246_7) / 12)) > 0 and var_246_5 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_4
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121060", "story_v_out_123121.awb") ~= 0 then
					local var_246_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121060", "story_v_out_123121.awb") / 1000

					if var_246_10 + var_246_4 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_4
					end

					if var_246_6.prefab_name ~= "" and arg_243_1.actors_[var_246_6.prefab_name] ~= nil then
						local var_246_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_6.prefab_name].transform, "story_v_out_123121", "123121060", "story_v_out_123121.awb")

						arg_243_1:RecordAudio("123121060", var_246_11)
						arg_243_1:RecordAudio("123121060", var_246_11)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_123121", "123121060", "story_v_out_123121.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_123121", "123121060", "story_v_out_123121.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_12 = math.max(var_246_5, arg_243_1.talkMaxDuration)

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_12 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_4) / var_246_12

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_4 + var_246_12 and arg_243_1.time_ < var_246_4 + var_246_12 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play123121061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 123121061
		arg_247_1.duration_ = 4.77

		local var_247_0 = {
			zh = 4.766,
			ja = 4.266
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play123121062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1093ui_story"]) and arg_247_1.var_.characterEffect1093ui_story == nil then
				arg_247_1.var_.characterEffect1093ui_story = arg_247_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1093ui_story"]) then
				if arg_247_1.var_.characterEffect1093ui_story and not isNil(arg_247_1.actors_["1093ui_story"]) then
					arg_247_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1093ui_story"]) and arg_247_1.var_.characterEffect1093ui_story then
				arg_247_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.25

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(123121061)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 10 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 10)

				if (10 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 10)) > 0 and var_250_2 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121061", "story_v_out_123121.awb") ~= 0 then
					local var_250_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121061", "story_v_out_123121.awb") / 1000

					if var_250_7 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_1
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_123121", "123121061", "story_v_out_123121.awb")

						arg_247_1:RecordAudio("123121061", var_250_8)
						arg_247_1:RecordAudio("123121061", var_250_8)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_123121", "123121061", "story_v_out_123121.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_123121", "123121061", "story_v_out_123121.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_9 and arg_247_1.time_ < var_250_1 + var_250_9 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play123121062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 123121062
		arg_251_1.duration_ = 2.77

		local var_251_0 = {
			zh = 2.166,
			ja = 2.766
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play123121063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) and arg_251_1.var_.characterEffect1093ui_story == nil then
				arg_251_1.var_.characterEffect1093ui_story = arg_251_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) then
				if arg_251_1.var_.characterEffect1093ui_story and not isNil(arg_251_1.actors_["1093ui_story"]) then
					arg_251_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1093ui_story"]) and arg_251_1.var_.characterEffect1093ui_story then
				arg_251_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_254_2 = 0
			local var_254_3 = 0.175

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:GetWordFromCfg(123121062)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 7 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 7)

				if (7 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 7)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121062", "story_v_out_123121.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121062", "story_v_out_123121.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_out_123121", "123121062", "story_v_out_123121.awb")

						arg_251_1:RecordAudio("123121062", var_254_9)
						arg_251_1:RecordAudio("123121062", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_123121", "123121062", "story_v_out_123121.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_123121", "123121062", "story_v_out_123121.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play123121063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 123121063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play123121064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1093ui_story"]) and arg_255_1.var_.characterEffect1093ui_story == nil then
				arg_255_1.var_.characterEffect1093ui_story = arg_255_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1093ui_story"]) then
				if arg_255_1.var_.characterEffect1093ui_story and not isNil(arg_255_1.actors_["1093ui_story"]) then
					arg_255_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1093ui_story"]) and arg_255_1.var_.characterEffect1093ui_story then
				arg_255_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.525

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(123121063).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 21 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 21)

				if (21 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 21)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play123121064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 123121064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play123121065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.675

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(123121064).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 27 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 27)

				if (27 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 27)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play123121065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 123121065
		arg_263_1.duration_ = 3.93

		local var_263_0 = {
			zh = 2.466,
			ja = 3.933
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play123121066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1093ui_story"]) and arg_263_1.var_.characterEffect1093ui_story == nil then
				arg_263_1.var_.characterEffect1093ui_story = arg_263_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1093ui_story"]) then
				if arg_263_1.var_.characterEffect1093ui_story and not isNil(arg_263_1.actors_["1093ui_story"]) then
					arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1093ui_story"]) and arg_263_1.var_.characterEffect1093ui_story then
				arg_263_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_266_2 = 0
			local var_266_3 = 0.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(123121065)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 10 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 10)

				if (10 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 10)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121065", "story_v_out_123121.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121065", "story_v_out_123121.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_out_123121", "123121065", "story_v_out_123121.awb")

						arg_263_1:RecordAudio("123121065", var_266_9)
						arg_263_1:RecordAudio("123121065", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_123121", "123121065", "story_v_out_123121.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_123121", "123121065", "story_v_out_123121.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_10 and arg_263_1.time_ < var_266_2 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play123121066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 123121066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play123121067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1093ui_story = arg_267_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).z)
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles = arg_267_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1093ui_story"].transform.position).z)
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1093ui_story"].transform.localEulerAngles = arg_267_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1093ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1093ui_story == nil then
				arg_267_1.var_.characterEffect1093ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1093ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_2)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1093ui_story then
				arg_267_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_270_3 = 0
			local var_270_4 = 0.875

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_5 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(123121066).content)

				arg_267_1.text_.text = var_270_5

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 35 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_5) / 35)

				if (35 <= 0 and var_270_4 or var_270_4 * (utf8.len(var_270_5) / 35)) > 0 and var_270_4 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_3 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_3
					end
				end

				arg_267_1.text_.text = var_270_5
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_4, arg_267_1.talkMaxDuration)

			if var_270_3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_3 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_3) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_3 + var_270_8 and arg_267_1.time_ < var_270_3 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play123121067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 123121067
		arg_271_1.duration_ = 16.8

		local var_271_0 = {
			zh = 12.433,
			ja = 16.8
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play123121068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.425

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:GetWordFromCfg(123121067)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 57 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 57)

				if (57 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 57)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121067", "story_v_out_123121.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121067", "story_v_out_123121.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_123121", "123121067", "story_v_out_123121.awb")

						arg_271_1:RecordAudio("123121067", var_274_6)
						arg_271_1:RecordAudio("123121067", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_123121", "123121067", "story_v_out_123121.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_123121", "123121067", "story_v_out_123121.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play123121068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 123121068
		arg_275_1.duration_ = 8.13

		local var_275_0 = {
			zh = 7.666,
			ja = 8.133
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
				arg_275_0:Play123121069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.875

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:GetWordFromCfg(123121068)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 35 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 35)

				if (35 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 35)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121068", "story_v_out_123121.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121068", "story_v_out_123121.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_123121", "123121068", "story_v_out_123121.awb")

						arg_275_1:RecordAudio("123121068", var_278_6)
						arg_275_1:RecordAudio("123121068", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_123121", "123121068", "story_v_out_123121.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_123121", "123121068", "story_v_out_123121.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play123121069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 123121069
		arg_279_1.duration_ = 9

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play123121070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_0 = 2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				local var_282_1 = Color.New(0, 0, 0)

				var_282_1.a = Mathf.Lerp(0, 1, (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.mask_.color = var_282_1
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				local var_282_2 = Color.New(0, 0, 0)

				var_282_2.a = 1
				arg_279_1.mask_.color = var_282_2
			end

			local var_282_3 = 2

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= var_282_3 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_4 = 2

			if var_282_3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_3 + var_282_4 then
				local var_282_5 = Color.New(0, 0, 0)

				var_282_5.a = Mathf.Lerp(1, 0, (arg_279_1.time_ - var_282_3) / var_282_4)
				arg_279_1.mask_.color = var_282_5
			end

			if arg_279_1.time_ >= var_282_3 + var_282_4 and arg_279_1.time_ < var_282_3 + var_282_4 + arg_282_0 then
				local var_282_6 = Color.New(0, 0, 0)

				arg_279_1.mask_.enabled = false
				var_282_6.a = 0
				arg_279_1.mask_.color = var_282_6
			end

			if 2 < arg_279_1.time_ and arg_279_1.time_ <= 2 + arg_282_0 then
				local var_282_7 = arg_279_1.bgs_.K05g

				arg_279_1.bgs_.K05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_282_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_8 = var_282_7:GetComponent("SpriteRenderer")

				if var_282_8 and var_282_8.sprite then
					local var_282_9 = 2 * (var_282_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_282_7.transform.localScale = Vector3.New(var_282_9 / var_282_8.sprite.bounds.size.y < var_282_9 * manager.ui.mainCameraCom_.aspect / var_282_8.sprite.bounds.size.x and var_282_9 * manager.ui.mainCameraCom_.aspect / var_282_8.sprite.bounds.size.x or var_282_9 / var_282_8.sprite.bounds.size.y, var_282_9 / var_282_8.sprite.bounds.size.y < var_282_9 * manager.ui.mainCameraCom_.aspect / var_282_8.sprite.bounds.size.x and var_282_9 * manager.ui.mainCameraCom_.aspect / var_282_8.sprite.bounds.size.x or var_282_9 / var_282_8.sprite.bounds.size.y, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "K05g" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_10 = 4
			local var_282_11 = 0.6

			if 4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_12 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_12:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_13 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(123121069).content)

				arg_279_1.text_.text = var_282_13

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_15 = 24 <= 0 and var_282_11 or var_282_11 * (utf8.len(var_282_13) / 24)

				if (24 <= 0 and var_282_11 or var_282_11 * (utf8.len(var_282_13) / 24)) > 0 and var_282_11 < var_282_15 then
					arg_279_1.talkMaxDuration = var_282_15
					var_282_10 = var_282_10 + 0.3

					if var_282_15 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_15 + var_282_10
					end
				end

				arg_279_1.text_.text = var_282_13
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = var_282_10 + 0.3
			local var_282_17 = math.max(var_282_11, arg_279_1.talkMaxDuration)

			if var_282_10 + 0.3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_16 + var_282_17 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_16) / var_282_17

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_16 + var_282_17 and arg_279_1.time_ < var_282_16 + var_282_17 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play123121070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 123121070
		arg_285_1.duration_ = 6.5

		local var_285_0 = {
			zh = 5.233,
			ja = 6.5
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play123121071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1093ui_story = arg_285_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).z)
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles = arg_285_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_285_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).z)
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles = arg_285_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1093ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1093ui_story == nil then
				arg_285_1.var_.characterEffect1093ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1093ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1093ui_story then
				arg_285_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_4 = 0
			local var_288_5 = 0.7

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(123121070)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 28 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 28)

				if (28 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 28)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121070", "story_v_out_123121.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121070", "story_v_out_123121.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_123121", "123121070", "story_v_out_123121.awb")

						arg_285_1:RecordAudio("123121070", var_288_11)
						arg_285_1:RecordAudio("123121070", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_123121", "123121070", "story_v_out_123121.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_123121", "123121070", "story_v_out_123121.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play123121071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 123121071
		arg_289_1.duration_ = 9.43

		local var_289_0 = {
			zh = 7.566,
			ja = 9.433
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play123121072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_0 = 0
			local var_292_1 = 0.925

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(123121071)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 37 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 37)

				if (37 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 37)) > 0 and var_292_1 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121071", "story_v_out_123121.awb") ~= 0 then
					local var_292_6 = manager.audio:GetVoiceLength("story_v_out_123121", "123121071", "story_v_out_123121.awb") / 1000

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end

					if var_292_2.prefab_name ~= "" and arg_289_1.actors_[var_292_2.prefab_name] ~= nil then
						local var_292_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_2.prefab_name].transform, "story_v_out_123121", "123121071", "story_v_out_123121.awb")

						arg_289_1:RecordAudio("123121071", var_292_7)
						arg_289_1:RecordAudio("123121071", var_292_7)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_123121", "123121071", "story_v_out_123121.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_123121", "123121071", "story_v_out_123121.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play123121072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 123121072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play123121073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1093ui_story"]) and arg_293_1.var_.characterEffect1093ui_story == nil then
				arg_293_1.var_.characterEffect1093ui_story = arg_293_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1093ui_story"]) then
				if arg_293_1.var_.characterEffect1093ui_story and not isNil(arg_293_1.actors_["1093ui_story"]) then
					arg_293_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1093ui_story"]) and arg_293_1.var_.characterEffect1093ui_story then
				arg_293_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.85

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(123121072).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 34 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 34)

				if (34 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 34)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play123121073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 123121073
		arg_297_1.duration_ = 7.03

		local var_297_0 = {
			zh = 5,
			ja = 7.033
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play123121074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1055ui_story = arg_297_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1055ui_story"].transform.position).z)
				arg_297_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1055ui_story"].transform.localEulerAngles = arg_297_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_297_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1055ui_story"].transform.position).z)
				arg_297_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1055ui_story"].transform.localEulerAngles = arg_297_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1055ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1055ui_story == nil then
				arg_297_1.var_.characterEffect1055ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1055ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1055ui_story then
				arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_300_4 = arg_297_1.actors_["1093ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1093ui_story = var_300_4.localPosition
			end

			local var_300_5 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 then
				var_300_4.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_297_1.time_ - 0) / var_300_5)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 then
				var_300_4.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_300_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_4.position).x, (manager.ui.mainCamera.transform.position - var_300_4.position).y, (manager.ui.mainCamera.transform.position - var_300_4.position).z)
				var_300_4.localEulerAngles.z = 0
				var_300_4.localEulerAngles.x = 0
				var_300_4.localEulerAngles = var_300_4.localEulerAngles
			end

			local var_300_6 = 0
			local var_300_7 = 0.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_8 = arg_297_1:GetWordFromCfg(123121073)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 20 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 20)

				if (20 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 20)) > 0 and var_300_7 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121073", "story_v_out_123121.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_123121", "123121073", "story_v_out_123121.awb") / 1000

					if var_300_12 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_6
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_123121", "123121073", "story_v_out_123121.awb")

						arg_297_1:RecordAudio("123121073", var_300_13)
						arg_297_1:RecordAudio("123121073", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_123121", "123121073", "story_v_out_123121.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_123121", "123121073", "story_v_out_123121.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play123121074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 123121074
		arg_301_1.duration_ = 5.07

		local var_301_0 = {
			zh = 2.966,
			ja = 5.066
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play123121075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1093ui_story"]) and arg_301_1.var_.characterEffect1093ui_story == nil then
				arg_301_1.var_.characterEffect1093ui_story = arg_301_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1093ui_story"]) then
				if arg_301_1.var_.characterEffect1093ui_story and not isNil(arg_301_1.actors_["1093ui_story"]) then
					arg_301_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1093ui_story"]) and arg_301_1.var_.characterEffect1093ui_story then
				arg_301_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_304_2 = arg_301_1.actors_["1055ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect1055ui_story == nil then
				arg_301_1.var_.characterEffect1055ui_story = var_304_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_3 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.characterEffect1055ui_story and not isNil(var_304_2) then
					arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_3)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect1055ui_story then
				arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_304_4 = 0
			local var_304_5 = 0.3

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(123121074)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 12 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 12)

				if (12 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 12)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121074", "story_v_out_123121.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121074", "story_v_out_123121.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_123121", "123121074", "story_v_out_123121.awb")

						arg_301_1:RecordAudio("123121074", var_304_11)
						arg_301_1:RecordAudio("123121074", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_123121", "123121074", "story_v_out_123121.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_123121", "123121074", "story_v_out_123121.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play123121075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 123121075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play123121076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1093ui_story"]) and arg_305_1.var_.characterEffect1093ui_story == nil then
				arg_305_1.var_.characterEffect1093ui_story = arg_305_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1093ui_story"]) then
				if arg_305_1.var_.characterEffect1093ui_story and not isNil(arg_305_1.actors_["1093ui_story"]) then
					arg_305_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1093ui_story"]) and arg_305_1.var_.characterEffect1093ui_story then
				arg_305_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.225

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(123121075).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 9 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 9)

				if (9 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 9)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play123121076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 123121076
		arg_309_1.duration_ = 0.5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"

			SetActive(arg_309_1.choicesGo_, true)

			for iter_310_0, iter_310_1 in ipairs(arg_309_1.choices_) do
				SetActive(iter_310_1.go, iter_310_0 <= 1)
			end

			arg_309_1.choices_[1].txt.text = arg_309_1:FormatText(StoryChoiceCfg[508].name)
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play123121077(arg_309_1)
			end

			arg_309_1:RecordChoiceLog(123121076, 508)
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			if arg_309_1.time_ >= 0 + 0.5 and arg_309_1.time_ < 0 + 0.5 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play123121077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 123121077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play123121078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1093ui_story = arg_313_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1093ui_story"].transform.position).z)
				arg_313_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1093ui_story"].transform.localEulerAngles = arg_313_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1093ui_story"].transform.position).z)
				arg_313_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1093ui_story"].transform.localEulerAngles = arg_313_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1093ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1093ui_story == nil then
				arg_313_1.var_.characterEffect1093ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1093ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_2)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1093ui_story then
				arg_313_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_316_3 = arg_313_1.actors_["1055ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1055ui_story = var_316_3.localPosition
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_3.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_313_1.time_ - 0) / var_316_4)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_316_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_3.position).x, (manager.ui.mainCamera.transform.position - var_316_3.position).y, (manager.ui.mainCamera.transform.position - var_316_3.position).z)
				var_316_3.localEulerAngles.z = 0
				var_316_3.localEulerAngles.x = 0
				var_316_3.localEulerAngles = var_316_3.localEulerAngles
			end

			local var_316_5 = arg_313_1.actors_["1055ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1055ui_story == nil then
				arg_313_1.var_.characterEffect1055ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.characterEffect1055ui_story and not isNil(var_316_5) then
					arg_313_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_6)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1055ui_story then
				arg_313_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_316_7 = 0
			local var_316_8 = 0.275

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(123121077).content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 11 <= 0 and var_316_8 or var_316_8 * (utf8.len(var_316_9) / 11)

				if (11 <= 0 and var_316_8 or var_316_8 * (utf8.len(var_316_9) / 11)) > 0 and var_316_8 < var_316_11 then
					arg_313_1.talkMaxDuration = var_316_11

					if var_316_11 + var_316_7 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_7
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_8, arg_313_1.talkMaxDuration)

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_7) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_7 + var_316_12 and arg_313_1.time_ < var_316_7 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play123121078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 123121078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play123121079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.225

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(123121078).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 49 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 49)

				if (49 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 49)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play123121079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 123121079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play123121080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1055ui_story = arg_321_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1055ui_story"].transform.position).z)
				arg_321_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1055ui_story"].transform.localEulerAngles = arg_321_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_321_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1055ui_story"].transform.position).z)
				arg_321_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1055ui_story"].transform.localEulerAngles = arg_321_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1055ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1055ui_story == nil then
				arg_321_1.var_.characterEffect1055ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1055ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_2)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1055ui_story then
				arg_321_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_324_3 = 0
			local var_324_4 = 0.475

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_5 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(123121079).content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 19 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 19)

				if (19 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_5) / 19)) > 0 and var_324_4 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_3
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_4, arg_321_1.talkMaxDuration)

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_3) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_3 + var_324_8 and arg_321_1.time_ < var_324_3 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play123121080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 123121080
		arg_325_1.duration_ = 8.23

		local var_325_0 = {
			zh = 4.666,
			ja = 8.233
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play123121081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1055ui_story"]) and arg_325_1.var_.characterEffect1055ui_story == nil then
				arg_325_1.var_.characterEffect1055ui_story = arg_325_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1055ui_story"]) then
				if arg_325_1.var_.characterEffect1055ui_story and not isNil(arg_325_1.actors_["1055ui_story"]) then
					arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1055ui_story"]) and arg_325_1.var_.characterEffect1055ui_story then
				arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_328_2 = 0
			local var_328_3 = 0.525

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(123121080)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 21 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 21)

				if (21 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 21)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121080", "story_v_out_123121.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121080", "story_v_out_123121.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_out_123121", "123121080", "story_v_out_123121.awb")

						arg_325_1:RecordAudio("123121080", var_328_9)
						arg_325_1:RecordAudio("123121080", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_123121", "123121080", "story_v_out_123121.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_123121", "123121080", "story_v_out_123121.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play123121081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 123121081
		arg_329_1.duration_ = 8.1

		local var_329_0 = {
			zh = 5.7,
			ja = 8.1
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play123121082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.525

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(123121081)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 21 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 21)

				if (21 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 21)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121081", "story_v_out_123121.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121081", "story_v_out_123121.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_123121", "123121081", "story_v_out_123121.awb")

						arg_329_1:RecordAudio("123121081", var_332_6)
						arg_329_1:RecordAudio("123121081", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_123121", "123121081", "story_v_out_123121.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_123121", "123121081", "story_v_out_123121.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play123121082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 123121082
		arg_333_1.duration_ = 9

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play123121083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 2 < arg_333_1.time_ and arg_333_1.time_ <= 2 + arg_336_0 then
				local var_336_0 = arg_333_1.bgs_.K06g

				arg_333_1.bgs_.K06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_336_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_336_1 = var_336_0:GetComponent("SpriteRenderer")

				if var_336_1 and var_336_1.sprite then
					local var_336_2 = 2 * (var_336_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_336_0.transform.localScale = Vector3.New(var_336_2 / var_336_1.sprite.bounds.size.y < var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x and var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x or var_336_2 / var_336_1.sprite.bounds.size.y, var_336_2 / var_336_1.sprite.bounds.size.y < var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x and var_336_2 * manager.ui.mainCameraCom_.aspect / var_336_1.sprite.bounds.size.x or var_336_2 / var_336_1.sprite.bounds.size.y, 0)
				end

				for iter_336_0, iter_336_1 in pairs(arg_333_1.bgs_) do
					if iter_336_0 ~= "K06g" then
						iter_336_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_336_3 = 0

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_3 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_4 = 2

			if var_336_3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_3 + var_336_4 then
				local var_336_5 = Color.New(0, 0, 0)

				var_336_5.a = Mathf.Lerp(0, 1, (arg_333_1.time_ - var_336_3) / var_336_4)
				arg_333_1.mask_.color = var_336_5
			end

			if arg_333_1.time_ >= var_336_3 + var_336_4 and arg_333_1.time_ < var_336_3 + var_336_4 + arg_336_0 then
				local var_336_6 = Color.New(0, 0, 0)

				var_336_6.a = 1
				arg_333_1.mask_.color = var_336_6
			end

			local var_336_7 = 2

			if 2 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				arg_333_1.mask_.enabled = true
				arg_333_1.mask_.raycastTarget = true

				arg_333_1:SetGaussion(false)
			end

			local var_336_8 = 2

			if var_336_7 <= arg_333_1.time_ and arg_333_1.time_ < var_336_7 + var_336_8 then
				local var_336_9 = Color.New(0, 0, 0)

				var_336_9.a = Mathf.Lerp(1, 0, (arg_333_1.time_ - var_336_7) / var_336_8)
				arg_333_1.mask_.color = var_336_9
			end

			if arg_333_1.time_ >= var_336_7 + var_336_8 and arg_333_1.time_ < var_336_7 + var_336_8 + arg_336_0 then
				local var_336_10 = Color.New(0, 0, 0)

				arg_333_1.mask_.enabled = false
				var_336_10.a = 0
				arg_333_1.mask_.color = var_336_10
			end

			local var_336_11 = arg_333_1.actors_["1055ui_story"].transform

			if 1.96599999815226 < arg_333_1.time_ and arg_333_1.time_ <= 1.96599999815226 + arg_336_0 then
				arg_333_1.var_.moveOldPos1055ui_story = var_336_11.localPosition
			end

			local var_336_12 = 0.001

			if 1.96599999815226 <= arg_333_1.time_ and arg_333_1.time_ < 1.96599999815226 + var_336_12 then
				var_336_11.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 1.96599999815226) / var_336_12)
				var_336_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_11.position).x, (manager.ui.mainCamera.transform.position - var_336_11.position).y, (manager.ui.mainCamera.transform.position - var_336_11.position).z)
				var_336_11.localEulerAngles.z = 0
				var_336_11.localEulerAngles.x = 0
				var_336_11.localEulerAngles = var_336_11.localEulerAngles
			end

			if arg_333_1.time_ >= 1.96599999815226 + var_336_12 and arg_333_1.time_ < 1.96599999815226 + var_336_12 + arg_336_0 then
				var_336_11.localPosition = Vector3.New(0, 100, 0)
				var_336_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_11.position).x, (manager.ui.mainCamera.transform.position - var_336_11.position).y, (manager.ui.mainCamera.transform.position - var_336_11.position).z)
				var_336_11.localEulerAngles.z = 0
				var_336_11.localEulerAngles.x = 0
				var_336_11.localEulerAngles = var_336_11.localEulerAngles
			end

			local var_336_13 = arg_333_1.actors_["1055ui_story"]

			if 1.96599999815226 < arg_333_1.time_ and arg_333_1.time_ <= 1.96599999815226 + arg_336_0 and not isNil(var_336_13) and arg_333_1.var_.characterEffect1055ui_story == nil then
				arg_333_1.var_.characterEffect1055ui_story = var_336_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_14 = 0.034000001847744

			if 1.96599999815226 <= arg_333_1.time_ and arg_333_1.time_ < 1.96599999815226 + var_336_14 and not isNil(var_336_13) then
				if arg_333_1.var_.characterEffect1055ui_story and not isNil(var_336_13) then
					arg_333_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 1.96599999815226) / var_336_14)
				end
			end

			if arg_333_1.time_ >= 1.96599999815226 + var_336_14 and arg_333_1.time_ < 1.96599999815226 + var_336_14 + arg_336_0 and not isNil(var_336_13) and arg_333_1.var_.characterEffect1055ui_story then
				arg_333_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if arg_333_1.frameCnt_ <= 1 then
				arg_333_1.dialog_:SetActive(false)
			end

			local var_336_15 = 3.999999999999
			local var_336_16 = 1.225

			if 3.999999999999 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_17 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_17:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_18 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(123121082).content)

				arg_333_1.text_.text = var_336_18

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_20 = 49 <= 0 and var_336_16 or var_336_16 * (utf8.len(var_336_18) / 49)

				if (49 <= 0 and var_336_16 or var_336_16 * (utf8.len(var_336_18) / 49)) > 0 and var_336_16 < var_336_20 then
					arg_333_1.talkMaxDuration = var_336_20
					var_336_15 = var_336_15 + 0.3

					if var_336_20 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_20 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_18
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_21 = var_336_15 + 0.3
			local var_336_22 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 + 0.3 <= arg_333_1.time_ and arg_333_1.time_ < var_336_21 + var_336_22 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_21) / var_336_22

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_21 + var_336_22 and arg_333_1.time_ < var_336_21 + var_336_22 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play123121083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 123121083
		arg_339_1.duration_ = 7.67

		local var_339_0 = {
			zh = 3.133,
			ja = 7.666
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play123121084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1055ui_story = arg_339_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1055ui_story"].transform.position).z)
				arg_339_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1055ui_story"].transform.localEulerAngles = arg_339_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_339_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1055ui_story"].transform.position).z)
				arg_339_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1055ui_story"].transform.localEulerAngles = arg_339_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1055ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1055ui_story == nil then
				arg_339_1.var_.characterEffect1055ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1055ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1055ui_story then
				arg_339_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.35

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(123121083)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 14 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 14)

				if (14 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 14)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121083", "story_v_out_123121.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121083", "story_v_out_123121.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_123121", "123121083", "story_v_out_123121.awb")

						arg_339_1:RecordAudio("123121083", var_342_11)
						arg_339_1:RecordAudio("123121083", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_123121", "123121083", "story_v_out_123121.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_123121", "123121083", "story_v_out_123121.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play123121084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 123121084
		arg_343_1.duration_ = 7.3

		local var_343_0 = {
			zh = 7.3,
			ja = 4.533
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
				arg_343_0:Play123121085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1055ui_story"]) and arg_343_1.var_.characterEffect1055ui_story == nil then
				arg_343_1.var_.characterEffect1055ui_story = arg_343_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1055ui_story"]) then
				if arg_343_1.var_.characterEffect1055ui_story and not isNil(arg_343_1.actors_["1055ui_story"]) then
					arg_343_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1055ui_story"]) and arg_343_1.var_.characterEffect1055ui_story then
				arg_343_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.525

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_3 = arg_343_1:GetWordFromCfg(123121084)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 21 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 21)

				if (21 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_4) / 21)) > 0 and var_346_2 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121084", "story_v_out_123121.awb") ~= 0 then
					local var_346_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121084", "story_v_out_123121.awb") / 1000

					if var_346_7 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_1
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_123121", "123121084", "story_v_out_123121.awb")

						arg_343_1:RecordAudio("123121084", var_346_8)
						arg_343_1:RecordAudio("123121084", var_346_8)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_123121", "123121084", "story_v_out_123121.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_123121", "123121084", "story_v_out_123121.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_9 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_9 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_9

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_9 and arg_343_1.time_ < var_346_1 + var_346_9 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play123121085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 123121085
		arg_347_1.duration_ = 11.43

		local var_347_0 = {
			zh = 9.8,
			ja = 11.433
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
				arg_347_0:Play123121086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1055ui_story"]) and arg_347_1.var_.characterEffect1055ui_story == nil then
				arg_347_1.var_.characterEffect1055ui_story = arg_347_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1055ui_story"]) then
				if arg_347_1.var_.characterEffect1055ui_story and not isNil(arg_347_1.actors_["1055ui_story"]) then
					arg_347_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1055ui_story"]) and arg_347_1.var_.characterEffect1055ui_story then
				arg_347_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_350_2 = 0
			local var_350_3 = 0.925

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(123121085)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 37 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 37)

				if (37 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 37)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121085", "story_v_out_123121.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121085", "story_v_out_123121.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_123121", "123121085", "story_v_out_123121.awb")

						arg_347_1:RecordAudio("123121085", var_350_9)
						arg_347_1:RecordAudio("123121085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_123121", "123121085", "story_v_out_123121.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_123121", "123121085", "story_v_out_123121.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play123121086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 123121086
		arg_351_1.duration_ = 3.83

		local var_351_0 = {
			zh = 2.966,
			ja = 3.833
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
				arg_351_0:Play123121087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1055ui_story"]) and arg_351_1.var_.characterEffect1055ui_story == nil then
				arg_351_1.var_.characterEffect1055ui_story = arg_351_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1055ui_story"]) then
				if arg_351_1.var_.characterEffect1055ui_story and not isNil(arg_351_1.actors_["1055ui_story"]) then
					arg_351_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1055ui_story"]) and arg_351_1.var_.characterEffect1055ui_story then
				arg_351_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.2

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(123121086)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 11 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 11)

				if (11 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 11)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121086", "story_v_out_123121.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_out_123121", "123121086", "story_v_out_123121.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_123121", "123121086", "story_v_out_123121.awb")

						arg_351_1:RecordAudio("123121086", var_354_8)
						arg_351_1:RecordAudio("123121086", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_123121", "123121086", "story_v_out_123121.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_123121", "123121086", "story_v_out_123121.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play123121087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 123121087
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play123121088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.1

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(123121087).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 44 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 44)

				if (44 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 44)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play123121088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 123121088
		arg_359_1.duration_ = 5.83

		local var_359_0 = {
			zh = 3.866,
			ja = 5.833
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play123121089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1055ui_story"]) and arg_359_1.var_.characterEffect1055ui_story == nil then
				arg_359_1.var_.characterEffect1055ui_story = arg_359_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1055ui_story"]) then
				if arg_359_1.var_.characterEffect1055ui_story and not isNil(arg_359_1.actors_["1055ui_story"]) then
					arg_359_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1055ui_story"]) and arg_359_1.var_.characterEffect1055ui_story then
				arg_359_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_2")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_362_2 = 0
			local var_362_3 = 0.3

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_4 = arg_359_1:GetWordFromCfg(123121088)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 12 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 12)

				if (12 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 12)) > 0 and var_362_3 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121088", "story_v_out_123121.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121088", "story_v_out_123121.awb") / 1000

					if var_362_8 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_2
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_out_123121", "123121088", "story_v_out_123121.awb")

						arg_359_1:RecordAudio("123121088", var_362_9)
						arg_359_1:RecordAudio("123121088", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_123121", "123121088", "story_v_out_123121.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_123121", "123121088", "story_v_out_123121.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_10 and arg_359_1.time_ < var_362_2 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play123121089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 123121089
		arg_363_1.duration_ = 5.02

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play123121090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if arg_363_1.bgs_.STblack == nil then
				local var_366_0 = Object.Instantiate(arg_363_1.paintGo_)

				var_366_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_366_0.name = "STblack"
				var_366_0.transform.parent = arg_363_1.stage_.transform
				var_366_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.bgs_.STblack = var_366_0
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				local var_366_1 = arg_363_1.bgs_.STblack

				arg_363_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_366_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_366_2 = var_366_1:GetComponent("SpriteRenderer")

				if var_366_2 and var_366_2.sprite then
					local var_366_3 = 2 * (var_366_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_366_1.transform.localScale = Vector3.New(var_366_3 / var_366_2.sprite.bounds.size.y < var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x and var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x or var_366_3 / var_366_2.sprite.bounds.size.y, var_366_3 / var_366_2.sprite.bounds.size.y < var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x and var_366_3 * manager.ui.mainCameraCom_.aspect / var_366_2.sprite.bounds.size.x or var_366_3 / var_366_2.sprite.bounds.size.y, 0)
				end

				for iter_366_0, iter_366_1 in pairs(arg_363_1.bgs_) do
					if iter_366_0 ~= "STblack" then
						iter_366_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_366_4 = 0

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.mask_.enabled = true
				arg_363_1.mask_.raycastTarget = true

				arg_363_1:SetGaussion(false)
			end

			local var_366_5 = 2

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_5 then
				local var_366_6 = Color.New(1, 1, 1)

				var_366_6.a = Mathf.Lerp(1, 0, (arg_363_1.time_ - var_366_4) / var_366_5)
				arg_363_1.mask_.color = var_366_6
			end

			if arg_363_1.time_ >= var_366_4 + var_366_5 and arg_363_1.time_ < var_366_4 + var_366_5 + arg_366_0 then
				local var_366_7 = Color.New(1, 1, 1)

				arg_363_1.mask_.enabled = false
				var_366_7.a = 0
				arg_363_1.mask_.color = var_366_7
			end

			local var_366_8 = arg_363_1.actors_["1055ui_story"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1055ui_story = var_366_8.localPosition
			end

			local var_366_9 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_9 then
				var_366_8.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_9)
				var_366_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_8.position).x, (manager.ui.mainCamera.transform.position - var_366_8.position).y, (manager.ui.mainCamera.transform.position - var_366_8.position).z)
				var_366_8.localEulerAngles.z = 0
				var_366_8.localEulerAngles.x = 0
				var_366_8.localEulerAngles = var_366_8.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_9 and arg_363_1.time_ < 0 + var_366_9 + arg_366_0 then
				var_366_8.localPosition = Vector3.New(0, 100, 0)
				var_366_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_8.position).x, (manager.ui.mainCamera.transform.position - var_366_8.position).y, (manager.ui.mainCamera.transform.position - var_366_8.position).z)
				var_366_8.localEulerAngles.z = 0
				var_366_8.localEulerAngles.x = 0
				var_366_8.localEulerAngles = var_366_8.localEulerAngles
			end

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= 2 + arg_366_0 then
				arg_363_1.fswbg_:SetActive(true)
				arg_363_1.dialog_:SetActive(false)

				arg_363_1.fswtw_.percent = 0
				arg_363_1.fswt_.text = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(123121089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.fswt_)

				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_363_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_363_1.fswtw_:SetDirty()

				arg_363_1.typewritterCharCountI18N = 0

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_10 = 2.01666666666667

			if 2.01666666666667 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 then
				arg_363_1.var_.oldValueTypewriter = arg_363_1.fswtw_.percent

				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_363_1:ShowNextGo(false)
			end

			local var_366_11 = 45
			local var_366_12 = 3
			local var_366_13, var_366_14 = arg_363_1:GetPercentByPara(arg_363_1:FormatText(arg_363_1:GetWordFromCfg(123121089).content), 1)

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0

				local var_366_15 = var_366_11 <= 0 and var_366_12 or var_366_12 * ((var_366_14 - arg_363_1.typewritterCharCountI18N) / var_366_11)

				if (var_366_11 <= 0 and var_366_12 or var_366_12 * ((var_366_14 - arg_363_1.typewritterCharCountI18N) / var_366_11)) > 0 and var_366_12 < var_366_15 then
					arg_363_1.talkMaxDuration = var_366_15

					if var_366_15 + var_366_10 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_15 + var_366_10
					end
				end
			end

			local var_366_16 = math.max(3, arg_363_1.talkMaxDuration)

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_16 then
				arg_363_1.fswtw_.percent = Mathf.Lerp(arg_363_1.var_.oldValueTypewriter, var_366_13, (arg_363_1.time_ - var_366_10) / var_366_16)
				arg_363_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_363_1.fswtw_:SetDirty()
			end

			if arg_363_1.time_ >= var_366_10 + var_366_16 and arg_363_1.time_ < var_366_10 + var_366_16 + arg_366_0 then
				arg_363_1.fswtw_.percent = var_366_13

				arg_363_1.fswtw_:SetDirty()
				arg_363_1:ShowNextGo(true)

				arg_363_1.typewritterCharCountI18N = var_366_14
			end

			if 2 < arg_363_1.time_ and arg_363_1.time_ <= 2 + arg_366_0 then
				local var_366_17 = arg_363_1.fswbg_.transform:Find("textbox/adapt/content") or arg_363_1.fswbg_.transform:Find("textbox/content")
				local var_366_18 = arg_363_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_366_19 = var_366_17:GetComponent("RectTransform")

				var_366_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_366_19.offsetMin = Vector2.New(0, 0)
				var_366_19.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.fswbg_:SetActive(false)
				arg_363_1.dialog_:SetActive(false)
				SetActive(arg_363_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_363_1:ShowNextGo(false)
			end

			if 2.01666666666667 < arg_363_1.time_ and arg_363_1.time_ <= 2.01666666666667 + arg_366_0 then
				arg_363_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_wind", "")
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play123121090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 123121090
		arg_367_1.duration_ = 9

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play123121091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if arg_367_1.bgs_.BA0106 == nil then
				local var_370_0 = Object.Instantiate(arg_367_1.paintGo_)

				var_370_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "BA0106")
				var_370_0.name = "BA0106"
				var_370_0.transform.parent = arg_367_1.stage_.transform
				var_370_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.bgs_.BA0106 = var_370_0
			end

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= 2 + arg_370_0 then
				local var_370_1 = arg_367_1.bgs_.BA0106

				arg_367_1.bgs_.BA0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_370_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_370_2 = var_370_1:GetComponent("SpriteRenderer")

				if var_370_2 and var_370_2.sprite then
					local var_370_3 = 2 * (var_370_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_370_1.transform.localScale = Vector3.New(var_370_3 / var_370_2.sprite.bounds.size.y < var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x and var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x or var_370_3 / var_370_2.sprite.bounds.size.y, var_370_3 / var_370_2.sprite.bounds.size.y < var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x and var_370_3 * manager.ui.mainCameraCom_.aspect / var_370_2.sprite.bounds.size.x or var_370_3 / var_370_2.sprite.bounds.size.y, 0)
				end

				for iter_370_0, iter_370_1 in pairs(arg_367_1.bgs_) do
					if iter_370_0 ~= "BA0106" then
						iter_370_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_370_4 = 0

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_5 = 2

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_5 then
				local var_370_6 = Color.New(0, 0, 0)

				var_370_6.a = Mathf.Lerp(0, 1, (arg_367_1.time_ - var_370_4) / var_370_5)
				arg_367_1.mask_.color = var_370_6
			end

			if arg_367_1.time_ >= var_370_4 + var_370_5 and arg_367_1.time_ < var_370_4 + var_370_5 + arg_370_0 then
				local var_370_7 = Color.New(0, 0, 0)

				var_370_7.a = 1
				arg_367_1.mask_.color = var_370_7
			end

			local var_370_8 = 2

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_9 = 2

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_9 then
				local var_370_10 = Color.New(0, 0, 0)

				var_370_10.a = Mathf.Lerp(1, 0, (arg_367_1.time_ - var_370_8) / var_370_9)
				arg_367_1.mask_.color = var_370_10
			end

			if arg_367_1.time_ >= var_370_8 + var_370_9 and arg_367_1.time_ < var_370_8 + var_370_9 + arg_370_0 then
				local var_370_11 = Color.New(0, 0, 0)

				arg_367_1.mask_.enabled = false
				var_370_11.a = 0
				arg_367_1.mask_.color = var_370_11
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.fswbg_:SetActive(false)
				arg_367_1.dialog_:SetActive(false)
				SetActive(arg_367_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_367_1:ShowNextGo(false)
			end

			local var_370_12 = arg_367_1.bgs_.BA0106.transform

			if 2 < arg_367_1.time_ and arg_367_1.time_ <= 2 + arg_370_0 then
				arg_367_1.var_.moveOldPosBA0106 = var_370_12.localPosition
			end

			local var_370_13 = 0.001

			if 2 <= arg_367_1.time_ and arg_367_1.time_ < 2 + var_370_13 then
				var_370_12.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPosBA0106, Vector3.New(0, 1, 9.5), (arg_367_1.time_ - 2) / var_370_13)
			end

			if arg_367_1.time_ >= 2 + var_370_13 and arg_367_1.time_ < 2 + var_370_13 + arg_370_0 then
				var_370_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_370_14 = arg_367_1.bgs_.BA0106.transform

			if 2.01666666666667 < arg_367_1.time_ and arg_367_1.time_ <= 2.01666666666667 + arg_370_0 then
				arg_367_1.var_.moveOldPosBA0106 = var_370_14.localPosition
			end

			local var_370_15 = 4

			if 2.01666666666667 <= arg_367_1.time_ and arg_367_1.time_ < 2.01666666666667 + var_370_15 then
				var_370_14.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPosBA0106, Vector3.New(0, 1, 10), (arg_367_1.time_ - 2.01666666666667) / var_370_15)
			end

			if arg_367_1.time_ >= 2.01666666666667 + var_370_15 and arg_367_1.time_ < 2.01666666666667 + var_370_15 + arg_370_0 then
				var_370_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_370_16 = 4

			if 4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_16 + arg_370_0 then
				arg_367_1.allBtn_.enabled = false
			end

			if arg_367_1.time_ >= var_370_16 + 2.01666666666667 and arg_367_1.time_ < var_370_16 + 2.01666666666667 + arg_370_0 then
				arg_367_1.allBtn_.enabled = true
			end

			if arg_367_1.frameCnt_ <= 1 then
				arg_367_1.dialog_:SetActive(false)
			end

			local var_370_17 = 4
			local var_370_18 = 1.1

			if 4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_17 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0

				arg_367_1.dialog_:SetActive(true)

				arg_367_1.dialogCg_.alpha = 0

				local var_370_19 = LeanTween.value(arg_367_1.dialog_, 0, 1, 0.3)

				var_370_19:setOnUpdate(LuaHelper.FloatAction(function(arg_371_0)
					arg_367_1.dialogCg_.alpha = arg_371_0
				end))
				var_370_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_367_1.dialog_)
					var_370_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_367_1.duration_ = arg_367_1.duration_ + 0.3

				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_20 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(123121090).content)

				arg_367_1.text_.text = var_370_20

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_22 = 44 <= 0 and var_370_18 or var_370_18 * (utf8.len(var_370_20) / 44)

				if (44 <= 0 and var_370_18 or var_370_18 * (utf8.len(var_370_20) / 44)) > 0 and var_370_18 < var_370_22 then
					arg_367_1.talkMaxDuration = var_370_22
					var_370_17 = var_370_17 + 0.3

					if var_370_22 + var_370_17 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_22 + var_370_17
					end
				end

				arg_367_1.text_.text = var_370_20
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_23 = var_370_17 + 0.3
			local var_370_24 = math.max(var_370_18, arg_367_1.talkMaxDuration)

			if var_370_17 + 0.3 <= arg_367_1.time_ and arg_367_1.time_ < var_370_23 + var_370_24 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_23) / var_370_24

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_23 + var_370_24 and arg_367_1.time_ < var_370_23 + var_370_24 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "BA0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "BA0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play123121091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 123121091
		arg_373_1.duration_ = 3.6

		local var_373_0 = {
			zh = 3.1,
			ja = 3.6
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play123121092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.2

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(123121091)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 8 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 8)

				if (8 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 8)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121091", "story_v_out_123121.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121091", "story_v_out_123121.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_out_123121", "123121091", "story_v_out_123121.awb")

						arg_373_1:RecordAudio("123121091", var_376_6)
						arg_373_1:RecordAudio("123121091", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_123121", "123121091", "story_v_out_123121.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_123121", "123121091", "story_v_out_123121.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play123121092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 123121092
		arg_377_1.duration_ = 7.63

		local var_377_0 = {
			zh = 5.8,
			ja = 7.633
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play123121093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.475

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:GetWordFromCfg(123121092)
				local var_380_2 = arg_377_1:FormatText(var_380_1.content)

				arg_377_1.text_.text = var_380_2

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_4 = 19 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 19)

				if (19 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_2) / 19)) > 0 and var_380_0 < var_380_4 then
					arg_377_1.talkMaxDuration = var_380_4

					if var_380_4 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_4 + 0
					end
				end

				arg_377_1.text_.text = var_380_2
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121092", "story_v_out_123121.awb") ~= 0 then
					local var_380_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121092", "story_v_out_123121.awb") / 1000

					if var_380_5 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + 0
					end

					if var_380_1.prefab_name ~= "" and arg_377_1.actors_[var_380_1.prefab_name] ~= nil then
						local var_380_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_1.prefab_name].transform, "story_v_out_123121", "123121092", "story_v_out_123121.awb")

						arg_377_1:RecordAudio("123121092", var_380_6)
						arg_377_1:RecordAudio("123121092", var_380_6)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_123121", "123121092", "story_v_out_123121.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_123121", "123121092", "story_v_out_123121.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play123121093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 123121093
		arg_381_1.duration_ = 3.6

		local var_381_0 = {
			zh = 2.066,
			ja = 3.6
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play123121094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.15

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_1 = arg_381_1:GetWordFromCfg(123121093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 6 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 6)

				if (6 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 6)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121093", "story_v_out_123121.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121093", "story_v_out_123121.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_123121", "123121093", "story_v_out_123121.awb")

						arg_381_1:RecordAudio("123121093", var_384_6)
						arg_381_1:RecordAudio("123121093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_123121", "123121093", "story_v_out_123121.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_123121", "123121093", "story_v_out_123121.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play123121094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 123121094
		arg_385_1.duration_ = 8.8

		local var_385_0 = {
			zh = 4.066,
			ja = 8.8
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play123121095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.525

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(123121094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 21 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 21)

				if (21 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 21)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121094", "story_v_out_123121.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121094", "story_v_out_123121.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_123121", "123121094", "story_v_out_123121.awb")

						arg_385_1:RecordAudio("123121094", var_388_6)
						arg_385_1:RecordAudio("123121094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_123121", "123121094", "story_v_out_123121.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_123121", "123121094", "story_v_out_123121.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play123121095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 123121095
		arg_389_1.duration_ = 4.67

		local var_389_0 = {
			zh = 2.466,
			ja = 4.666
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play123121096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.275

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:GetWordFromCfg(123121095)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 11 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 11)

				if (11 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 11)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121095", "story_v_out_123121.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121095", "story_v_out_123121.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_123121", "123121095", "story_v_out_123121.awb")

						arg_389_1:RecordAudio("123121095", var_392_6)
						arg_389_1:RecordAudio("123121095", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_123121", "123121095", "story_v_out_123121.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_123121", "123121095", "story_v_out_123121.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play123121096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 123121096
		arg_393_1.duration_ = 8.37

		local var_393_0 = {
			zh = 6.433,
			ja = 8.366
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play123121097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.825

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(123121096)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 33 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 33)

				if (33 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 33)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121096", "story_v_out_123121.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121096", "story_v_out_123121.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_123121", "123121096", "story_v_out_123121.awb")

						arg_393_1:RecordAudio("123121096", var_396_6)
						arg_393_1:RecordAudio("123121096", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_123121", "123121096", "story_v_out_123121.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_123121", "123121096", "story_v_out_123121.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play123121097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 123121097
		arg_397_1.duration_ = 6.77

		local var_397_0 = {
			zh = 5.1,
			ja = 6.766
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play123121098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.575

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:GetWordFromCfg(123121097)
				local var_400_2 = arg_397_1:FormatText(var_400_1.content)

				arg_397_1.text_.text = var_400_2

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 23 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 23)

				if (23 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_2) / 23)) > 0 and var_400_0 < var_400_4 then
					arg_397_1.talkMaxDuration = var_400_4

					if var_400_4 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_4 + 0
					end
				end

				arg_397_1.text_.text = var_400_2
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121097", "story_v_out_123121.awb") ~= 0 then
					local var_400_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121097", "story_v_out_123121.awb") / 1000

					if var_400_5 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + 0
					end

					if var_400_1.prefab_name ~= "" and arg_397_1.actors_[var_400_1.prefab_name] ~= nil then
						local var_400_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_1.prefab_name].transform, "story_v_out_123121", "123121097", "story_v_out_123121.awb")

						arg_397_1:RecordAudio("123121097", var_400_6)
						arg_397_1:RecordAudio("123121097", var_400_6)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_123121", "123121097", "story_v_out_123121.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_123121", "123121097", "story_v_out_123121.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play123121098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 123121098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play123121099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.6

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(123121098).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 24 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 24)

				if (24 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 24)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play123121099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 123121099
		arg_405_1.duration_ = 6.77

		local var_405_0 = {
			zh = 5.9,
			ja = 6.766
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play123121100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.65

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_1 = arg_405_1:GetWordFromCfg(123121099)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 26 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 26)

				if (26 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 26)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121099", "story_v_out_123121.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121099", "story_v_out_123121.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_123121", "123121099", "story_v_out_123121.awb")

						arg_405_1:RecordAudio("123121099", var_408_6)
						arg_405_1:RecordAudio("123121099", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_123121", "123121099", "story_v_out_123121.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_123121", "123121099", "story_v_out_123121.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play123121100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 123121100
		arg_409_1.duration_ = 15.7

		local var_409_0 = {
			zh = 15.7,
			ja = 10.633
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play123121101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 1.375

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:GetWordFromCfg(123121100)
				local var_412_2 = arg_409_1:FormatText(var_412_1.content)

				arg_409_1.text_.text = var_412_2

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 55 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 55)

				if (55 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 55)) > 0 and var_412_0 < var_412_4 then
					arg_409_1.talkMaxDuration = var_412_4

					if var_412_4 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_4 + 0
					end
				end

				arg_409_1.text_.text = var_412_2
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121100", "story_v_out_123121.awb") ~= 0 then
					local var_412_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121100", "story_v_out_123121.awb") / 1000

					if var_412_5 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + 0
					end

					if var_412_1.prefab_name ~= "" and arg_409_1.actors_[var_412_1.prefab_name] ~= nil then
						local var_412_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_1.prefab_name].transform, "story_v_out_123121", "123121100", "story_v_out_123121.awb")

						arg_409_1:RecordAudio("123121100", var_412_6)
						arg_409_1:RecordAudio("123121100", var_412_6)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_123121", "123121100", "story_v_out_123121.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_123121", "123121100", "story_v_out_123121.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play123121101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 123121101
		arg_413_1.duration_ = 7.73

		local var_413_0 = {
			zh = 6.166,
			ja = 7.733
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play123121102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.675

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:GetWordFromCfg(123121101)
				local var_416_2 = arg_413_1:FormatText(var_416_1.content)

				arg_413_1.text_.text = var_416_2

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_4 = 27 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 27)

				if (27 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_2) / 27)) > 0 and var_416_0 < var_416_4 then
					arg_413_1.talkMaxDuration = var_416_4

					if var_416_4 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_4 + 0
					end
				end

				arg_413_1.text_.text = var_416_2
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121101", "story_v_out_123121.awb") ~= 0 then
					local var_416_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121101", "story_v_out_123121.awb") / 1000

					if var_416_5 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + 0
					end

					if var_416_1.prefab_name ~= "" and arg_413_1.actors_[var_416_1.prefab_name] ~= nil then
						local var_416_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_1.prefab_name].transform, "story_v_out_123121", "123121101", "story_v_out_123121.awb")

						arg_413_1:RecordAudio("123121101", var_416_6)
						arg_413_1:RecordAudio("123121101", var_416_6)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_123121", "123121101", "story_v_out_123121.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_123121", "123121101", "story_v_out_123121.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_7 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_7 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_7

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_7 and arg_413_1.time_ < 0 + var_416_7 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play123121102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 123121102
		arg_417_1.duration_ = 4.6

		local var_417_0 = {
			zh = 1.766,
			ja = 4.6
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play123121103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.15

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:GetWordFromCfg(123121102)
				local var_420_2 = arg_417_1:FormatText(var_420_1.content)

				arg_417_1.text_.text = var_420_2

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_4 = 6 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 6)

				if (6 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_2) / 6)) > 0 and var_420_0 < var_420_4 then
					arg_417_1.talkMaxDuration = var_420_4

					if var_420_4 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_4 + 0
					end
				end

				arg_417_1.text_.text = var_420_2
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121102", "story_v_out_123121.awb") ~= 0 then
					local var_420_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121102", "story_v_out_123121.awb") / 1000

					if var_420_5 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + 0
					end

					if var_420_1.prefab_name ~= "" and arg_417_1.actors_[var_420_1.prefab_name] ~= nil then
						local var_420_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_1.prefab_name].transform, "story_v_out_123121", "123121102", "story_v_out_123121.awb")

						arg_417_1:RecordAudio("123121102", var_420_6)
						arg_417_1:RecordAudio("123121102", var_420_6)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_123121", "123121102", "story_v_out_123121.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_123121", "123121102", "story_v_out_123121.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_7 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_7 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_7

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_7 and arg_417_1.time_ < 0 + var_420_7 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play123121103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 123121103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play123121104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_ice", "")
			end

			local var_424_1 = 0
			local var_424_2 = 0.75

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(123121103).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 30 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 30)

				if (30 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 30)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play123121104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 123121104
		arg_425_1.duration_ = 16.07

		local var_425_0 = {
			zh = 16.066,
			ja = 15.8
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play123121105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 1.375

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:GetWordFromCfg(123121104)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 55 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 55)

				if (55 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 55)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121104", "story_v_out_123121.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121104", "story_v_out_123121.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_123121", "123121104", "story_v_out_123121.awb")

						arg_425_1:RecordAudio("123121104", var_428_6)
						arg_425_1:RecordAudio("123121104", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_123121", "123121104", "story_v_out_123121.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_123121", "123121104", "story_v_out_123121.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play123121105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 123121105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play123121106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1.125

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(123121105).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 45 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 45)

				if (45 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 45)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play123121106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 123121106
		arg_433_1.duration_ = 7.13

		local var_433_0 = {
			zh = 6.833,
			ja = 7.133
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play123121107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_436_0 = 0.6

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				local var_436_1, var_436_2 = math.modf((arg_433_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_436_2 * 0.13, var_436_2 * 0.13, var_436_2 * 0.13) + arg_433_1.var_.shakeOldPos
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				manager.ui.mainCamera.transform.localPosition = arg_433_1.var_.shakeOldPos
			end

			local var_436_3 = 0

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_3 + arg_436_0 then
				arg_433_1.allBtn_.enabled = false
			end

			if arg_433_1.time_ >= var_436_3 + 0.6 and arg_433_1.time_ < var_436_3 + 0.6 + arg_436_0 then
				arg_433_1.allBtn_.enabled = true
			end

			local var_436_4 = 0
			local var_436_5 = 0.5

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_6 = arg_433_1:GetWordFromCfg(123121106)
				local var_436_7 = arg_433_1:FormatText(var_436_6.content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 20 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 20)

				if (20 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 20)) > 0 and var_436_5 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_4
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121106", "story_v_out_123121.awb") ~= 0 then
					local var_436_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121106", "story_v_out_123121.awb") / 1000

					if var_436_10 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_4
					end

					if var_436_6.prefab_name ~= "" and arg_433_1.actors_[var_436_6.prefab_name] ~= nil then
						local var_436_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_6.prefab_name].transform, "story_v_out_123121", "123121106", "story_v_out_123121.awb")

						arg_433_1:RecordAudio("123121106", var_436_11)
						arg_433_1:RecordAudio("123121106", var_436_11)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_123121", "123121106", "story_v_out_123121.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_123121", "123121106", "story_v_out_123121.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_12 = math.max(var_436_5, arg_433_1.talkMaxDuration)

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_12 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_4) / var_436_12

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_4 + var_436_12 and arg_433_1.time_ < var_436_4 + var_436_12 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play123121107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 123121107
		arg_437_1.duration_ = 10.07

		local var_437_0 = {
			zh = 9.266,
			ja = 10.066
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play123121108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.95

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_1 = arg_437_1:GetWordFromCfg(123121107)
				local var_440_2 = arg_437_1:FormatText(var_440_1.content)

				arg_437_1.text_.text = var_440_2

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_4 = 38 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 38)

				if (38 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_2) / 38)) > 0 and var_440_0 < var_440_4 then
					arg_437_1.talkMaxDuration = var_440_4

					if var_440_4 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_4 + 0
					end
				end

				arg_437_1.text_.text = var_440_2
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121107", "story_v_out_123121.awb") ~= 0 then
					local var_440_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121107", "story_v_out_123121.awb") / 1000

					if var_440_5 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + 0
					end

					if var_440_1.prefab_name ~= "" and arg_437_1.actors_[var_440_1.prefab_name] ~= nil then
						local var_440_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_1.prefab_name].transform, "story_v_out_123121", "123121107", "story_v_out_123121.awb")

						arg_437_1:RecordAudio("123121107", var_440_6)
						arg_437_1:RecordAudio("123121107", var_440_6)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_123121", "123121107", "story_v_out_123121.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_123121", "123121107", "story_v_out_123121.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play123121108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 123121108
		arg_441_1.duration_ = 11.5

		local var_441_0 = {
			zh = 8.5,
			ja = 11.5
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play123121109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.975

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:GetWordFromCfg(123121108)
				local var_444_2 = arg_441_1:FormatText(var_444_1.content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 39 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 39)

				if (39 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 39)) > 0 and var_444_0 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + 0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121108", "story_v_out_123121.awb") ~= 0 then
					local var_444_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121108", "story_v_out_123121.awb") / 1000

					if var_444_5 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + 0
					end

					if var_444_1.prefab_name ~= "" and arg_441_1.actors_[var_444_1.prefab_name] ~= nil then
						local var_444_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_1.prefab_name].transform, "story_v_out_123121", "123121108", "story_v_out_123121.awb")

						arg_441_1:RecordAudio("123121108", var_444_6)
						arg_441_1:RecordAudio("123121108", var_444_6)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_123121", "123121108", "story_v_out_123121.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_123121", "123121108", "story_v_out_123121.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play123121109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 123121109
		arg_445_1.duration_ = 10.57

		local var_445_0 = {
			zh = 9.333,
			ja = 10.566
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play123121110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.975

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:GetWordFromCfg(123121109)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 39 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 39)

				if (39 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 39)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121109", "story_v_out_123121.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121109", "story_v_out_123121.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_out_123121", "123121109", "story_v_out_123121.awb")

						arg_445_1:RecordAudio("123121109", var_448_6)
						arg_445_1:RecordAudio("123121109", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_123121", "123121109", "story_v_out_123121.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_123121", "123121109", "story_v_out_123121.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play123121110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 123121110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play123121111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_ice2", "")
			end

			local var_452_1 = 0
			local var_452_2 = 0.575

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(123121110).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 24 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 24)

				if (24 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 24)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play123121111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 123121111
		arg_453_1.duration_ = 6.9

		local var_453_0 = {
			zh = 6.166,
			ja = 6.9
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play123121112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.375

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_1 = arg_453_1:GetWordFromCfg(123121111)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 15 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 15)

				if (15 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 15)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121111", "story_v_out_123121.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121111", "story_v_out_123121.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_out_123121", "123121111", "story_v_out_123121.awb")

						arg_453_1:RecordAudio("123121111", var_456_6)
						arg_453_1:RecordAudio("123121111", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_123121", "123121111", "story_v_out_123121.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_123121", "123121111", "story_v_out_123121.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play123121112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 123121112
		arg_457_1.duration_ = 3.97

		local var_457_0 = {
			zh = 3.966,
			ja = 3.733
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play123121113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.425

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:GetWordFromCfg(123121112)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 17 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 17)

				if (17 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 17)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121112", "story_v_out_123121.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121112", "story_v_out_123121.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_123121", "123121112", "story_v_out_123121.awb")

						arg_457_1:RecordAudio("123121112", var_460_6)
						arg_457_1:RecordAudio("123121112", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_123121", "123121112", "story_v_out_123121.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_123121", "123121112", "story_v_out_123121.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play123121113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 123121113
		arg_461_1.duration_ = 12.97

		local var_461_0 = {
			zh = 8.9,
			ja = 12.966
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play123121114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 1

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:GetWordFromCfg(123121113)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 40 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 40)

				if (40 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 40)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121113", "story_v_out_123121.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121113", "story_v_out_123121.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_123121", "123121113", "story_v_out_123121.awb")

						arg_461_1:RecordAudio("123121113", var_464_6)
						arg_461_1:RecordAudio("123121113", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_123121", "123121113", "story_v_out_123121.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_123121", "123121113", "story_v_out_123121.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play123121114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 123121114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play123121115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.825

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(123121114).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 33 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 33)

				if (33 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 33)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play123121115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 123121115
		arg_469_1.duration_ = 6

		local var_469_0 = {
			zh = 2.566,
			ja = 6
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play123121116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.2

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:GetWordFromCfg(123121115)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 8 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 8)

				if (8 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 8)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121115", "story_v_out_123121.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_123121", "123121115", "story_v_out_123121.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_123121", "123121115", "story_v_out_123121.awb")

						arg_469_1:RecordAudio("123121115", var_472_6)
						arg_469_1:RecordAudio("123121115", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_123121", "123121115", "story_v_out_123121.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_123121", "123121115", "story_v_out_123121.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play123121116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 123121116
		arg_473_1.duration_ = 9

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play123121117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 2 < arg_473_1.time_ and arg_473_1.time_ <= 2 + arg_476_0 then
				local var_476_0 = arg_473_1.bgs_.K05g

				arg_473_1.bgs_.K05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_476_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_476_1 = var_476_0:GetComponent("SpriteRenderer")

				if var_476_1 and var_476_1.sprite then
					local var_476_2 = 2 * (var_476_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_476_0.transform.localScale = Vector3.New(var_476_2 / var_476_1.sprite.bounds.size.y < var_476_2 * manager.ui.mainCameraCom_.aspect / var_476_1.sprite.bounds.size.x and var_476_2 * manager.ui.mainCameraCom_.aspect / var_476_1.sprite.bounds.size.x or var_476_2 / var_476_1.sprite.bounds.size.y, var_476_2 / var_476_1.sprite.bounds.size.y < var_476_2 * manager.ui.mainCameraCom_.aspect / var_476_1.sprite.bounds.size.x and var_476_2 * manager.ui.mainCameraCom_.aspect / var_476_1.sprite.bounds.size.x or var_476_2 / var_476_1.sprite.bounds.size.y, 0)
				end

				for iter_476_0, iter_476_1 in pairs(arg_473_1.bgs_) do
					if iter_476_0 ~= "K05g" then
						iter_476_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_476_3 = 0

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_3 + arg_476_0 then
				arg_473_1.mask_.enabled = true
				arg_473_1.mask_.raycastTarget = true

				arg_473_1:SetGaussion(false)
			end

			local var_476_4 = 2

			if var_476_3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_3 + var_476_4 then
				local var_476_5 = Color.New(0, 0, 0)

				var_476_5.a = Mathf.Lerp(0, 1, (arg_473_1.time_ - var_476_3) / var_476_4)
				arg_473_1.mask_.color = var_476_5
			end

			if arg_473_1.time_ >= var_476_3 + var_476_4 and arg_473_1.time_ < var_476_3 + var_476_4 + arg_476_0 then
				local var_476_6 = Color.New(0, 0, 0)

				var_476_6.a = 1
				arg_473_1.mask_.color = var_476_6
			end

			local var_476_7 = 2

			if 2 < arg_473_1.time_ and arg_473_1.time_ <= var_476_7 + arg_476_0 then
				arg_473_1.mask_.enabled = true
				arg_473_1.mask_.raycastTarget = true

				arg_473_1:SetGaussion(false)
			end

			local var_476_8 = 2

			if var_476_7 <= arg_473_1.time_ and arg_473_1.time_ < var_476_7 + var_476_8 then
				local var_476_9 = Color.New(0, 0, 0)

				var_476_9.a = Mathf.Lerp(1, 0, (arg_473_1.time_ - var_476_7) / var_476_8)
				arg_473_1.mask_.color = var_476_9
			end

			if arg_473_1.time_ >= var_476_7 + var_476_8 and arg_473_1.time_ < var_476_7 + var_476_8 + arg_476_0 then
				local var_476_10 = Color.New(0, 0, 0)

				arg_473_1.mask_.enabled = false
				var_476_10.a = 0
				arg_473_1.mask_.color = var_476_10
			end

			if arg_473_1.frameCnt_ <= 1 then
				arg_473_1.dialog_:SetActive(false)
			end

			local var_476_11 = 4
			local var_476_12 = 1

			if 4 < arg_473_1.time_ and arg_473_1.time_ <= var_476_11 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0

				arg_473_1.dialog_:SetActive(true)

				arg_473_1.dialogCg_.alpha = 0

				local var_476_13 = LeanTween.value(arg_473_1.dialog_, 0, 1, 0.3)

				var_476_13:setOnUpdate(LuaHelper.FloatAction(function(arg_477_0)
					arg_473_1.dialogCg_.alpha = arg_477_0
				end))
				var_476_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_473_1.dialog_)
					var_476_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_473_1.duration_ = arg_473_1.duration_ + 0.3

				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_14 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(123121116).content)

				arg_473_1.text_.text = var_476_14

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_16 = 40 <= 0 and var_476_12 or var_476_12 * (utf8.len(var_476_14) / 40)

				if (40 <= 0 and var_476_12 or var_476_12 * (utf8.len(var_476_14) / 40)) > 0 and var_476_12 < var_476_16 then
					arg_473_1.talkMaxDuration = var_476_16
					var_476_11 = var_476_11 + 0.3

					if var_476_16 + var_476_11 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_16 + var_476_11
					end
				end

				arg_473_1.text_.text = var_476_14
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_17 = var_476_11 + 0.3
			local var_476_18 = math.max(var_476_12, arg_473_1.talkMaxDuration)

			if var_476_11 + 0.3 <= arg_473_1.time_ and arg_473_1.time_ < var_476_17 + var_476_18 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_17) / var_476_18

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_17 + var_476_18 and arg_473_1.time_ < var_476_17 + var_476_18 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play123121117 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 123121117
		arg_479_1.duration_ = 4.73

		local var_479_0 = {
			zh = 4.733,
			ja = 4.666
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play123121118(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1093ui_story = arg_479_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_479_1.time_ - 0) / var_482_0)
				arg_479_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1093ui_story"].transform.position).z)
				arg_479_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1093ui_story"].transform.localEulerAngles = arg_479_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_479_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1093ui_story"].transform.position).z)
				arg_479_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1093ui_story"].transform.localEulerAngles = arg_479_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_482_1 = arg_479_1.actors_["1093ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1093ui_story == nil then
				arg_479_1.var_.characterEffect1093ui_story = var_482_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_2 and not isNil(var_482_1) then
				if arg_479_1.var_.characterEffect1093ui_story and not isNil(var_482_1) then
					arg_479_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_2 and arg_479_1.time_ < 0 + var_482_2 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1093ui_story then
				arg_479_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_4 = 0
			local var_482_5 = 0.425

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_6 = arg_479_1:GetWordFromCfg(123121117)
				local var_482_7 = arg_479_1:FormatText(var_482_6.content)

				arg_479_1.text_.text = var_482_7

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_9 = 17 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 17)

				if (17 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 17)) > 0 and var_482_5 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_4
					end
				end

				arg_479_1.text_.text = var_482_7
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121117", "story_v_out_123121.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121117", "story_v_out_123121.awb") / 1000

					if var_482_10 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_4
					end

					if var_482_6.prefab_name ~= "" and arg_479_1.actors_[var_482_6.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_6.prefab_name].transform, "story_v_out_123121", "123121117", "story_v_out_123121.awb")

						arg_479_1:RecordAudio("123121117", var_482_11)
						arg_479_1:RecordAudio("123121117", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_123121", "123121117", "story_v_out_123121.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_123121", "123121117", "story_v_out_123121.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_5, arg_479_1.talkMaxDuration)

			if var_482_4 <= arg_479_1.time_ and arg_479_1.time_ < var_482_4 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_4) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_4 + var_482_12 and arg_479_1.time_ < var_482_4 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play123121118 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 123121118
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play123121119(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1093ui_story"]) and arg_483_1.var_.characterEffect1093ui_story == nil then
				arg_483_1.var_.characterEffect1093ui_story = arg_483_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1093ui_story"]) then
				if arg_483_1.var_.characterEffect1093ui_story and not isNil(arg_483_1.actors_["1093ui_story"]) then
					arg_483_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_483_1.time_ - 0) / var_486_0)
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1093ui_story"]) and arg_483_1.var_.characterEffect1093ui_story then
				arg_483_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_486_1 = 0
			local var_486_2 = 0.775

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_3 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(123121118).content)

				arg_483_1.text_.text = var_486_3

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 31 <= 0 and var_486_2 or var_486_2 * (utf8.len(var_486_3) / 31)

				if (31 <= 0 and var_486_2 or var_486_2 * (utf8.len(var_486_3) / 31)) > 0 and var_486_2 < var_486_5 then
					arg_483_1.talkMaxDuration = var_486_5

					if var_486_5 + var_486_1 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_5 + var_486_1
					end
				end

				arg_483_1.text_.text = var_486_3
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_6 = math.max(var_486_2, arg_483_1.talkMaxDuration)

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_6 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_1) / var_486_6

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_1 + var_486_6 and arg_483_1.time_ < var_486_1 + var_486_6 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play123121119 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 123121119
		arg_487_1.duration_ = 7.97

		local var_487_0 = {
			zh = 4.333,
			ja = 7.966
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play123121120(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1093ui_story = arg_487_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_490_0 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 then
				arg_487_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_487_1.time_ - 0) / var_490_0)
				arg_487_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1093ui_story"].transform.position).z)
				arg_487_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1093ui_story"].transform.localEulerAngles = arg_487_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 then
				arg_487_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_487_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_487_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_487_1.actors_["1093ui_story"].transform.position).z)
				arg_487_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_487_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_487_1.actors_["1093ui_story"].transform.localEulerAngles = arg_487_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_490_1 = arg_487_1.actors_["1093ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1093ui_story == nil then
				arg_487_1.var_.characterEffect1093ui_story = var_490_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_2 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_2 and not isNil(var_490_1) then
				if arg_487_1.var_.characterEffect1093ui_story and not isNil(var_490_1) then
					arg_487_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_487_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_487_1.time_ - 0) / var_490_2)
				end
			end

			if arg_487_1.time_ >= 0 + var_490_2 and arg_487_1.time_ < 0 + var_490_2 + arg_490_0 and not isNil(var_490_1) and arg_487_1.var_.characterEffect1093ui_story then
				arg_487_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_487_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_490_3 = arg_487_1.actors_["1055ui_story"].transform

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos1055ui_story = var_490_3.localPosition
			end

			local var_490_4 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				var_490_3.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_487_1.time_ - 0) / var_490_4)
				var_490_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_3.position).x, (manager.ui.mainCamera.transform.position - var_490_3.position).y, (manager.ui.mainCamera.transform.position - var_490_3.position).z)
				var_490_3.localEulerAngles.z = 0
				var_490_3.localEulerAngles.x = 0
				var_490_3.localEulerAngles = var_490_3.localEulerAngles
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				var_490_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_490_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_490_3.position).x, (manager.ui.mainCamera.transform.position - var_490_3.position).y, (manager.ui.mainCamera.transform.position - var_490_3.position).z)
				var_490_3.localEulerAngles.z = 0
				var_490_3.localEulerAngles.x = 0
				var_490_3.localEulerAngles = var_490_3.localEulerAngles
			end

			local var_490_5 = arg_487_1.actors_["1055ui_story"]

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(var_490_5) and arg_487_1.var_.characterEffect1055ui_story == nil then
				arg_487_1.var_.characterEffect1055ui_story = var_490_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_6 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_6 and not isNil(var_490_5) then
				if arg_487_1.var_.characterEffect1055ui_story and not isNil(var_490_5) then
					arg_487_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_6 and arg_487_1.time_ < 0 + var_490_6 + arg_490_0 and not isNil(var_490_5) and arg_487_1.var_.characterEffect1055ui_story then
				arg_487_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_490_8 = 0
			local var_490_9 = 0.625

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_8 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_10 = arg_487_1:GetWordFromCfg(123121119)
				local var_490_11 = arg_487_1:FormatText(var_490_10.content)

				arg_487_1.text_.text = var_490_11

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_13 = 25 <= 0 and var_490_9 or var_490_9 * (utf8.len(var_490_11) / 25)

				if (25 <= 0 and var_490_9 or var_490_9 * (utf8.len(var_490_11) / 25)) > 0 and var_490_9 < var_490_13 then
					arg_487_1.talkMaxDuration = var_490_13

					if var_490_13 + var_490_8 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_13 + var_490_8
					end
				end

				arg_487_1.text_.text = var_490_11
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121119", "story_v_out_123121.awb") ~= 0 then
					local var_490_14 = manager.audio:GetVoiceLength("story_v_out_123121", "123121119", "story_v_out_123121.awb") / 1000

					if var_490_14 + var_490_8 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_14 + var_490_8
					end

					if var_490_10.prefab_name ~= "" and arg_487_1.actors_[var_490_10.prefab_name] ~= nil then
						local var_490_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_10.prefab_name].transform, "story_v_out_123121", "123121119", "story_v_out_123121.awb")

						arg_487_1:RecordAudio("123121119", var_490_15)
						arg_487_1:RecordAudio("123121119", var_490_15)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_123121", "123121119", "story_v_out_123121.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_123121", "123121119", "story_v_out_123121.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_16 = math.max(var_490_9, arg_487_1.talkMaxDuration)

			if var_490_8 <= arg_487_1.time_ and arg_487_1.time_ < var_490_8 + var_490_16 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_8) / var_490_16

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_8 + var_490_16 and arg_487_1.time_ < var_490_8 + var_490_16 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play123121120 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 123121120
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play123121121(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["1055ui_story"]) and arg_491_1.var_.characterEffect1055ui_story == nil then
				arg_491_1.var_.characterEffect1055ui_story = arg_491_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_0 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["1055ui_story"]) then
				if arg_491_1.var_.characterEffect1055ui_story and not isNil(arg_491_1.actors_["1055ui_story"]) then
					arg_491_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_491_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_491_1.time_ - 0) / var_494_0)
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["1055ui_story"]) and arg_491_1.var_.characterEffect1055ui_story then
				arg_491_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_491_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_494_1 = 0
			local var_494_2 = 1.7

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_3 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(123121120).content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 68 <= 0 and var_494_2 or var_494_2 * (utf8.len(var_494_3) / 68)

				if (68 <= 0 and var_494_2 or var_494_2 * (utf8.len(var_494_3) / 68)) > 0 and var_494_2 < var_494_5 then
					arg_491_1.talkMaxDuration = var_494_5

					if var_494_5 + var_494_1 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + var_494_1
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_6 = math.max(var_494_2, arg_491_1.talkMaxDuration)

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_6 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_1) / var_494_6

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_1 + var_494_6 and arg_491_1.time_ < var_494_1 + var_494_6 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play123121121 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 123121121
		arg_495_1.duration_ = 6.97

		local var_495_0 = {
			zh = 4.933,
			ja = 6.966
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play123121122(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["1055ui_story"]) and arg_495_1.var_.characterEffect1055ui_story == nil then
				arg_495_1.var_.characterEffect1055ui_story = arg_495_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["1055ui_story"]) then
				if arg_495_1.var_.characterEffect1055ui_story and not isNil(arg_495_1.actors_["1055ui_story"]) then
					arg_495_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["1055ui_story"]) and arg_495_1.var_.characterEffect1055ui_story then
				arg_495_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action4_1")
			end

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_498_2 = 0
			local var_498_3 = 0.475

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_4 = arg_495_1:GetWordFromCfg(123121121)
				local var_498_5 = arg_495_1:FormatText(var_498_4.content)

				arg_495_1.text_.text = var_498_5

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_7 = 19 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_5) / 19)

				if (19 <= 0 and var_498_3 or var_498_3 * (utf8.len(var_498_5) / 19)) > 0 and var_498_3 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_2
					end
				end

				arg_495_1.text_.text = var_498_5
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121121", "story_v_out_123121.awb") ~= 0 then
					local var_498_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121121", "story_v_out_123121.awb") / 1000

					if var_498_8 + var_498_2 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_8 + var_498_2
					end

					if var_498_4.prefab_name ~= "" and arg_495_1.actors_[var_498_4.prefab_name] ~= nil then
						local var_498_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_4.prefab_name].transform, "story_v_out_123121", "123121121", "story_v_out_123121.awb")

						arg_495_1:RecordAudio("123121121", var_498_9)
						arg_495_1:RecordAudio("123121121", var_498_9)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_123121", "123121121", "story_v_out_123121.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_123121", "123121121", "story_v_out_123121.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_10 = math.max(var_498_3, arg_495_1.talkMaxDuration)

			if var_498_2 <= arg_495_1.time_ and arg_495_1.time_ < var_498_2 + var_498_10 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_2) / var_498_10

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_2 + var_498_10 and arg_495_1.time_ < var_498_2 + var_498_10 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play123121122 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 123121122
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play123121123(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1055ui_story"]) and arg_499_1.var_.characterEffect1055ui_story == nil then
				arg_499_1.var_.characterEffect1055ui_story = arg_499_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1055ui_story"]) then
				if arg_499_1.var_.characterEffect1055ui_story and not isNil(arg_499_1.actors_["1055ui_story"]) then
					arg_499_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_499_1.time_ - 0) / var_502_0)
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1055ui_story"]) and arg_499_1.var_.characterEffect1055ui_story then
				arg_499_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_502_1 = 0
			local var_502_2 = 0.875

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_3 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(123121122).content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_5 = 35 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_3) / 35)

				if (35 <= 0 and var_502_2 or var_502_2 * (utf8.len(var_502_3) / 35)) > 0 and var_502_2 < var_502_5 then
					arg_499_1.talkMaxDuration = var_502_5

					if var_502_5 + var_502_1 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + var_502_1
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_6 = math.max(var_502_2, arg_499_1.talkMaxDuration)

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_6 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_1) / var_502_6

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_1 + var_502_6 and arg_499_1.time_ < var_502_1 + var_502_6 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play123121123 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 123121123
		arg_503_1.duration_ = 2

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play123121124(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1055ui_story"]) and arg_503_1.var_.characterEffect1055ui_story == nil then
				arg_503_1.var_.characterEffect1055ui_story = arg_503_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1055ui_story"]) then
				if arg_503_1.var_.characterEffect1055ui_story and not isNil(arg_503_1.actors_["1055ui_story"]) then
					arg_503_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1055ui_story"]) and arg_503_1.var_.characterEffect1055ui_story then
				arg_503_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action4_2")
			end

			local var_506_2 = 0
			local var_506_3 = 0.125

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_4 = arg_503_1:GetWordFromCfg(123121123)
				local var_506_5 = arg_503_1:FormatText(var_506_4.content)

				arg_503_1.text_.text = var_506_5

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_7 = 5 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_5) / 5)

				if (5 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_5) / 5)) > 0 and var_506_3 < var_506_7 then
					arg_503_1.talkMaxDuration = var_506_7

					if var_506_7 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_2
					end
				end

				arg_503_1.text_.text = var_506_5
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121123", "story_v_out_123121.awb") ~= 0 then
					local var_506_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121123", "story_v_out_123121.awb") / 1000

					if var_506_8 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_8 + var_506_2
					end

					if var_506_4.prefab_name ~= "" and arg_503_1.actors_[var_506_4.prefab_name] ~= nil then
						local var_506_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_4.prefab_name].transform, "story_v_out_123121", "123121123", "story_v_out_123121.awb")

						arg_503_1:RecordAudio("123121123", var_506_9)
						arg_503_1:RecordAudio("123121123", var_506_9)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_123121", "123121123", "story_v_out_123121.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_123121", "123121123", "story_v_out_123121.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_10 = math.max(var_506_3, arg_503_1.talkMaxDuration)

			if var_506_2 <= arg_503_1.time_ and arg_503_1.time_ < var_506_2 + var_506_10 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_2) / var_506_10

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_2 + var_506_10 and arg_503_1.time_ < var_506_2 + var_506_10 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play123121124 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 123121124
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play123121125(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["1055ui_story"]) and arg_507_1.var_.characterEffect1055ui_story == nil then
				arg_507_1.var_.characterEffect1055ui_story = arg_507_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_0 = 0.200000002980232

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["1055ui_story"]) then
				if arg_507_1.var_.characterEffect1055ui_story and not isNil(arg_507_1.actors_["1055ui_story"]) then
					arg_507_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_507_1.time_ - 0) / var_510_0)
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["1055ui_story"]) and arg_507_1.var_.characterEffect1055ui_story then
				arg_507_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_510_1 = 0
			local var_510_2 = 1.4

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(123121124).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 56 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 56)

				if (56 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 56)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play123121125 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 123121125
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play123121126(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.825

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(123121125).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 33 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 33)

				if (33 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 33)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play123121126 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 123121126
		arg_515_1.duration_ = 7.6

		local var_515_0 = {
			zh = 7.6,
			ja = 7.4
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play123121127(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1055ui_story"]) and arg_515_1.var_.characterEffect1055ui_story == nil then
				arg_515_1.var_.characterEffect1055ui_story = arg_515_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1055ui_story"]) then
				if arg_515_1.var_.characterEffect1055ui_story and not isNil(arg_515_1.actors_["1055ui_story"]) then
					arg_515_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1055ui_story"]) and arg_515_1.var_.characterEffect1055ui_story then
				arg_515_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_518_2 = 0
			local var_518_3 = 0.9

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_2 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_4 = arg_515_1:GetWordFromCfg(123121126)
				local var_518_5 = arg_515_1:FormatText(var_518_4.content)

				arg_515_1.text_.text = var_518_5

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_7 = 36 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 36)

				if (36 <= 0 and var_518_3 or var_518_3 * (utf8.len(var_518_5) / 36)) > 0 and var_518_3 < var_518_7 then
					arg_515_1.talkMaxDuration = var_518_7

					if var_518_7 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_2
					end
				end

				arg_515_1.text_.text = var_518_5
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121126", "story_v_out_123121.awb") ~= 0 then
					local var_518_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121126", "story_v_out_123121.awb") / 1000

					if var_518_8 + var_518_2 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_8 + var_518_2
					end

					if var_518_4.prefab_name ~= "" and arg_515_1.actors_[var_518_4.prefab_name] ~= nil then
						local var_518_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_4.prefab_name].transform, "story_v_out_123121", "123121126", "story_v_out_123121.awb")

						arg_515_1:RecordAudio("123121126", var_518_9)
						arg_515_1:RecordAudio("123121126", var_518_9)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_123121", "123121126", "story_v_out_123121.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_123121", "123121126", "story_v_out_123121.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_10 = math.max(var_518_3, arg_515_1.talkMaxDuration)

			if var_518_2 <= arg_515_1.time_ and arg_515_1.time_ < var_518_2 + var_518_10 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_2) / var_518_10

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_2 + var_518_10 and arg_515_1.time_ < var_518_2 + var_518_10 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play123121127 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 123121127
		arg_519_1.duration_ = 11.73

		local var_519_0 = {
			zh = 10.433,
			ja = 11.733
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play123121128(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_522_0 = 0
			local var_522_1 = 1.2

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_2 = arg_519_1:GetWordFromCfg(123121127)
				local var_522_3 = arg_519_1:FormatText(var_522_2.content)

				arg_519_1.text_.text = var_522_3

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 48 <= 0 and var_522_1 or var_522_1 * (utf8.len(var_522_3) / 48)

				if (48 <= 0 and var_522_1 or var_522_1 * (utf8.len(var_522_3) / 48)) > 0 and var_522_1 < var_522_5 then
					arg_519_1.talkMaxDuration = var_522_5

					if var_522_5 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_3
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121127", "story_v_out_123121.awb") ~= 0 then
					local var_522_6 = manager.audio:GetVoiceLength("story_v_out_123121", "123121127", "story_v_out_123121.awb") / 1000

					if var_522_6 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_6 + var_522_0
					end

					if var_522_2.prefab_name ~= "" and arg_519_1.actors_[var_522_2.prefab_name] ~= nil then
						local var_522_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_2.prefab_name].transform, "story_v_out_123121", "123121127", "story_v_out_123121.awb")

						arg_519_1:RecordAudio("123121127", var_522_7)
						arg_519_1:RecordAudio("123121127", var_522_7)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_123121", "123121127", "story_v_out_123121.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_123121", "123121127", "story_v_out_123121.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play123121128 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 123121128
		arg_523_1.duration_ = 8.73

		local var_523_0 = {
			zh = 8.733,
			ja = 6.8
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play123121129(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_526_0 = 0
			local var_526_1 = 1.05

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_2 = arg_523_1:GetWordFromCfg(123121128)
				local var_526_3 = arg_523_1:FormatText(var_526_2.content)

				arg_523_1.text_.text = var_526_3

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 42 <= 0 and var_526_1 or var_526_1 * (utf8.len(var_526_3) / 42)

				if (42 <= 0 and var_526_1 or var_526_1 * (utf8.len(var_526_3) / 42)) > 0 and var_526_1 < var_526_5 then
					arg_523_1.talkMaxDuration = var_526_5

					if var_526_5 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_5 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_3
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121128", "story_v_out_123121.awb") ~= 0 then
					local var_526_6 = manager.audio:GetVoiceLength("story_v_out_123121", "123121128", "story_v_out_123121.awb") / 1000

					if var_526_6 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_0
					end

					if var_526_2.prefab_name ~= "" and arg_523_1.actors_[var_526_2.prefab_name] ~= nil then
						local var_526_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_2.prefab_name].transform, "story_v_out_123121", "123121128", "story_v_out_123121.awb")

						arg_523_1:RecordAudio("123121128", var_526_7)
						arg_523_1:RecordAudio("123121128", var_526_7)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_123121", "123121128", "story_v_out_123121.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_123121", "123121128", "story_v_out_123121.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_8 and arg_523_1.time_ < var_526_0 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play123121129 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 123121129
		arg_527_1.duration_ = 2

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play123121130(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1093ui_story = arg_527_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_530_0 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 then
				arg_527_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_527_1.time_ - 0) / var_530_0)
				arg_527_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1093ui_story"].transform.position).z)
				arg_527_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1093ui_story"].transform.localEulerAngles = arg_527_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 then
				arg_527_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_527_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1093ui_story"].transform.position).z)
				arg_527_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1093ui_story"].transform.localEulerAngles = arg_527_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_530_1 = arg_527_1.actors_["1093ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1093ui_story == nil then
				arg_527_1.var_.characterEffect1093ui_story = var_530_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_2 and not isNil(var_530_1) then
				if arg_527_1.var_.characterEffect1093ui_story and not isNil(var_530_1) then
					arg_527_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_2 and arg_527_1.time_ < 0 + var_530_2 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1093ui_story then
				arg_527_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_530_4 = arg_527_1.actors_["1055ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1055ui_story = var_530_4.localPosition
			end

			local var_530_5 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_5 then
				var_530_4.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_527_1.time_ - 0) / var_530_5)
				var_530_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_4.position).x, (manager.ui.mainCamera.transform.position - var_530_4.position).y, (manager.ui.mainCamera.transform.position - var_530_4.position).z)
				var_530_4.localEulerAngles.z = 0
				var_530_4.localEulerAngles.x = 0
				var_530_4.localEulerAngles = var_530_4.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_5 and arg_527_1.time_ < 0 + var_530_5 + arg_530_0 then
				var_530_4.localPosition = Vector3.New(0, 100, 0)
				var_530_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_4.position).x, (manager.ui.mainCamera.transform.position - var_530_4.position).y, (manager.ui.mainCamera.transform.position - var_530_4.position).z)
				var_530_4.localEulerAngles.z = 0
				var_530_4.localEulerAngles.x = 0
				var_530_4.localEulerAngles = var_530_4.localEulerAngles
			end

			local var_530_6 = arg_527_1.actors_["1055ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_6) and arg_527_1.var_.characterEffect1055ui_story == nil then
				arg_527_1.var_.characterEffect1055ui_story = var_530_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_7 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 and not isNil(var_530_6) then
				if arg_527_1.var_.characterEffect1055ui_story and not isNil(var_530_6) then
					arg_527_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_7)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 and not isNil(var_530_6) and arg_527_1.var_.characterEffect1055ui_story then
				arg_527_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_530_8 = 0
			local var_530_9 = 0.2

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_8 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_10 = arg_527_1:GetWordFromCfg(123121129)
				local var_530_11 = arg_527_1:FormatText(var_530_10.content)

				arg_527_1.text_.text = var_530_11

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_13 = 8 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 8)

				if (8 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 8)) > 0 and var_530_9 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_8
					end
				end

				arg_527_1.text_.text = var_530_11
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121129", "story_v_out_123121.awb") ~= 0 then
					local var_530_14 = manager.audio:GetVoiceLength("story_v_out_123121", "123121129", "story_v_out_123121.awb") / 1000

					if var_530_14 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_8
					end

					if var_530_10.prefab_name ~= "" and arg_527_1.actors_[var_530_10.prefab_name] ~= nil then
						local var_530_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_10.prefab_name].transform, "story_v_out_123121", "123121129", "story_v_out_123121.awb")

						arg_527_1:RecordAudio("123121129", var_530_15)
						arg_527_1:RecordAudio("123121129", var_530_15)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_123121", "123121129", "story_v_out_123121.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_123121", "123121129", "story_v_out_123121.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_16 = math.max(var_530_9, arg_527_1.talkMaxDuration)

			if var_530_8 <= arg_527_1.time_ and arg_527_1.time_ < var_530_8 + var_530_16 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_8) / var_530_16

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_8 + var_530_16 and arg_527_1.time_ < var_530_8 + var_530_16 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play123121130 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 123121130
		arg_531_1.duration_ = 7.47

		local var_531_0 = {
			zh = 5.1,
			ja = 7.466
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play123121131(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1055ui_story = arg_531_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).z)
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles = arg_531_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_531_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).z)
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles = arg_531_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_534_1 = arg_531_1.actors_["1055ui_story"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1055ui_story == nil then
				arg_531_1.var_.characterEffect1055ui_story = var_534_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_2 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_2 and not isNil(var_534_1) then
				if arg_531_1.var_.characterEffect1055ui_story and not isNil(var_534_1) then
					arg_531_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_2 and arg_531_1.time_ < 0 + var_534_2 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1055ui_story then
				arg_531_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_534_4 = arg_531_1.actors_["1093ui_story"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_4) and arg_531_1.var_.characterEffect1093ui_story == nil then
				arg_531_1.var_.characterEffect1093ui_story = var_534_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_5 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_5 and not isNil(var_534_4) then
				if arg_531_1.var_.characterEffect1093ui_story and not isNil(var_534_4) then
					arg_531_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_5)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_5 and arg_531_1.time_ < 0 + var_534_5 + arg_534_0 and not isNil(var_534_4) and arg_531_1.var_.characterEffect1093ui_story then
				arg_531_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_534_6 = arg_531_1.actors_["1093ui_story"].transform

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1093ui_story = var_534_6.localPosition
			end

			local var_534_7 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				var_534_6.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_531_1.time_ - 0) / var_534_7)
				var_534_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_534_6.position).x, (manager.ui.mainCamera.transform.position - var_534_6.position).y, (manager.ui.mainCamera.transform.position - var_534_6.position).z)
				var_534_6.localEulerAngles.z = 0
				var_534_6.localEulerAngles.x = 0
				var_534_6.localEulerAngles = var_534_6.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				var_534_6.localPosition = Vector3.New(0, 100, 0)
				var_534_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_534_6.position).x, (manager.ui.mainCamera.transform.position - var_534_6.position).y, (manager.ui.mainCamera.transform.position - var_534_6.position).z)
				var_534_6.localEulerAngles.z = 0
				var_534_6.localEulerAngles.x = 0
				var_534_6.localEulerAngles = var_534_6.localEulerAngles
			end

			local var_534_8 = 0
			local var_534_9 = 0.65

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_8 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_10 = arg_531_1:GetWordFromCfg(123121130)
				local var_534_11 = arg_531_1:FormatText(var_534_10.content)

				arg_531_1.text_.text = var_534_11

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_13 = 26 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 26)

				if (26 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 26)) > 0 and var_534_9 < var_534_13 then
					arg_531_1.talkMaxDuration = var_534_13

					if var_534_13 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_8
					end
				end

				arg_531_1.text_.text = var_534_11
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121130", "story_v_out_123121.awb") ~= 0 then
					local var_534_14 = manager.audio:GetVoiceLength("story_v_out_123121", "123121130", "story_v_out_123121.awb") / 1000

					if var_534_14 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_14 + var_534_8
					end

					if var_534_10.prefab_name ~= "" and arg_531_1.actors_[var_534_10.prefab_name] ~= nil then
						local var_534_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_10.prefab_name].transform, "story_v_out_123121", "123121130", "story_v_out_123121.awb")

						arg_531_1:RecordAudio("123121130", var_534_15)
						arg_531_1:RecordAudio("123121130", var_534_15)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_123121", "123121130", "story_v_out_123121.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_123121", "123121130", "story_v_out_123121.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_16 = math.max(var_534_9, arg_531_1.talkMaxDuration)

			if var_534_8 <= arg_531_1.time_ and arg_531_1.time_ < var_534_8 + var_534_16 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_8) / var_534_16

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_8 + var_534_16 and arg_531_1.time_ < var_534_8 + var_534_16 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play123121131 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 123121131
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play123121132(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1055ui_story"]) and arg_535_1.var_.characterEffect1055ui_story == nil then
				arg_535_1.var_.characterEffect1055ui_story = arg_535_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1055ui_story"]) then
				if arg_535_1.var_.characterEffect1055ui_story and not isNil(arg_535_1.actors_["1055ui_story"]) then
					arg_535_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1055ui_story"]) and arg_535_1.var_.characterEffect1055ui_story then
				arg_535_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_538_1 = 0
			local var_538_2 = 1.425

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(123121131).content)

				arg_535_1.text_.text = var_538_3

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 57 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 57)

				if (57 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_3) / 57)) > 0 and var_538_2 < var_538_5 then
					arg_535_1.talkMaxDuration = var_538_5

					if var_538_5 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_3
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_6 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_6 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_6

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_6 and arg_535_1.time_ < var_538_1 + var_538_6 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play123121132 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 123121132
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play123121133(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0.2

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_1 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(123121132).content)

				arg_539_1.text_.text = var_542_1

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_3 = 8 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 8)

				if (8 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 8)) > 0 and var_542_0 < var_542_3 then
					arg_539_1.talkMaxDuration = var_542_3

					if var_542_3 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_3 + 0
					end
				end

				arg_539_1.text_.text = var_542_1
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_4 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_4

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play123121133 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 123121133
		arg_543_1.duration_ = 3.5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play123121134(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos1055ui_story = arg_543_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_546_0 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 then
				arg_543_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_543_1.time_ - 0) / var_546_0)
				arg_543_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1055ui_story"].transform.position).z)
				arg_543_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["1055ui_story"].transform.localEulerAngles = arg_543_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 then
				arg_543_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_543_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_543_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_543_1.actors_["1055ui_story"].transform.position).z)
				arg_543_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_543_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_543_1.actors_["1055ui_story"].transform.localEulerAngles = arg_543_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_546_1 = arg_543_1.actors_["1055ui_story"]

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(var_546_1) and arg_543_1.var_.characterEffect1055ui_story == nil then
				arg_543_1.var_.characterEffect1055ui_story = var_546_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_2 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_2 and not isNil(var_546_1) then
				if arg_543_1.var_.characterEffect1055ui_story and not isNil(var_546_1) then
					arg_543_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 0 + var_546_2 and arg_543_1.time_ < 0 + var_546_2 + arg_546_0 and not isNil(var_546_1) and arg_543_1.var_.characterEffect1055ui_story then
				arg_543_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_546_4 = 0
			local var_546_5 = 0.375

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_4 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_6 = arg_543_1:GetWordFromCfg(123121133)
				local var_546_7 = arg_543_1:FormatText(var_546_6.content)

				arg_543_1.text_.text = var_546_7

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_9 = 15 <= 0 and var_546_5 or var_546_5 * (utf8.len(var_546_7) / 15)

				if (15 <= 0 and var_546_5 or var_546_5 * (utf8.len(var_546_7) / 15)) > 0 and var_546_5 < var_546_9 then
					arg_543_1.talkMaxDuration = var_546_9

					if var_546_9 + var_546_4 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_9 + var_546_4
					end
				end

				arg_543_1.text_.text = var_546_7
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121133", "story_v_out_123121.awb") ~= 0 then
					local var_546_10 = manager.audio:GetVoiceLength("story_v_out_123121", "123121133", "story_v_out_123121.awb") / 1000

					if var_546_10 + var_546_4 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_10 + var_546_4
					end

					if var_546_6.prefab_name ~= "" and arg_543_1.actors_[var_546_6.prefab_name] ~= nil then
						local var_546_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_6.prefab_name].transform, "story_v_out_123121", "123121133", "story_v_out_123121.awb")

						arg_543_1:RecordAudio("123121133", var_546_11)
						arg_543_1:RecordAudio("123121133", var_546_11)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_123121", "123121133", "story_v_out_123121.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_123121", "123121133", "story_v_out_123121.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_12 = math.max(var_546_5, arg_543_1.talkMaxDuration)

			if var_546_4 <= arg_543_1.time_ and arg_543_1.time_ < var_546_4 + var_546_12 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_4) / var_546_12

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_4 + var_546_12 and arg_543_1.time_ < var_546_4 + var_546_12 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play123121134 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 123121134
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play123121135(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1055ui_story"]) and arg_547_1.var_.characterEffect1055ui_story == nil then
				arg_547_1.var_.characterEffect1055ui_story = arg_547_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1055ui_story"]) then
				if arg_547_1.var_.characterEffect1055ui_story and not isNil(arg_547_1.actors_["1055ui_story"]) then
					arg_547_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_547_1.time_ - 0) / var_550_0)
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1055ui_story"]) and arg_547_1.var_.characterEffect1055ui_story then
				arg_547_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_550_1 = 0
			local var_550_2 = 0.1

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_3 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(123121134).content)

				arg_547_1.text_.text = var_550_3

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_5 = 4 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 4)

				if (4 <= 0 and var_550_2 or var_550_2 * (utf8.len(var_550_3) / 4)) > 0 and var_550_2 < var_550_5 then
					arg_547_1.talkMaxDuration = var_550_5

					if var_550_5 + var_550_1 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + var_550_1
					end
				end

				arg_547_1.text_.text = var_550_3
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_6 = math.max(var_550_2, arg_547_1.talkMaxDuration)

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_6 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_1) / var_550_6

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_1 + var_550_6 and arg_547_1.time_ < var_550_1 + var_550_6 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play123121135 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 123121135
		arg_551_1.duration_ = 6.63

		local var_551_0 = {
			zh = 6.633,
			ja = 5.4
		}
		local var_551_1 = manager.audio:GetLocalizationFlag()

		if var_551_0[var_551_1] ~= nil then
			arg_551_1.duration_ = var_551_0[var_551_1]
		end

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play123121136(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["1055ui_story"]) and arg_551_1.var_.characterEffect1055ui_story == nil then
				arg_551_1.var_.characterEffect1055ui_story = arg_551_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["1055ui_story"]) then
				if arg_551_1.var_.characterEffect1055ui_story and not isNil(arg_551_1.actors_["1055ui_story"]) then
					arg_551_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["1055ui_story"]) and arg_551_1.var_.characterEffect1055ui_story then
				arg_551_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_554_2 = 0
			local var_554_3 = 0.75

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_2 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_4 = arg_551_1:GetWordFromCfg(123121135)
				local var_554_5 = arg_551_1:FormatText(var_554_4.content)

				arg_551_1.text_.text = var_554_5

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_7 = 30 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 30)

				if (30 <= 0 and var_554_3 or var_554_3 * (utf8.len(var_554_5) / 30)) > 0 and var_554_3 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_2
					end
				end

				arg_551_1.text_.text = var_554_5
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123121", "123121135", "story_v_out_123121.awb") ~= 0 then
					local var_554_8 = manager.audio:GetVoiceLength("story_v_out_123121", "123121135", "story_v_out_123121.awb") / 1000

					if var_554_8 + var_554_2 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_8 + var_554_2
					end

					if var_554_4.prefab_name ~= "" and arg_551_1.actors_[var_554_4.prefab_name] ~= nil then
						local var_554_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_4.prefab_name].transform, "story_v_out_123121", "123121135", "story_v_out_123121.awb")

						arg_551_1:RecordAudio("123121135", var_554_9)
						arg_551_1:RecordAudio("123121135", var_554_9)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_123121", "123121135", "story_v_out_123121.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_123121", "123121135", "story_v_out_123121.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_10 = math.max(var_554_3, arg_551_1.talkMaxDuration)

			if var_554_2 <= arg_551_1.time_ and arg_551_1.time_ < var_554_2 + var_554_10 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_2) / var_554_10

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_2 + var_554_10 and arg_551_1.time_ < var_554_2 + var_554_10 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play123121136 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 123121136
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play123121137(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1055ui_story = arg_555_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_558_0 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 then
				arg_555_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_555_1.time_ - 0) / var_558_0)
				arg_555_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1055ui_story"].transform.position).z)
				arg_555_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1055ui_story"].transform.localEulerAngles = arg_555_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 then
				arg_555_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_555_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_555_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_555_1.actors_["1055ui_story"].transform.position).z)
				arg_555_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_555_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_555_1.actors_["1055ui_story"].transform.localEulerAngles = arg_555_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_558_1 = arg_555_1.actors_["1055ui_story"]

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect1055ui_story == nil then
				arg_555_1.var_.characterEffect1055ui_story = var_558_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_2 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_2 and not isNil(var_558_1) then
				if arg_555_1.var_.characterEffect1055ui_story and not isNil(var_558_1) then
					arg_555_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_555_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_555_1.time_ - 0) / var_558_2)
				end
			end

			if arg_555_1.time_ >= 0 + var_558_2 and arg_555_1.time_ < 0 + var_558_2 + arg_558_0 and not isNil(var_558_1) and arg_555_1.var_.characterEffect1055ui_story then
				arg_555_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_555_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_558_3 = 0
			local var_558_4 = 0.875

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_3 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_5 = arg_555_1:FormatText(arg_555_1:GetWordFromCfg(123121136).content)

				arg_555_1.text_.text = var_558_5

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_7 = 35 <= 0 and var_558_4 or var_558_4 * (utf8.len(var_558_5) / 35)

				if (35 <= 0 and var_558_4 or var_558_4 * (utf8.len(var_558_5) / 35)) > 0 and var_558_4 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_3 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_3
					end
				end

				arg_555_1.text_.text = var_558_5
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_8 = math.max(var_558_4, arg_555_1.talkMaxDuration)

			if var_558_3 <= arg_555_1.time_ and arg_555_1.time_ < var_558_3 + var_558_8 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_3) / var_558_8

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_3 + var_558_8 and arg_555_1.time_ < var_558_3 + var_558_8 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_555_1:InitPlayNodeList()
	end,
	Play123121137 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 123121137
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
			arg_559_1.auto_ = false
		end

		function arg_559_1.playNext_(arg_561_0)
			arg_559_1.onStoryFinished_()
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 0.175

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(123121137).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 7 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 7)

				if (7 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 7)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K05g",
		"TextureConfig/Background/K06g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/BA0106"
	},
	voices = {
		"story_v_out_123121.awb"
	}
}
