return {
	Play123101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123101001
		arg_1_1.duration_ = 9.5

		local var_1_0 = {
			zh = 6.165999999999,
			ja = 9.499999999999
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
				arg_1_0:Play123101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K05f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_4_0.name = "K05f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K05f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K05f

				arg_1_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K05f" then
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

			local var_4_8 = "1093ui_story"

			if arg_1_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1093ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1093ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.11, -5.88)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1093ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1093ui_story == nil then
				arg_1_1.var_.characterEffect1093ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1093ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1093ui_story then
				arg_1_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_4_story_xiajingqu", "bgm_activity_2_4_story_xiajingqu")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 1.999999999999
			local var_4_24 = 0.575

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(123101001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 23 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 23)

				if (23 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 23)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101001", "story_v_out_123101.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_123101", "123101001", "story_v_out_123101.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_123101", "123101001", "story_v_out_123101.awb")

						arg_1_1:RecordAudio("123101001", var_4_31)
						arg_1_1:RecordAudio("123101001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_123101", "123101001", "story_v_out_123101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_123101", "123101001", "story_v_out_123101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play123101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1093ui_story"]) and arg_9_1.var_.characterEffect1093ui_story == nil then
				arg_9_1.var_.characterEffect1093ui_story = arg_9_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1093ui_story"]) then
				if arg_9_1.var_.characterEffect1093ui_story and not isNil(arg_9_1.actors_["1093ui_story"]) then
					arg_9_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1093ui_story"]) and arg_9_1.var_.characterEffect1093ui_story then
				arg_9_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(123101002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 9 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 9)

				if (9 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 9)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play123101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123101003
		arg_13_1.duration_ = 10.4

		local var_13_0 = {
			zh = 8.233,
			ja = 10.4
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
				arg_13_0:Play123101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1093ui_story"]) and arg_13_1.var_.characterEffect1093ui_story == nil then
				arg_13_1.var_.characterEffect1093ui_story = arg_13_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1093ui_story"]) then
				if arg_13_1.var_.characterEffect1093ui_story and not isNil(arg_13_1.actors_["1093ui_story"]) then
					arg_13_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1093ui_story"]) and arg_13_1.var_.characterEffect1093ui_story then
				arg_13_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action426")
			end

			local var_16_2 = 0
			local var_16_3 = 0.825

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(123101003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 33 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 33)

				if (33 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 33)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101003", "story_v_out_123101.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101003", "story_v_out_123101.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_123101", "123101003", "story_v_out_123101.awb")

						arg_13_1:RecordAudio("123101003", var_16_9)
						arg_13_1:RecordAudio("123101003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_123101", "123101003", "story_v_out_123101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_123101", "123101003", "story_v_out_123101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123101004
		arg_17_1.duration_ = 3.6

		local var_17_0 = {
			zh = 3.066,
			ja = 3.6
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
				arg_17_0:Play123101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1093ui_story"]) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = arg_17_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1093ui_story"]) then
				if arg_17_1.var_.characterEffect1093ui_story and not isNil(arg_17_1.actors_["1093ui_story"]) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1093ui_story"]) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.3

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(123101004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 12 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 12)

				if (12 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 12)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101004", "story_v_out_123101.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101004", "story_v_out_123101.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_123101", "123101004", "story_v_out_123101.awb")

						arg_17_1:RecordAudio("123101004", var_20_8)
						arg_17_1:RecordAudio("123101004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123101", "123101004", "story_v_out_123101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123101", "123101004", "story_v_out_123101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play123101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123101005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play123101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1093ui_story"]) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = arg_21_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1093ui_story"]) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(arg_21_1.actors_["1093ui_story"]) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1093ui_story"]) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.05

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(123101005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 2 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 2)

				if (2 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 2)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101005", "story_v_out_123101.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101005", "story_v_out_123101.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_123101", "123101005", "story_v_out_123101.awb")

						arg_21_1:RecordAudio("123101005", var_24_9)
						arg_21_1:RecordAudio("123101005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123101", "123101005", "story_v_out_123101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123101", "123101005", "story_v_out_123101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play123101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = arg_25_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).z)
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles = arg_25_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1093ui_story"].transform.position).z)
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1093ui_story"].transform.localEulerAngles = arg_25_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1093ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(123101006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 80 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 80)

				if (80 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 80)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play123101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(123101007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 47 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 47)

				if (47 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 47)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play123101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123101008
		arg_33_1.duration_ = 2.17

		local var_33_0 = {
			zh = 2.133,
			ja = 2.166
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
				arg_33_0:Play123101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(123101008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 8 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 8)

				if (8 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 8)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101008", "story_v_out_123101.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101008", "story_v_out_123101.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_123101", "123101008", "story_v_out_123101.awb")

						arg_33_1:RecordAudio("123101008", var_36_6)
						arg_33_1:RecordAudio("123101008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_123101", "123101008", "story_v_out_123101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_123101", "123101008", "story_v_out_123101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123101009
		arg_37_1.duration_ = 3.93

		local var_37_0 = {
			zh = 3.933,
			ja = 3.766
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
				arg_37_0:Play123101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(123101009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 21 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 21)

				if (21 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 21)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101009", "story_v_out_123101.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101009", "story_v_out_123101.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_123101", "123101009", "story_v_out_123101.awb")

						arg_37_1:RecordAudio("123101009", var_40_6)
						arg_37_1:RecordAudio("123101009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123101", "123101009", "story_v_out_123101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123101", "123101009", "story_v_out_123101.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play123101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123101010
		arg_41_1.duration_ = 4.23

		local var_41_0 = {
			zh = 4.233,
			ja = 4.166
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
				arg_41_0:Play123101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.5

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(123101010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 20 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 20)

				if (20 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 20)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101010", "story_v_out_123101.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101010", "story_v_out_123101.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_123101", "123101010", "story_v_out_123101.awb")

						arg_41_1:RecordAudio("123101010", var_44_6)
						arg_41_1:RecordAudio("123101010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123101", "123101010", "story_v_out_123101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123101", "123101010", "story_v_out_123101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play123101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123101011
		arg_45_1.duration_ = 4.6

		local var_45_0 = {
			zh = 3.5,
			ja = 4.6
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.3

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(123101011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 12 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 12)

				if (12 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 12)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101011", "story_v_out_123101.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101011", "story_v_out_123101.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_123101", "123101011", "story_v_out_123101.awb")

						arg_45_1:RecordAudio("123101011", var_48_6)
						arg_45_1:RecordAudio("123101011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123101", "123101011", "story_v_out_123101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123101", "123101011", "story_v_out_123101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123101012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.125

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(123101012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 45 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 45)

				if (45 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 45)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play123101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123101013
		arg_53_1.duration_ = 3.43

		local var_53_0 = {
			zh = 1.7,
			ja = 3.433
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
				arg_53_0:Play123101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(123101013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 9 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 9)

				if (9 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 9)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101013", "story_v_out_123101.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101013", "story_v_out_123101.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_123101", "123101013", "story_v_out_123101.awb")

						arg_53_1:RecordAudio("123101013", var_56_6)
						arg_53_1:RecordAudio("123101013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123101", "123101013", "story_v_out_123101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123101", "123101013", "story_v_out_123101.awb")
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
	Play123101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123101014
		arg_57_1.duration_ = 10.03

		local var_57_0 = {
			zh = 10.033,
			ja = 6.2
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
				arg_57_0:Play123101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.775

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(123101014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 31 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 31)

				if (31 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 31)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101014", "story_v_out_123101.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101014", "story_v_out_123101.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_123101", "123101014", "story_v_out_123101.awb")

						arg_57_1:RecordAudio("123101014", var_60_6)
						arg_57_1:RecordAudio("123101014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_123101", "123101014", "story_v_out_123101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_123101", "123101014", "story_v_out_123101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play123101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123101015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.95

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(123101015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 38 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 38)

				if (38 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 38)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123101016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play123101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.075

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(123101016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 3 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 3)

				if (3 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 3)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play123101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123101017
		arg_69_1.duration_ = 6.97

		local var_69_0 = {
			zh = 6.966,
			ja = 2.5
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
				arg_69_0:Play123101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1055ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1055ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1055ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1055ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1055ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1055ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1055ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1055ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1055ui_story == nil then
				arg_69_1.var_.characterEffect1055ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1055ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1055ui_story then
				arg_69_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_72_8 = 0
			local var_72_9 = 0.825

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(123101017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 33 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 33)

				if (33 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 33)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101017", "story_v_out_123101.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101017", "story_v_out_123101.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_123101", "123101017", "story_v_out_123101.awb")

						arg_69_1:RecordAudio("123101017", var_72_15)
						arg_69_1:RecordAudio("123101017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123101", "123101017", "story_v_out_123101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123101", "123101017", "story_v_out_123101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play123101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123101018
		arg_73_1.duration_ = 3.73

		local var_73_0 = {
			zh = 2,
			ja = 3.733
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
				arg_73_0:Play123101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1055ui_story"]) and arg_73_1.var_.characterEffect1055ui_story == nil then
				arg_73_1.var_.characterEffect1055ui_story = arg_73_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1055ui_story"]) then
				if arg_73_1.var_.characterEffect1055ui_story and not isNil(arg_73_1.actors_["1055ui_story"]) then
					arg_73_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1055ui_story"]) and arg_73_1.var_.characterEffect1055ui_story then
				arg_73_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.15

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(123101018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 6 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 6)

				if (6 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 6)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101018", "story_v_out_123101.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101018", "story_v_out_123101.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_123101", "123101018", "story_v_out_123101.awb")

						arg_73_1:RecordAudio("123101018", var_76_8)
						arg_73_1:RecordAudio("123101018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123101", "123101018", "story_v_out_123101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123101", "123101018", "story_v_out_123101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123101019
		arg_77_1.duration_ = 7.73

		local var_77_0 = {
			zh = 4.833,
			ja = 7.733
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
				arg_77_0:Play123101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1055ui_story"]) and arg_77_1.var_.characterEffect1055ui_story == nil then
				arg_77_1.var_.characterEffect1055ui_story = arg_77_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1055ui_story"]) then
				if arg_77_1.var_.characterEffect1055ui_story and not isNil(arg_77_1.actors_["1055ui_story"]) then
					arg_77_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1055ui_story"]) and arg_77_1.var_.characterEffect1055ui_story then
				arg_77_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_80_2 = 0
			local var_80_3 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(123101019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 21 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 21)

				if (21 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 21)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101019", "story_v_out_123101.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101019", "story_v_out_123101.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_123101", "123101019", "story_v_out_123101.awb")

						arg_77_1:RecordAudio("123101019", var_80_9)
						arg_77_1:RecordAudio("123101019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_123101", "123101019", "story_v_out_123101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_123101", "123101019", "story_v_out_123101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play123101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123101020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1055ui_story"]) and arg_81_1.var_.characterEffect1055ui_story == nil then
				arg_81_1.var_.characterEffect1055ui_story = arg_81_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1055ui_story"]) then
				if arg_81_1.var_.characterEffect1055ui_story and not isNil(arg_81_1.actors_["1055ui_story"]) then
					arg_81_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1055ui_story"]) and arg_81_1.var_.characterEffect1055ui_story then
				arg_81_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.2

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(123101020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 8 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 8)

				if (8 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 8)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123101021
		arg_85_1.duration_ = 3.6

		local var_85_0 = {
			zh = 2.1,
			ja = 3.6
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
				arg_85_0:Play123101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(123101021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 9 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 9)

				if (9 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 9)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101021", "story_v_out_123101.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101021", "story_v_out_123101.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_123101", "123101021", "story_v_out_123101.awb")

						arg_85_1:RecordAudio("123101021", var_88_6)
						arg_85_1:RecordAudio("123101021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123101", "123101021", "story_v_out_123101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123101", "123101021", "story_v_out_123101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play123101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123101022
		arg_89_1.duration_ = 5.97

		local var_89_0 = {
			zh = 3.933,
			ja = 5.966
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
				arg_89_0:Play123101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1055ui_story = arg_89_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1055ui_story"].transform.position).z)
				arg_89_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1055ui_story"].transform.localEulerAngles = arg_89_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_89_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1055ui_story"].transform.position).z)
				arg_89_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1055ui_story"].transform.localEulerAngles = arg_89_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1055ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1055ui_story == nil then
				arg_89_1.var_.characterEffect1055ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1055ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1055ui_story then
				arg_89_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(123101022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 18 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 18)

				if (18 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 18)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101022", "story_v_out_123101.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101022", "story_v_out_123101.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_123101", "123101022", "story_v_out_123101.awb")

						arg_89_1:RecordAudio("123101022", var_92_11)
						arg_89_1:RecordAudio("123101022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_123101", "123101022", "story_v_out_123101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_123101", "123101022", "story_v_out_123101.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play123101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123101023
		arg_93_1.duration_ = 10.43

		local var_93_0 = {
			zh = 7.9,
			ja = 10.433
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
				arg_93_0:Play123101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_96_0 = 0
			local var_96_1 = 0.925

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(123101023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 37 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 37)

				if (37 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 37)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101023", "story_v_out_123101.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_out_123101", "123101023", "story_v_out_123101.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_out_123101", "123101023", "story_v_out_123101.awb")

						arg_93_1:RecordAudio("123101023", var_96_7)
						arg_93_1:RecordAudio("123101023", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123101", "123101023", "story_v_out_123101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123101", "123101023", "story_v_out_123101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123101024
		arg_97_1.duration_ = 5.93

		local var_97_0 = {
			zh = 4.833,
			ja = 5.933
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
				arg_97_0:Play123101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1055ui_story"]) and arg_97_1.var_.characterEffect1055ui_story == nil then
				arg_97_1.var_.characterEffect1055ui_story = arg_97_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1055ui_story"]) then
				if arg_97_1.var_.characterEffect1055ui_story and not isNil(arg_97_1.actors_["1055ui_story"]) then
					arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1055ui_story"]) and arg_97_1.var_.characterEffect1055ui_story then
				arg_97_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(123101024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 25 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 25)

				if (25 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 25)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101024", "story_v_out_123101.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101024", "story_v_out_123101.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_123101", "123101024", "story_v_out_123101.awb")

						arg_97_1:RecordAudio("123101024", var_100_8)
						arg_97_1:RecordAudio("123101024", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123101", "123101024", "story_v_out_123101.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123101", "123101024", "story_v_out_123101.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play123101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123101025
		arg_101_1.duration_ = 7.23

		local var_101_0 = {
			zh = 4.4,
			ja = 7.233
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
				arg_101_0:Play123101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1055ui_story"]) and arg_101_1.var_.characterEffect1055ui_story == nil then
				arg_101_1.var_.characterEffect1055ui_story = arg_101_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1055ui_story"]) then
				if arg_101_1.var_.characterEffect1055ui_story and not isNil(arg_101_1.actors_["1055ui_story"]) then
					arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1055ui_story"]) and arg_101_1.var_.characterEffect1055ui_story then
				arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_104_2 = 0
			local var_104_3 = 0.25

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(123101025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 10 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 10)

				if (10 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 10)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101025", "story_v_out_123101.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101025", "story_v_out_123101.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_123101", "123101025", "story_v_out_123101.awb")

						arg_101_1:RecordAudio("123101025", var_104_9)
						arg_101_1:RecordAudio("123101025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123101", "123101025", "story_v_out_123101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123101", "123101025", "story_v_out_123101.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play123101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123101026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play123101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1055ui_story"]) and arg_105_1.var_.characterEffect1055ui_story == nil then
				arg_105_1.var_.characterEffect1055ui_story = arg_105_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1055ui_story"]) then
				if arg_105_1.var_.characterEffect1055ui_story and not isNil(arg_105_1.actors_["1055ui_story"]) then
					arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1055ui_story"]) and arg_105_1.var_.characterEffect1055ui_story then
				arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(123101026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 50 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 50)

				if (50 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 50)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123101027
		arg_109_1.duration_ = 5.13

		local var_109_0 = {
			zh = 5.133,
			ja = 3.1
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
				arg_109_0:Play123101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1055ui_story"]) and arg_109_1.var_.characterEffect1055ui_story == nil then
				arg_109_1.var_.characterEffect1055ui_story = arg_109_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1055ui_story"]) then
				if arg_109_1.var_.characterEffect1055ui_story and not isNil(arg_109_1.actors_["1055ui_story"]) then
					arg_109_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1055ui_story"]) and arg_109_1.var_.characterEffect1055ui_story then
				arg_109_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.625

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(123101027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 25 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 25)

				if (25 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 25)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101027", "story_v_out_123101.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101027", "story_v_out_123101.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_123101", "123101027", "story_v_out_123101.awb")

						arg_109_1:RecordAudio("123101027", var_112_9)
						arg_109_1:RecordAudio("123101027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123101", "123101027", "story_v_out_123101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123101", "123101027", "story_v_out_123101.awb")
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
	Play123101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123101028
		arg_113_1.duration_ = 5.93

		local var_113_0 = {
			zh = 4.533,
			ja = 5.933
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1055ui_story"]) and arg_113_1.var_.characterEffect1055ui_story == nil then
				arg_113_1.var_.characterEffect1055ui_story = arg_113_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1055ui_story"]) then
				if arg_113_1.var_.characterEffect1055ui_story and not isNil(arg_113_1.actors_["1055ui_story"]) then
					arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1055ui_story"]) and arg_113_1.var_.characterEffect1055ui_story then
				arg_113_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.4

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(123101028)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 16 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 16)

				if (16 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_4) / 16)) > 0 and var_116_2 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101028", "story_v_out_123101.awb") ~= 0 then
					local var_116_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101028", "story_v_out_123101.awb") / 1000

					if var_116_7 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_1
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_123101", "123101028", "story_v_out_123101.awb")

						arg_113_1:RecordAudio("123101028", var_116_8)
						arg_113_1:RecordAudio("123101028", var_116_8)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_123101", "123101028", "story_v_out_123101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_123101", "123101028", "story_v_out_123101.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123101029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123101029
		arg_117_1.duration_ = 9.4

		local var_117_0 = {
			zh = 7.066,
			ja = 9.4
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
				arg_117_0:Play123101030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.775

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[498].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(123101029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 31 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 31)

				if (31 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 31)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101029", "story_v_out_123101.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101029", "story_v_out_123101.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_123101", "123101029", "story_v_out_123101.awb")

						arg_117_1:RecordAudio("123101029", var_120_6)
						arg_117_1:RecordAudio("123101029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123101", "123101029", "story_v_out_123101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123101", "123101029", "story_v_out_123101.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play123101030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123101030
		arg_121_1.duration_ = 8.37

		local var_121_0 = {
			zh = 8.366,
			ja = 6.333
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
				arg_121_0:Play123101031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.9

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(123101030)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 36 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 36)

				if (36 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 36)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101030", "story_v_out_123101.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101030", "story_v_out_123101.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_123101", "123101030", "story_v_out_123101.awb")

						arg_121_1:RecordAudio("123101030", var_124_6)
						arg_121_1:RecordAudio("123101030", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_123101", "123101030", "story_v_out_123101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_123101", "123101030", "story_v_out_123101.awb")
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
	Play123101031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 123101031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play123101032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.475

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(123101031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 19 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 19)

				if (19 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 19)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play123101032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 123101032
		arg_129_1.duration_ = 2.03

		local var_129_0 = {
			zh = 1.166,
			ja = 2.033
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play123101033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.125

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:GetWordFromCfg(123101032)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 5 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 5)

				if (5 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 5)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101032", "story_v_out_123101.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101032", "story_v_out_123101.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_123101", "123101032", "story_v_out_123101.awb")

						arg_129_1:RecordAudio("123101032", var_132_6)
						arg_129_1:RecordAudio("123101032", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_123101", "123101032", "story_v_out_123101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_123101", "123101032", "story_v_out_123101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play123101033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 123101033
		arg_133_1.duration_ = 2.53

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_133_0:Play123101034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1055ui_story = arg_133_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1055ui_story"].transform.position).z)
				arg_133_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1055ui_story"].transform.localEulerAngles = arg_133_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_133_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1055ui_story"].transform.position).z)
				arg_133_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1055ui_story"].transform.localEulerAngles = arg_133_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1055ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1055ui_story == nil then
				arg_133_1.var_.characterEffect1055ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1055ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1055ui_story then
				arg_133_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(123101033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 3 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 3)

				if (3 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 3)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101033", "story_v_out_123101.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101033", "story_v_out_123101.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_123101", "123101033", "story_v_out_123101.awb")

						arg_133_1:RecordAudio("123101033", var_136_11)
						arg_133_1:RecordAudio("123101033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_123101", "123101033", "story_v_out_123101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_123101", "123101033", "story_v_out_123101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play123101034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 123101034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play123101035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1055ui_story"]) and arg_137_1.var_.characterEffect1055ui_story == nil then
				arg_137_1.var_.characterEffect1055ui_story = arg_137_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1055ui_story"]) then
				if arg_137_1.var_.characterEffect1055ui_story and not isNil(arg_137_1.actors_["1055ui_story"]) then
					arg_137_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1055ui_story"]) and arg_137_1.var_.characterEffect1055ui_story then
				arg_137_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.75

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(123101034).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 30 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 30)

				if (30 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 30)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play123101035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 123101035
		arg_141_1.duration_ = 8.7

		local var_141_0 = {
			zh = 8.7,
			ja = 4.733
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
				arg_141_0:Play123101036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1093ui_story = arg_141_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_141_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1093ui_story"].transform.position).z)
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1093ui_story"].transform.localEulerAngles = arg_141_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1093ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_144_4 = arg_141_1.actors_["1055ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1055ui_story = var_144_4.localPosition
			end

			local var_144_5 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 then
				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_141_1.time_ - 0) / var_144_5)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(0.7, -0.965, -6.2)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			local var_144_6 = arg_141_1.actors_["1055ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1055ui_story == nil then
				arg_141_1.var_.characterEffect1055ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_7 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 and not isNil(var_144_6) then
				if arg_141_1.var_.characterEffect1055ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_7)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect1055ui_story then
				arg_141_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_144_8 = 0
			local var_144_9 = 1

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(123101035)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 40 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 40)

				if (40 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 40)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101035", "story_v_out_123101.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101035", "story_v_out_123101.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_123101", "123101035", "story_v_out_123101.awb")

						arg_141_1:RecordAudio("123101035", var_144_15)
						arg_141_1:RecordAudio("123101035", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_123101", "123101035", "story_v_out_123101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_123101", "123101035", "story_v_out_123101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play123101036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 123101036
		arg_145_1.duration_ = 4.9

		local var_145_0 = {
			zh = 3.5,
			ja = 4.9
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
				arg_145_0:Play123101037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_148_0 = 0
			local var_148_1 = 0.35

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(123101036)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 14 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 14)

				if (14 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 14)) > 0 and var_148_1 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101036", "story_v_out_123101.awb") ~= 0 then
					local var_148_6 = manager.audio:GetVoiceLength("story_v_out_123101", "123101036", "story_v_out_123101.awb") / 1000

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end

					if var_148_2.prefab_name ~= "" and arg_145_1.actors_[var_148_2.prefab_name] ~= nil then
						local var_148_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_2.prefab_name].transform, "story_v_out_123101", "123101036", "story_v_out_123101.awb")

						arg_145_1:RecordAudio("123101036", var_148_7)
						arg_145_1:RecordAudio("123101036", var_148_7)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_123101", "123101036", "story_v_out_123101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_123101", "123101036", "story_v_out_123101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play123101037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 123101037
		arg_149_1.duration_ = 6.6

		local var_149_0 = {
			zh = 2.3,
			ja = 6.6
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
				arg_149_0:Play123101038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1055ui_story"]) and arg_149_1.var_.characterEffect1055ui_story == nil then
				arg_149_1.var_.characterEffect1055ui_story = arg_149_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1055ui_story"]) then
				if arg_149_1.var_.characterEffect1055ui_story and not isNil(arg_149_1.actors_["1055ui_story"]) then
					arg_149_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1055ui_story"]) and arg_149_1.var_.characterEffect1055ui_story then
				arg_149_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_152_2 = arg_149_1.actors_["1093ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1093ui_story == nil then
				arg_149_1.var_.characterEffect1093ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1093ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1093ui_story then
				arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(123101037)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 11 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 11)

				if (11 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 11)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101037", "story_v_out_123101.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101037", "story_v_out_123101.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_123101", "123101037", "story_v_out_123101.awb")

						arg_149_1:RecordAudio("123101037", var_152_11)
						arg_149_1:RecordAudio("123101037", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_123101", "123101037", "story_v_out_123101.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_123101", "123101037", "story_v_out_123101.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play123101038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 123101038
		arg_153_1.duration_ = 2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play123101039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1093ui_story = arg_153_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).z)
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles = arg_153_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_153_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1093ui_story"].transform.position).z)
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1093ui_story"].transform.localEulerAngles = arg_153_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1093ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1093ui_story == nil then
				arg_153_1.var_.characterEffect1093ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1093ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1093ui_story then
				arg_153_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action7_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_156_4 = arg_153_1.actors_["1055ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1055ui_story == nil then
				arg_153_1.var_.characterEffect1055ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect1055ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect1055ui_story then
				arg_153_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_156_6 = 0
			local var_156_7 = 0.05

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:GetWordFromCfg(123101038)
				local var_156_9 = arg_153_1:FormatText(var_156_8.content)

				arg_153_1.text_.text = var_156_9

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_11 = 2 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 2)

				if (2 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_9) / 2)) > 0 and var_156_7 < var_156_11 then
					arg_153_1.talkMaxDuration = var_156_11

					if var_156_11 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_9
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101038", "story_v_out_123101.awb") ~= 0 then
					local var_156_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101038", "story_v_out_123101.awb") / 1000

					if var_156_12 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_6
					end

					if var_156_8.prefab_name ~= "" and arg_153_1.actors_[var_156_8.prefab_name] ~= nil then
						local var_156_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_8.prefab_name].transform, "story_v_out_123101", "123101038", "story_v_out_123101.awb")

						arg_153_1:RecordAudio("123101038", var_156_13)
						arg_153_1:RecordAudio("123101038", var_156_13)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_123101", "123101038", "story_v_out_123101.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_123101", "123101038", "story_v_out_123101.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_14 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_14 and arg_153_1.time_ < var_156_6 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play123101039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 123101039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play123101040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1093ui_story"]) and arg_157_1.var_.characterEffect1093ui_story == nil then
				arg_157_1.var_.characterEffect1093ui_story = arg_157_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1093ui_story"]) then
				if arg_157_1.var_.characterEffect1093ui_story and not isNil(arg_157_1.actors_["1093ui_story"]) then
					arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1093ui_story"]) and arg_157_1.var_.characterEffect1093ui_story then
				arg_157_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 1.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(123101039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 60 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 60)

				if (60 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 60)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play123101040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 123101040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play123101041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(123101040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 12 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 12)

				if (12 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 12)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play123101041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 123101041
		arg_165_1.duration_ = 12.63

		local var_165_0 = {
			zh = 8.366,
			ja = 12.633
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
				arg_165_0:Play123101042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1055ui_story = arg_165_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1055ui_story"].transform.position).z)
				arg_165_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1055ui_story"].transform.localEulerAngles = arg_165_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_165_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1055ui_story"].transform.position).z)
				arg_165_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1055ui_story"].transform.localEulerAngles = arg_165_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1055ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1055ui_story == nil then
				arg_165_1.var_.characterEffect1055ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1055ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1055ui_story then
				arg_165_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_4 = 0
			local var_168_5 = 1.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(123101041)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 45 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 45)

				if (45 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 45)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101041", "story_v_out_123101.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101041", "story_v_out_123101.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_123101", "123101041", "story_v_out_123101.awb")

						arg_165_1:RecordAudio("123101041", var_168_11)
						arg_165_1:RecordAudio("123101041", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_123101", "123101041", "story_v_out_123101.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_123101", "123101041", "story_v_out_123101.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play123101042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 123101042
		arg_169_1.duration_ = 13.73

		local var_169_0 = {
			zh = 8.566,
			ja = 13.733
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
				arg_169_0:Play123101043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_0 = 0
			local var_172_1 = 1.075

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(123101042)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 43 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 43)

				if (43 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 43)) > 0 and var_172_1 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101042", "story_v_out_123101.awb") ~= 0 then
					local var_172_6 = manager.audio:GetVoiceLength("story_v_out_123101", "123101042", "story_v_out_123101.awb") / 1000

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end

					if var_172_2.prefab_name ~= "" and arg_169_1.actors_[var_172_2.prefab_name] ~= nil then
						local var_172_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_2.prefab_name].transform, "story_v_out_123101", "123101042", "story_v_out_123101.awb")

						arg_169_1:RecordAudio("123101042", var_172_7)
						arg_169_1:RecordAudio("123101042", var_172_7)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_123101", "123101042", "story_v_out_123101.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_123101", "123101042", "story_v_out_123101.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play123101043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 123101043
		arg_173_1.duration_ = 7.2

		local var_173_0 = {
			zh = 6.266,
			ja = 7.2
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
				arg_173_0:Play123101044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_0 = 0
			local var_176_1 = 0.725

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(123101043)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 29 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 29)

				if (29 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 29)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101043", "story_v_out_123101.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_out_123101", "123101043", "story_v_out_123101.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_out_123101", "123101043", "story_v_out_123101.awb")

						arg_173_1:RecordAudio("123101043", var_176_7)
						arg_173_1:RecordAudio("123101043", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_123101", "123101043", "story_v_out_123101.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_123101", "123101043", "story_v_out_123101.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play123101044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 123101044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play123101045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1055ui_story"]) and arg_177_1.var_.characterEffect1055ui_story == nil then
				arg_177_1.var_.characterEffect1055ui_story = arg_177_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1055ui_story"]) then
				if arg_177_1.var_.characterEffect1055ui_story and not isNil(arg_177_1.actors_["1055ui_story"]) then
					arg_177_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1055ui_story"]) and arg_177_1.var_.characterEffect1055ui_story then
				arg_177_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.675

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(123101044).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 27 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 27)

				if (27 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 27)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play123101045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 123101045
		arg_181_1.duration_ = 6.77

		local var_181_0 = {
			zh = 5.066,
			ja = 6.766
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
				arg_181_0:Play123101046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1093ui_story"]) and arg_181_1.var_.characterEffect1093ui_story == nil then
				arg_181_1.var_.characterEffect1093ui_story = arg_181_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1093ui_story"]) then
				if arg_181_1.var_.characterEffect1093ui_story and not isNil(arg_181_1.actors_["1093ui_story"]) then
					arg_181_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1093ui_story"]) and arg_181_1.var_.characterEffect1093ui_story then
				arg_181_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_184_2 = 0
			local var_184_3 = 0.375

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(123101045)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 15 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 15)

				if (15 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 15)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101045", "story_v_out_123101.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101045", "story_v_out_123101.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_123101", "123101045", "story_v_out_123101.awb")

						arg_181_1:RecordAudio("123101045", var_184_9)
						arg_181_1:RecordAudio("123101045", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_123101", "123101045", "story_v_out_123101.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_123101", "123101045", "story_v_out_123101.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play123101046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 123101046
		arg_185_1.duration_ = 12.4

		local var_185_0 = {
			zh = 6.2,
			ja = 12.4
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play123101047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1055ui_story"]) and arg_185_1.var_.characterEffect1055ui_story == nil then
				arg_185_1.var_.characterEffect1055ui_story = arg_185_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1055ui_story"]) then
				if arg_185_1.var_.characterEffect1055ui_story and not isNil(arg_185_1.actors_["1055ui_story"]) then
					arg_185_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1055ui_story"]) and arg_185_1.var_.characterEffect1055ui_story then
				arg_185_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_188_2 = arg_185_1.actors_["1093ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1093ui_story == nil then
				arg_185_1.var_.characterEffect1093ui_story = var_188_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_3 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.characterEffect1093ui_story and not isNil(var_188_2) then
					arg_185_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_3)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.characterEffect1093ui_story then
				arg_185_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_188_4 = 0
			local var_188_5 = 0.875

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(123101046)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 34 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 34)

				if (34 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 34)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101046", "story_v_out_123101.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101046", "story_v_out_123101.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_123101", "123101046", "story_v_out_123101.awb")

						arg_185_1:RecordAudio("123101046", var_188_11)
						arg_185_1:RecordAudio("123101046", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_123101", "123101046", "story_v_out_123101.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_123101", "123101046", "story_v_out_123101.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play123101047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 123101047
		arg_189_1.duration_ = 3.1

		local var_189_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_189_0:Play123101048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1093ui_story"]) and arg_189_1.var_.characterEffect1093ui_story == nil then
				arg_189_1.var_.characterEffect1093ui_story = arg_189_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1093ui_story"]) then
				if arg_189_1.var_.characterEffect1093ui_story and not isNil(arg_189_1.actors_["1093ui_story"]) then
					arg_189_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1093ui_story"]) and arg_189_1.var_.characterEffect1093ui_story then
				arg_189_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_192_2 = arg_189_1.actors_["1055ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1055ui_story == nil then
				arg_189_1.var_.characterEffect1055ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1055ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1055ui_story then
				arg_189_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_192_4 = 0
			local var_192_5 = 0.15

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(123101047)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 6 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 6)

				if (6 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 6)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101047", "story_v_out_123101.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101047", "story_v_out_123101.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_123101", "123101047", "story_v_out_123101.awb")

						arg_189_1:RecordAudio("123101047", var_192_11)
						arg_189_1:RecordAudio("123101047", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_123101", "123101047", "story_v_out_123101.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_123101", "123101047", "story_v_out_123101.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play123101048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 123101048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play123101049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1093ui_story"]) and arg_193_1.var_.characterEffect1093ui_story == nil then
				arg_193_1.var_.characterEffect1093ui_story = arg_193_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1093ui_story"]) then
				if arg_193_1.var_.characterEffect1093ui_story and not isNil(arg_193_1.actors_["1093ui_story"]) then
					arg_193_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1093ui_story"]) and arg_193_1.var_.characterEffect1093ui_story then
				arg_193_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(123101048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 9 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 9)

				if (9 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 9)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play123101049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 123101049
		arg_197_1.duration_ = 16.03

		local var_197_0 = {
			zh = 11.266,
			ja = 16.033
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
				arg_197_0:Play123101050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1055ui_story"]) and arg_197_1.var_.characterEffect1055ui_story == nil then
				arg_197_1.var_.characterEffect1055ui_story = arg_197_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1055ui_story"]) then
				if arg_197_1.var_.characterEffect1055ui_story and not isNil(arg_197_1.actors_["1055ui_story"]) then
					arg_197_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1055ui_story"]) and arg_197_1.var_.characterEffect1055ui_story then
				arg_197_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_200_2 = 0
			local var_200_3 = 1.325

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_4 = arg_197_1:GetWordFromCfg(123101049)
				local var_200_5 = arg_197_1:FormatText(var_200_4.content)

				arg_197_1.text_.text = var_200_5

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 53 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 53)

				if (53 <= 0 and var_200_3 or var_200_3 * (utf8.len(var_200_5) / 53)) > 0 and var_200_3 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_5
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101049", "story_v_out_123101.awb") ~= 0 then
					local var_200_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101049", "story_v_out_123101.awb") / 1000

					if var_200_8 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_2
					end

					if var_200_4.prefab_name ~= "" and arg_197_1.actors_[var_200_4.prefab_name] ~= nil then
						local var_200_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_4.prefab_name].transform, "story_v_out_123101", "123101049", "story_v_out_123101.awb")

						arg_197_1:RecordAudio("123101049", var_200_9)
						arg_197_1:RecordAudio("123101049", var_200_9)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_123101", "123101049", "story_v_out_123101.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_123101", "123101049", "story_v_out_123101.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play123101050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 123101050
		arg_201_1.duration_ = 4.47

		local var_201_0 = {
			zh = 3.833,
			ja = 4.466
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
				arg_201_0:Play123101051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1055ui_story"]) and arg_201_1.var_.characterEffect1055ui_story == nil then
				arg_201_1.var_.characterEffect1055ui_story = arg_201_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1055ui_story"]) then
				if arg_201_1.var_.characterEffect1055ui_story and not isNil(arg_201_1.actors_["1055ui_story"]) then
					arg_201_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1055ui_story"]) and arg_201_1.var_.characterEffect1055ui_story then
				arg_201_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_204_2 = 0
			local var_204_3 = 0.525

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(123101050)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 21 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 21)

				if (21 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 21)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101050", "story_v_out_123101.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101050", "story_v_out_123101.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_out_123101", "123101050", "story_v_out_123101.awb")

						arg_201_1:RecordAudio("123101050", var_204_9)
						arg_201_1:RecordAudio("123101050", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_123101", "123101050", "story_v_out_123101.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_123101", "123101050", "story_v_out_123101.awb")
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

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play123101051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 123101051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play123101052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1055ui_story"]) and arg_205_1.var_.characterEffect1055ui_story == nil then
				arg_205_1.var_.characterEffect1055ui_story = arg_205_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1055ui_story"]) then
				if arg_205_1.var_.characterEffect1055ui_story and not isNil(arg_205_1.actors_["1055ui_story"]) then
					arg_205_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1055ui_story"]) and arg_205_1.var_.characterEffect1055ui_story then
				arg_205_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.375

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(123101051).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 15 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 15)

				if (15 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 15)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play123101052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 123101052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play123101053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1093ui_story = arg_209_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).z)
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles = arg_209_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1093ui_story"].transform.position).z)
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1093ui_story"].transform.localEulerAngles = arg_209_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1093ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1093ui_story == nil then
				arg_209_1.var_.characterEffect1093ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1093ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_2)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1093ui_story then
				arg_209_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_212_3 = arg_209_1.actors_["1055ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1055ui_story = var_212_3.localPosition
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_3.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_4)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_3.localPosition = Vector3.New(0, 100, 0)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			local var_212_5 = arg_209_1.actors_["1055ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1055ui_story == nil then
				arg_209_1.var_.characterEffect1055ui_story = var_212_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.characterEffect1055ui_story and not isNil(var_212_5) then
					arg_209_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_6)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1055ui_story then
				arg_209_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_212_7 = 0
			local var_212_8 = 1.5

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_9 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(123101052).content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 60 <= 0 and var_212_8 or var_212_8 * (utf8.len(var_212_9) / 60)

				if (60 <= 0 and var_212_8 or var_212_8 * (utf8.len(var_212_9) / 60)) > 0 and var_212_8 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_7
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_8, arg_209_1.talkMaxDuration)

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_7) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_7 + var_212_12 and arg_209_1.time_ < var_212_7 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play123101053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 123101053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play123101054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.9

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(123101053).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 36 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 36)

				if (36 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 36)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play123101054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 123101054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play123101055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.15

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(123101054).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 6 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 6)

				if (6 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 6)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play123101055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 123101055
		arg_221_1.duration_ = 2

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play123101056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1055ui_story = arg_221_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).z)
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles = arg_221_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_221_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1055ui_story"].transform.position).z)
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1055ui_story"].transform.localEulerAngles = arg_221_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1055ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1055ui_story == nil then
				arg_221_1.var_.characterEffect1055ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1055ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1055ui_story then
				arg_221_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_224_4 = 0
			local var_224_5 = 0.05

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(123101055)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 2 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 2)

				if (2 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 2)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101055", "story_v_out_123101.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101055", "story_v_out_123101.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_123101", "123101055", "story_v_out_123101.awb")

						arg_221_1:RecordAudio("123101055", var_224_11)
						arg_221_1:RecordAudio("123101055", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_123101", "123101055", "story_v_out_123101.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_123101", "123101055", "story_v_out_123101.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play123101056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 123101056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play123101057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1055ui_story"]) and arg_225_1.var_.characterEffect1055ui_story == nil then
				arg_225_1.var_.characterEffect1055ui_story = arg_225_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1055ui_story"]) then
				if arg_225_1.var_.characterEffect1055ui_story and not isNil(arg_225_1.actors_["1055ui_story"]) then
					arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1055ui_story"]) and arg_225_1.var_.characterEffect1055ui_story then
				arg_225_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.925

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(123101056).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 37 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 37)

				if (37 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 37)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play123101057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 123101057
		arg_229_1.duration_ = 4.17

		local var_229_0 = {
			zh = 3.266,
			ja = 4.166
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play123101058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_232_0 = arg_229_1.actors_["1055ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1055ui_story == nil then
				arg_229_1.var_.characterEffect1055ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_1 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 and not isNil(var_232_0) then
				if arg_229_1.var_.characterEffect1055ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1055ui_story then
				arg_229_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_232_3 = 0
			local var_232_4 = 0.3

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_5 = arg_229_1:GetWordFromCfg(123101057)
				local var_232_6 = arg_229_1:FormatText(var_232_5.content)

				arg_229_1.text_.text = var_232_6

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_8 = 12 <= 0 and var_232_4 or var_232_4 * (utf8.len(var_232_6) / 12)

				if (12 <= 0 and var_232_4 or var_232_4 * (utf8.len(var_232_6) / 12)) > 0 and var_232_4 < var_232_8 then
					arg_229_1.talkMaxDuration = var_232_8

					if var_232_8 + var_232_3 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_3
					end
				end

				arg_229_1.text_.text = var_232_6
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101057", "story_v_out_123101.awb") ~= 0 then
					local var_232_9 = manager.audio:GetVoiceLength("story_v_out_123101", "123101057", "story_v_out_123101.awb") / 1000

					if var_232_9 + var_232_3 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_3
					end

					if var_232_5.prefab_name ~= "" and arg_229_1.actors_[var_232_5.prefab_name] ~= nil then
						local var_232_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_5.prefab_name].transform, "story_v_out_123101", "123101057", "story_v_out_123101.awb")

						arg_229_1:RecordAudio("123101057", var_232_10)
						arg_229_1:RecordAudio("123101057", var_232_10)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_123101", "123101057", "story_v_out_123101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_123101", "123101057", "story_v_out_123101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_11 = math.max(var_232_4, arg_229_1.talkMaxDuration)

			if var_232_3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_3 + var_232_11 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_3) / var_232_11

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_3 + var_232_11 and arg_229_1.time_ < var_232_3 + var_232_11 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play123101058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 123101058
		arg_233_1.duration_ = 8.73

		local var_233_0 = {
			zh = 8.733,
			ja = 4.8
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
				arg_233_0:Play123101059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1055ui_story = arg_233_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1055ui_story"].transform.position).z)
				arg_233_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1055ui_story"].transform.localEulerAngles = arg_233_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1055ui_story"].transform.position).z)
				arg_233_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1055ui_story"].transform.localEulerAngles = arg_233_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1055ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1055ui_story == nil then
				arg_233_1.var_.characterEffect1055ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1055ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_2)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1055ui_story then
				arg_233_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_236_3 = arg_233_1.actors_["1093ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1093ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			local var_236_5 = arg_233_1.actors_["1093ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1093ui_story == nil then
				arg_233_1.var_.characterEffect1093ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect1093ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1093ui_story then
				arg_233_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_236_8 = 0
			local var_236_9 = 0.7

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(123101058)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 28 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 28)

				if (28 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 28)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101058", "story_v_out_123101.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101058", "story_v_out_123101.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_123101", "123101058", "story_v_out_123101.awb")

						arg_233_1:RecordAudio("123101058", var_236_15)
						arg_233_1:RecordAudio("123101058", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_123101", "123101058", "story_v_out_123101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_123101", "123101058", "story_v_out_123101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play123101059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 123101059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play123101060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1093ui_story"]) and arg_237_1.var_.characterEffect1093ui_story == nil then
				arg_237_1.var_.characterEffect1093ui_story = arg_237_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1093ui_story"]) then
				if arg_237_1.var_.characterEffect1093ui_story and not isNil(arg_237_1.actors_["1093ui_story"]) then
					arg_237_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1093ui_story"]) and arg_237_1.var_.characterEffect1093ui_story then
				arg_237_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_240_1 = 0
			local var_240_2 = 0.375

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(123101059).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 15 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 15)

				if (15 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 15)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play123101060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 123101060
		arg_241_1.duration_ = 8.73

		local var_241_0 = {
			zh = 6.733,
			ja = 8.733
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
				arg_241_0:Play123101061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1055ui_story = arg_241_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).z)
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles = arg_241_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_241_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).z)
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles = arg_241_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1055ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1055ui_story == nil then
				arg_241_1.var_.characterEffect1055ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1055ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1055ui_story then
				arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_4 = arg_241_1.actors_["1093ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1093ui_story = var_244_4.localPosition
			end

			local var_244_5 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_5 then
				var_244_4.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_241_1.time_ - 0) / var_244_5)
				var_244_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_4.position).x, (manager.ui.mainCamera.transform.position - var_244_4.position).y, (manager.ui.mainCamera.transform.position - var_244_4.position).z)
				var_244_4.localEulerAngles.z = 0
				var_244_4.localEulerAngles.x = 0
				var_244_4.localEulerAngles = var_244_4.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_5 and arg_241_1.time_ < 0 + var_244_5 + arg_244_0 then
				var_244_4.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_244_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_4.position).x, (manager.ui.mainCamera.transform.position - var_244_4.position).y, (manager.ui.mainCamera.transform.position - var_244_4.position).z)
				var_244_4.localEulerAngles.z = 0
				var_244_4.localEulerAngles.x = 0
				var_244_4.localEulerAngles = var_244_4.localEulerAngles
			end

			local var_244_6 = 0
			local var_244_7 = 0.775

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_8 = arg_241_1:GetWordFromCfg(123101060)
				local var_244_9 = arg_241_1:FormatText(var_244_8.content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 31 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_9) / 31)

				if (31 <= 0 and var_244_7 or var_244_7 * (utf8.len(var_244_9) / 31)) > 0 and var_244_7 < var_244_11 then
					arg_241_1.talkMaxDuration = var_244_11

					if var_244_11 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_9
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101060", "story_v_out_123101.awb") ~= 0 then
					local var_244_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101060", "story_v_out_123101.awb") / 1000

					if var_244_12 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_6
					end

					if var_244_8.prefab_name ~= "" and arg_241_1.actors_[var_244_8.prefab_name] ~= nil then
						local var_244_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_8.prefab_name].transform, "story_v_out_123101", "123101060", "story_v_out_123101.awb")

						arg_241_1:RecordAudio("123101060", var_244_13)
						arg_241_1:RecordAudio("123101060", var_244_13)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_123101", "123101060", "story_v_out_123101.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_123101", "123101060", "story_v_out_123101.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play123101061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 123101061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play123101062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) and arg_245_1.var_.characterEffect1055ui_story == nil then
				arg_245_1.var_.characterEffect1055ui_story = arg_245_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) then
				if arg_245_1.var_.characterEffect1055ui_story and not isNil(arg_245_1.actors_["1055ui_story"]) then
					arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) and arg_245_1.var_.characterEffect1055ui_story then
				arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.925

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(123101061).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 37 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 37)

				if (37 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 37)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play123101062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 123101062
		arg_249_1.duration_ = 10.97

		local var_249_0 = {
			zh = 9,
			ja = 10.966
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
				arg_249_0:Play123101063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1055ui_story"]) and arg_249_1.var_.characterEffect1055ui_story == nil then
				arg_249_1.var_.characterEffect1055ui_story = arg_249_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1055ui_story"]) then
				if arg_249_1.var_.characterEffect1055ui_story and not isNil(arg_249_1.actors_["1055ui_story"]) then
					arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1055ui_story"]) and arg_249_1.var_.characterEffect1055ui_story then
				arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_252_2 = 0
			local var_252_3 = 0.925

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(123101062)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 37 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 37)

				if (37 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 37)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101062", "story_v_out_123101.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101062", "story_v_out_123101.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_out_123101", "123101062", "story_v_out_123101.awb")

						arg_249_1:RecordAudio("123101062", var_252_9)
						arg_249_1:RecordAudio("123101062", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_123101", "123101062", "story_v_out_123101.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_123101", "123101062", "story_v_out_123101.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play123101063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 123101063
		arg_253_1.duration_ = 3.73

		local var_253_0 = {
			zh = 2.633,
			ja = 3.733
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
				arg_253_0:Play123101064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1093ui_story"]) and arg_253_1.var_.characterEffect1093ui_story == nil then
				arg_253_1.var_.characterEffect1093ui_story = arg_253_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1093ui_story"]) then
				if arg_253_1.var_.characterEffect1093ui_story and not isNil(arg_253_1.actors_["1093ui_story"]) then
					arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1093ui_story"]) and arg_253_1.var_.characterEffect1093ui_story then
				arg_253_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_2 = arg_253_1.actors_["1055ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1055ui_story == nil then
				arg_253_1.var_.characterEffect1055ui_story = var_256_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_3 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.characterEffect1055ui_story and not isNil(var_256_2) then
					arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_3)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.characterEffect1055ui_story then
				arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_256_4 = 0
			local var_256_5 = 0.35

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(123101063)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 14 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 14)

				if (14 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 14)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101063", "story_v_out_123101.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101063", "story_v_out_123101.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_123101", "123101063", "story_v_out_123101.awb")

						arg_253_1:RecordAudio("123101063", var_256_11)
						arg_253_1:RecordAudio("123101063", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_123101", "123101063", "story_v_out_123101.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_123101", "123101063", "story_v_out_123101.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play123101064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 123101064
		arg_257_1.duration_ = 5.87

		local var_257_0 = {
			zh = 3.933,
			ja = 5.866
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play123101065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1055ui_story"]) and arg_257_1.var_.characterEffect1055ui_story == nil then
				arg_257_1.var_.characterEffect1055ui_story = arg_257_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1055ui_story"]) then
				if arg_257_1.var_.characterEffect1055ui_story and not isNil(arg_257_1.actors_["1055ui_story"]) then
					arg_257_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1055ui_story"]) and arg_257_1.var_.characterEffect1055ui_story then
				arg_257_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_260_2 = arg_257_1.actors_["1093ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1093ui_story == nil then
				arg_257_1.var_.characterEffect1093ui_story = var_260_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_3 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.characterEffect1093ui_story and not isNil(var_260_2) then
					arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_3)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1093ui_story then
				arg_257_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_260_4 = 0
			local var_260_5 = 0.425

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(123101064)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 17 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 17)

				if (17 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 17)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101064", "story_v_out_123101.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101064", "story_v_out_123101.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_123101", "123101064", "story_v_out_123101.awb")

						arg_257_1:RecordAudio("123101064", var_260_11)
						arg_257_1:RecordAudio("123101064", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_123101", "123101064", "story_v_out_123101.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_123101", "123101064", "story_v_out_123101.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play123101065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 123101065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play123101066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1055ui_story"]) and arg_261_1.var_.characterEffect1055ui_story == nil then
				arg_261_1.var_.characterEffect1055ui_story = arg_261_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1055ui_story"]) then
				if arg_261_1.var_.characterEffect1055ui_story and not isNil(arg_261_1.actors_["1055ui_story"]) then
					arg_261_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1055ui_story"]) and arg_261_1.var_.characterEffect1055ui_story then
				arg_261_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.5

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(123101065).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 20 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 20)

				if (20 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 20)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play123101066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 123101066
		arg_265_1.duration_ = 6.4

		local var_265_0 = {
			zh = 5.133,
			ja = 6.4
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play123101067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1055ui_story"]) and arg_265_1.var_.characterEffect1055ui_story == nil then
				arg_265_1.var_.characterEffect1055ui_story = arg_265_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1055ui_story"]) then
				if arg_265_1.var_.characterEffect1055ui_story and not isNil(arg_265_1.actors_["1055ui_story"]) then
					arg_265_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1055ui_story"]) and arg_265_1.var_.characterEffect1055ui_story then
				arg_265_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_2 = 0
			local var_268_3 = 0.6

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(123101066)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 24 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 24)

				if (24 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 24)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101066", "story_v_out_123101.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101066", "story_v_out_123101.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_123101", "123101066", "story_v_out_123101.awb")

						arg_265_1:RecordAudio("123101066", var_268_9)
						arg_265_1:RecordAudio("123101066", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_123101", "123101066", "story_v_out_123101.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_123101", "123101066", "story_v_out_123101.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play123101067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 123101067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play123101068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1055ui_story"]) and arg_269_1.var_.characterEffect1055ui_story == nil then
				arg_269_1.var_.characterEffect1055ui_story = arg_269_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1055ui_story"]) then
				if arg_269_1.var_.characterEffect1055ui_story and not isNil(arg_269_1.actors_["1055ui_story"]) then
					arg_269_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1055ui_story"]) and arg_269_1.var_.characterEffect1055ui_story then
				arg_269_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.675

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(123101067).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 27 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 27)

				if (27 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 27)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play123101068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 123101068
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play123101069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1055ui_story = arg_273_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1055ui_story"].transform.position).z)
				arg_273_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1055ui_story"].transform.localEulerAngles = arg_273_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1055ui_story"].transform.position).z)
				arg_273_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1055ui_story"].transform.localEulerAngles = arg_273_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1055ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1055ui_story == nil then
				arg_273_1.var_.characterEffect1055ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1055ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_2)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1055ui_story then
				arg_273_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_276_3 = arg_273_1.actors_["1093ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1093ui_story = var_276_3.localPosition
			end

			local var_276_4 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				var_276_3.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_4)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				var_276_3.localPosition = Vector3.New(0, 100, 0)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			local var_276_5 = 0
			local var_276_6 = 1.35

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(123101068).content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 54 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_7) / 54)

				if (54 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_7) / 54)) > 0 and var_276_6 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_10 and arg_273_1.time_ < var_276_5 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play123101069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 123101069
		arg_277_1.duration_ = 0.6

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"

			SetActive(arg_277_1.choicesGo_, true)

			for iter_278_0, iter_278_1 in ipairs(arg_277_1.choices_) do
				SetActive(iter_278_1.go, iter_278_0 <= 1)
			end

			arg_277_1.choices_[1].txt.text = arg_277_1:FormatText(StoryChoiceCfg[504].name)
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play123101070(arg_277_1)
			end

			arg_277_1:RecordChoiceLog(123101069, 504)
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.allBtn_.enabled = false
			end

			if arg_277_1.time_ >= 0 + 0.6 and arg_277_1.time_ < 0 + 0.6 + arg_280_0 then
				arg_277_1.allBtn_.enabled = true
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play123101070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 123101070
		arg_281_1.duration_ = 2

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play123101071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1055ui_story = arg_281_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1055ui_story"].transform.position).z)
				arg_281_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1055ui_story"].transform.localEulerAngles = arg_281_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_281_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1055ui_story"].transform.position).z)
				arg_281_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1055ui_story"].transform.localEulerAngles = arg_281_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1055ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1055ui_story == nil then
				arg_281_1.var_.characterEffect1055ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1055ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1055ui_story then
				arg_281_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_284_4 = 0
			local var_284_5 = 0.05

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(123101070)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 2 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 2)

				if (2 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 2)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101070", "story_v_out_123101.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101070", "story_v_out_123101.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_out_123101", "123101070", "story_v_out_123101.awb")

						arg_281_1:RecordAudio("123101070", var_284_11)
						arg_281_1:RecordAudio("123101070", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_123101", "123101070", "story_v_out_123101.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_123101", "123101070", "story_v_out_123101.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play123101071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 123101071
		arg_285_1.duration_ = 2.57

		local var_285_0 = {
			zh = 2.566,
			ja = 2.533
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
				arg_285_0:Play123101072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1093ui_story = arg_285_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1093ui_story"].transform.position).z)
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1093ui_story"].transform.localEulerAngles = arg_285_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
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
				arg_285_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_288_4 = arg_285_1.actors_["1055ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1055ui_story == nil then
				arg_285_1.var_.characterEffect1055ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_5 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_5 and not isNil(var_288_4) then
				if arg_285_1.var_.characterEffect1055ui_story and not isNil(var_288_4) then
					arg_285_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_5)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_5 and arg_285_1.time_ < 0 + var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1055ui_story then
				arg_285_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_288_6 = 0
			local var_288_7 = 0.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
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

				local var_288_8 = arg_285_1:GetWordFromCfg(123101071)
				local var_288_9 = arg_285_1:FormatText(var_288_8.content)

				arg_285_1.text_.text = var_288_9

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 12 <= 0 and var_288_7 or var_288_7 * (utf8.len(var_288_9) / 12)

				if (12 <= 0 and var_288_7 or var_288_7 * (utf8.len(var_288_9) / 12)) > 0 and var_288_7 < var_288_11 then
					arg_285_1.talkMaxDuration = var_288_11

					if var_288_11 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_9
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101071", "story_v_out_123101.awb") ~= 0 then
					local var_288_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101071", "story_v_out_123101.awb") / 1000

					if var_288_12 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_6
					end

					if var_288_8.prefab_name ~= "" and arg_285_1.actors_[var_288_8.prefab_name] ~= nil then
						local var_288_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_8.prefab_name].transform, "story_v_out_123101", "123101071", "story_v_out_123101.awb")

						arg_285_1:RecordAudio("123101071", var_288_13)
						arg_285_1:RecordAudio("123101071", var_288_13)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_123101", "123101071", "story_v_out_123101.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_123101", "123101071", "story_v_out_123101.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
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
	Play123101072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 123101072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play123101073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1093ui_story"]) and arg_289_1.var_.characterEffect1093ui_story == nil then
				arg_289_1.var_.characterEffect1093ui_story = arg_289_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1093ui_story"]) then
				if arg_289_1.var_.characterEffect1093ui_story and not isNil(arg_289_1.actors_["1093ui_story"]) then
					arg_289_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1093ui_story"]) and arg_289_1.var_.characterEffect1093ui_story then
				arg_289_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0
			local var_292_2 = 0.45

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(123101072).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 18 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 18)

				if (18 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 18)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play123101073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 123101073
		arg_293_1.duration_ = 4.3

		local var_293_0 = {
			zh = 4.3,
			ja = 2.566
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play123101074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1093ui_story"]) and arg_293_1.var_.characterEffect1093ui_story == nil then
				arg_293_1.var_.characterEffect1093ui_story = arg_293_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1093ui_story"]) then
				if arg_293_1.var_.characterEffect1093ui_story and not isNil(arg_293_1.actors_["1093ui_story"]) then
					arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1093ui_story"]) and arg_293_1.var_.characterEffect1093ui_story then
				arg_293_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_296_2 = 0
			local var_296_3 = 0.425

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:GetWordFromCfg(123101073)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 17 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 17)

				if (17 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 17)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101073", "story_v_out_123101.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101073", "story_v_out_123101.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_123101", "123101073", "story_v_out_123101.awb")

						arg_293_1:RecordAudio("123101073", var_296_9)
						arg_293_1:RecordAudio("123101073", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_123101", "123101073", "story_v_out_123101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_123101", "123101073", "story_v_out_123101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play123101074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 123101074
		arg_297_1.duration_ = 7.23

		local var_297_0 = {
			zh = 4.966,
			ja = 7.233
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
				arg_297_0:Play123101075(arg_297_1)
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
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_300_4 = arg_297_1.actors_["1093ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect1093ui_story == nil then
				arg_297_1.var_.characterEffect1093ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_5 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_5 and not isNil(var_300_4) then
				if arg_297_1.var_.characterEffect1093ui_story and not isNil(var_300_4) then
					arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_5)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_5 and arg_297_1.time_ < 0 + var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect1093ui_story then
				arg_297_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_300_6 = 0
			local var_300_7 = 0.525

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

				local var_300_8 = arg_297_1:GetWordFromCfg(123101074)
				local var_300_9 = arg_297_1:FormatText(var_300_8.content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 21 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 21)

				if (21 <= 0 and var_300_7 or var_300_7 * (utf8.len(var_300_9) / 21)) > 0 and var_300_7 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101074", "story_v_out_123101.awb") ~= 0 then
					local var_300_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101074", "story_v_out_123101.awb") / 1000

					if var_300_12 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_12 + var_300_6
					end

					if var_300_8.prefab_name ~= "" and arg_297_1.actors_[var_300_8.prefab_name] ~= nil then
						local var_300_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_8.prefab_name].transform, "story_v_out_123101", "123101074", "story_v_out_123101.awb")

						arg_297_1:RecordAudio("123101074", var_300_13)
						arg_297_1:RecordAudio("123101074", var_300_13)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_123101", "123101074", "story_v_out_123101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_123101", "123101074", "story_v_out_123101.awb")
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
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play123101075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 123101075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play123101076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1055ui_story = arg_301_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1055ui_story"].transform.position).z)
				arg_301_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1055ui_story"].transform.localEulerAngles = arg_301_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1055ui_story"].transform.position).z)
				arg_301_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1055ui_story"].transform.localEulerAngles = arg_301_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1055ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1055ui_story == nil then
				arg_301_1.var_.characterEffect1055ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1055ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_2)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1055ui_story then
				arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_304_3 = arg_301_1.actors_["1093ui_story"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1093ui_story = var_304_3.localPosition
			end

			local var_304_4 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				var_304_3.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 0) / var_304_4)
				var_304_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_3.position).x, (manager.ui.mainCamera.transform.position - var_304_3.position).y, (manager.ui.mainCamera.transform.position - var_304_3.position).z)
				var_304_3.localEulerAngles.z = 0
				var_304_3.localEulerAngles.x = 0
				var_304_3.localEulerAngles = var_304_3.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				var_304_3.localPosition = Vector3.New(0, 100, 0)
				var_304_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_3.position).x, (manager.ui.mainCamera.transform.position - var_304_3.position).y, (manager.ui.mainCamera.transform.position - var_304_3.position).z)
				var_304_3.localEulerAngles.z = 0
				var_304_3.localEulerAngles.x = 0
				var_304_3.localEulerAngles = var_304_3.localEulerAngles
			end

			local var_304_5 = arg_301_1.actors_["1093ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.characterEffect1093ui_story == nil then
				arg_301_1.var_.characterEffect1093ui_story = var_304_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_6 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_6 and not isNil(var_304_5) then
				if arg_301_1.var_.characterEffect1093ui_story and not isNil(var_304_5) then
					arg_301_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_6)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_6 and arg_301_1.time_ < 0 + var_304_6 + arg_304_0 and not isNil(var_304_5) and arg_301_1.var_.characterEffect1093ui_story then
				arg_301_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_304_7 = 0
			local var_304_8 = 0.7

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_7 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_9 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(123101075).content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 28 <= 0 and var_304_8 or var_304_8 * (utf8.len(var_304_9) / 28)

				if (28 <= 0 and var_304_8 or var_304_8 * (utf8.len(var_304_9) / 28)) > 0 and var_304_8 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_7 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_7
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_8, arg_301_1.talkMaxDuration)

			if var_304_7 <= arg_301_1.time_ and arg_301_1.time_ < var_304_7 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_7) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_7 + var_304_12 and arg_301_1.time_ < var_304_7 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play123101076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 123101076
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play123101077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.525

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(123101076).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 21 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 21)

				if (21 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 21)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play123101077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 123101077
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play123101078(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.925

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(123101077).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 37 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 37)

				if (37 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 37)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play123101078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 123101078
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play123101079(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.975

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(123101078).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 39 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 39)

				if (39 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 39)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play123101079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 123101079
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play123101080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.5

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(123101079).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 20 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 20)

				if (20 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 20)) > 0 and var_320_0 < var_320_3 then
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
	Play123101080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 123101080
		arg_321_1.duration_ = 7.13

		local var_321_0 = {
			zh = 7.133,
			ja = 6
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play123101081(arg_321_1)
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
					arg_321_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1055ui_story then
				arg_321_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_324_4 = 0
			local var_324_5 = 0.475

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(123101080)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 20 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 20)

				if (20 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 20)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101080", "story_v_out_123101.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101080", "story_v_out_123101.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_123101", "123101080", "story_v_out_123101.awb")

						arg_321_1:RecordAudio("123101080", var_324_11)
						arg_321_1:RecordAudio("123101080", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_123101", "123101080", "story_v_out_123101.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_123101", "123101080", "story_v_out_123101.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
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
	Play123101081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 123101081
		arg_325_1.duration_ = 6.63

		local var_325_0 = {
			zh = 3.366,
			ja = 6.633
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
				arg_325_0:Play123101082(arg_325_1)
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
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_328_2 = 0
			local var_328_3 = 0.375

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

				local var_328_4 = arg_325_1:GetWordFromCfg(123101081)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 15 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 15)

				if (15 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 15)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101081", "story_v_out_123101.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101081", "story_v_out_123101.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_out_123101", "123101081", "story_v_out_123101.awb")

						arg_325_1:RecordAudio("123101081", var_328_9)
						arg_325_1:RecordAudio("123101081", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_123101", "123101081", "story_v_out_123101.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_123101", "123101081", "story_v_out_123101.awb")
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
	Play123101082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 123101082
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play123101083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1055ui_story"]) and arg_329_1.var_.characterEffect1055ui_story == nil then
				arg_329_1.var_.characterEffect1055ui_story = arg_329_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1055ui_story"]) then
				if arg_329_1.var_.characterEffect1055ui_story and not isNil(arg_329_1.actors_["1055ui_story"]) then
					arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1055ui_story"]) and arg_329_1.var_.characterEffect1055ui_story then
				arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.825

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(123101082).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 33 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 33)

				if (33 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 33)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play123101083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 123101083
		arg_333_1.duration_ = 2.6

		local var_333_0 = {
			zh = 2.6,
			ja = 2.033
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play123101084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1055ui_story"]) and arg_333_1.var_.characterEffect1055ui_story == nil then
				arg_333_1.var_.characterEffect1055ui_story = arg_333_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1055ui_story"]) then
				if arg_333_1.var_.characterEffect1055ui_story and not isNil(arg_333_1.actors_["1055ui_story"]) then
					arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1055ui_story"]) and arg_333_1.var_.characterEffect1055ui_story then
				arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_336_2 = 0
			local var_336_3 = 0.125

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:GetWordFromCfg(123101083)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 5 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 5)

				if (5 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 5)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101083", "story_v_out_123101.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101083", "story_v_out_123101.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_out_123101", "123101083", "story_v_out_123101.awb")

						arg_333_1:RecordAudio("123101083", var_336_9)
						arg_333_1:RecordAudio("123101083", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_123101", "123101083", "story_v_out_123101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_123101", "123101083", "story_v_out_123101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play123101084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 123101084
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play123101085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1055ui_story"]) and arg_337_1.var_.characterEffect1055ui_story == nil then
				arg_337_1.var_.characterEffect1055ui_story = arg_337_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1055ui_story"]) then
				if arg_337_1.var_.characterEffect1055ui_story and not isNil(arg_337_1.actors_["1055ui_story"]) then
					arg_337_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1055ui_story"]) and arg_337_1.var_.characterEffect1055ui_story then
				arg_337_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.6

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(123101084).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 24 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 24)

				if (24 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 24)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play123101085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 123101085
		arg_341_1.duration_ = 5.53

		local var_341_0 = {
			zh = 5.533,
			ja = 5.4
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play123101086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1055ui_story"]) and arg_341_1.var_.characterEffect1055ui_story == nil then
				arg_341_1.var_.characterEffect1055ui_story = arg_341_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1055ui_story"]) then
				if arg_341_1.var_.characterEffect1055ui_story and not isNil(arg_341_1.actors_["1055ui_story"]) then
					arg_341_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1055ui_story"]) and arg_341_1.var_.characterEffect1055ui_story then
				arg_341_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_2")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_2 = 0
			local var_344_3 = 0.75

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(123101085)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 30 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 30)

				if (30 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 30)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101085", "story_v_out_123101.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101085", "story_v_out_123101.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_out_123101", "123101085", "story_v_out_123101.awb")

						arg_341_1:RecordAudio("123101085", var_344_9)
						arg_341_1:RecordAudio("123101085", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_123101", "123101085", "story_v_out_123101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_123101", "123101085", "story_v_out_123101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play123101086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 123101086
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play123101087(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1055ui_story"]) and arg_345_1.var_.characterEffect1055ui_story == nil then
				arg_345_1.var_.characterEffect1055ui_story = arg_345_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1055ui_story"]) then
				if arg_345_1.var_.characterEffect1055ui_story and not isNil(arg_345_1.actors_["1055ui_story"]) then
					arg_345_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1055ui_story"]) and arg_345_1.var_.characterEffect1055ui_story then
				arg_345_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.7

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(123101086).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 28 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 28)

				if (28 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 28)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play123101087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 123101087
		arg_349_1.duration_ = 7

		local var_349_0 = {
			zh = 6.033,
			ja = 7
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play123101088(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1055ui_story"]) and arg_349_1.var_.characterEffect1055ui_story == nil then
				arg_349_1.var_.characterEffect1055ui_story = arg_349_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1055ui_story"]) then
				if arg_349_1.var_.characterEffect1055ui_story and not isNil(arg_349_1.actors_["1055ui_story"]) then
					arg_349_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1055ui_story"]) and arg_349_1.var_.characterEffect1055ui_story then
				arg_349_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_352_2 = 0
			local var_352_3 = 0.625

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:GetWordFromCfg(123101087)
				local var_352_5 = arg_349_1:FormatText(var_352_4.content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 25 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 25)

				if (25 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_5) / 25)) > 0 and var_352_3 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_5
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101087", "story_v_out_123101.awb") ~= 0 then
					local var_352_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101087", "story_v_out_123101.awb") / 1000

					if var_352_8 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_8 + var_352_2
					end

					if var_352_4.prefab_name ~= "" and arg_349_1.actors_[var_352_4.prefab_name] ~= nil then
						local var_352_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_4.prefab_name].transform, "story_v_out_123101", "123101087", "story_v_out_123101.awb")

						arg_349_1:RecordAudio("123101087", var_352_9)
						arg_349_1:RecordAudio("123101087", var_352_9)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_123101", "123101087", "story_v_out_123101.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_123101", "123101087", "story_v_out_123101.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_10 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_10 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_10

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_10 and arg_349_1.time_ < var_352_2 + var_352_10 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play123101088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 123101088
		arg_353_1.duration_ = 3.7

		local var_353_0 = {
			zh = 3.166,
			ja = 3.7
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play123101089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1093ui_story = arg_353_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1093ui_story"].transform.position).z)
				arg_353_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1093ui_story"].transform.localEulerAngles = arg_353_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_353_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1093ui_story"].transform.position).z)
				arg_353_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1093ui_story"].transform.localEulerAngles = arg_353_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1093ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1093ui_story == nil then
				arg_353_1.var_.characterEffect1093ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1093ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1093ui_story then
				arg_353_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_356_4 = arg_353_1.actors_["1055ui_story"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1055ui_story = var_356_4.localPosition
			end

			local var_356_5 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_5 then
				var_356_4.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_353_1.time_ - 0) / var_356_5)
				var_356_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_4.position).x, (manager.ui.mainCamera.transform.position - var_356_4.position).y, (manager.ui.mainCamera.transform.position - var_356_4.position).z)
				var_356_4.localEulerAngles.z = 0
				var_356_4.localEulerAngles.x = 0
				var_356_4.localEulerAngles = var_356_4.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_5 and arg_353_1.time_ < 0 + var_356_5 + arg_356_0 then
				var_356_4.localPosition = Vector3.New(0.7, -0.965, -6.2)
				var_356_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_356_4.position).x, (manager.ui.mainCamera.transform.position - var_356_4.position).y, (manager.ui.mainCamera.transform.position - var_356_4.position).z)
				var_356_4.localEulerAngles.z = 0
				var_356_4.localEulerAngles.x = 0
				var_356_4.localEulerAngles = var_356_4.localEulerAngles
			end

			local var_356_6 = arg_353_1.actors_["1055ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_6) and arg_353_1.var_.characterEffect1055ui_story == nil then
				arg_353_1.var_.characterEffect1055ui_story = var_356_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_7 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 and not isNil(var_356_6) then
				if arg_353_1.var_.characterEffect1055ui_story and not isNil(var_356_6) then
					arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_7)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 and not isNil(var_356_6) and arg_353_1.var_.characterEffect1055ui_story then
				arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_356_8 = 0
			local var_356_9 = 0.225

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(123101088)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 9 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 9)

				if (9 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 9)) > 0 and var_356_9 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101088", "story_v_out_123101.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101088", "story_v_out_123101.awb") / 1000

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_123101", "123101088", "story_v_out_123101.awb")

						arg_353_1:RecordAudio("123101088", var_356_15)
						arg_353_1:RecordAudio("123101088", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_123101", "123101088", "story_v_out_123101.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_123101", "123101088", "story_v_out_123101.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_16 and arg_353_1.time_ < var_356_8 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play123101089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 123101089
		arg_357_1.duration_ = 6.17

		local var_357_0 = {
			zh = 3.9,
			ja = 6.166
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play123101090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1055ui_story"]) and arg_357_1.var_.characterEffect1055ui_story == nil then
				arg_357_1.var_.characterEffect1055ui_story = arg_357_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1055ui_story"]) then
				if arg_357_1.var_.characterEffect1055ui_story and not isNil(arg_357_1.actors_["1055ui_story"]) then
					arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1055ui_story"]) and arg_357_1.var_.characterEffect1055ui_story then
				arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_2 = arg_357_1.actors_["1093ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect1093ui_story == nil then
				arg_357_1.var_.characterEffect1093ui_story = var_360_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_3 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.characterEffect1093ui_story and not isNil(var_360_2) then
					arg_357_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_3)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect1093ui_story then
				arg_357_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_360_4 = 0
			local var_360_5 = 0.425

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(123101089)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 17 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 17)

				if (17 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 17)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101089", "story_v_out_123101.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101089", "story_v_out_123101.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_out_123101", "123101089", "story_v_out_123101.awb")

						arg_357_1:RecordAudio("123101089", var_360_11)
						arg_357_1:RecordAudio("123101089", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_123101", "123101089", "story_v_out_123101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_123101", "123101089", "story_v_out_123101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play123101090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 123101090
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play123101091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1055ui_story"]) and arg_361_1.var_.characterEffect1055ui_story == nil then
				arg_361_1.var_.characterEffect1055ui_story = arg_361_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1055ui_story"]) then
				if arg_361_1.var_.characterEffect1055ui_story and not isNil(arg_361_1.actors_["1055ui_story"]) then
					arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1055ui_story"]) and arg_361_1.var_.characterEffect1055ui_story then
				arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_364_1 = arg_361_1.actors_["1055ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1055ui_story = var_364_1.localPosition
			end

			local var_364_2 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_2 then
				var_364_1.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_2)
				var_364_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_1.position).x, (manager.ui.mainCamera.transform.position - var_364_1.position).y, (manager.ui.mainCamera.transform.position - var_364_1.position).z)
				var_364_1.localEulerAngles.z = 0
				var_364_1.localEulerAngles.x = 0
				var_364_1.localEulerAngles = var_364_1.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_2 and arg_361_1.time_ < 0 + var_364_2 + arg_364_0 then
				var_364_1.localPosition = Vector3.New(0, 100, 0)
				var_364_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_1.position).x, (manager.ui.mainCamera.transform.position - var_364_1.position).y, (manager.ui.mainCamera.transform.position - var_364_1.position).z)
				var_364_1.localEulerAngles.z = 0
				var_364_1.localEulerAngles.x = 0
				var_364_1.localEulerAngles = var_364_1.localEulerAngles
			end

			local var_364_3 = arg_361_1.actors_["1093ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1093ui_story = var_364_3.localPosition
			end

			local var_364_4 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				var_364_3.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_4)
				var_364_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_3.position).x, (manager.ui.mainCamera.transform.position - var_364_3.position).y, (manager.ui.mainCamera.transform.position - var_364_3.position).z)
				var_364_3.localEulerAngles.z = 0
				var_364_3.localEulerAngles.x = 0
				var_364_3.localEulerAngles = var_364_3.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				var_364_3.localPosition = Vector3.New(0, 100, 0)
				var_364_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_3.position).x, (manager.ui.mainCamera.transform.position - var_364_3.position).y, (manager.ui.mainCamera.transform.position - var_364_3.position).z)
				var_364_3.localEulerAngles.z = 0
				var_364_3.localEulerAngles.x = 0
				var_364_3.localEulerAngles = var_364_3.localEulerAngles
			end

			local var_364_5 = 0
			local var_364_6 = 0.7

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(123101090).content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 28 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_7) / 28)

				if (28 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_7) / 28)) > 0 and var_364_6 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_10 and arg_361_1.time_ < var_364_5 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play123101091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 123101091
		arg_365_1.duration_ = 3.9

		local var_365_0 = {
			zh = 3.3,
			ja = 3.9
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play123101092(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1093ui_story"]) and arg_365_1.var_.characterEffect1093ui_story == nil then
				arg_365_1.var_.characterEffect1093ui_story = arg_365_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1093ui_story"]) then
				if arg_365_1.var_.characterEffect1093ui_story and not isNil(arg_365_1.actors_["1093ui_story"]) then
					arg_365_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1093ui_story"]) and arg_365_1.var_.characterEffect1093ui_story then
				arg_365_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_1")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_368_2 = arg_365_1.actors_["1093ui_story"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1093ui_story = var_368_2.localPosition
			end

			local var_368_3 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 then
				var_368_2.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_365_1.time_ - 0) / var_368_3)
				var_368_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_2.position).x, (manager.ui.mainCamera.transform.position - var_368_2.position).y, (manager.ui.mainCamera.transform.position - var_368_2.position).z)
				var_368_2.localEulerAngles.z = 0
				var_368_2.localEulerAngles.x = 0
				var_368_2.localEulerAngles = var_368_2.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 then
				var_368_2.localPosition = Vector3.New(0, -1.11, -5.88)
				var_368_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_2.position).x, (manager.ui.mainCamera.transform.position - var_368_2.position).y, (manager.ui.mainCamera.transform.position - var_368_2.position).z)
				var_368_2.localEulerAngles.z = 0
				var_368_2.localEulerAngles.x = 0
				var_368_2.localEulerAngles = var_368_2.localEulerAngles
			end

			local var_368_4 = arg_365_1.actors_["1055ui_story"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1055ui_story = var_368_4.localPosition
			end

			local var_368_5 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_5 then
				var_368_4.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_365_1.time_ - 0) / var_368_5)
				var_368_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_4.position).x, (manager.ui.mainCamera.transform.position - var_368_4.position).y, (manager.ui.mainCamera.transform.position - var_368_4.position).z)
				var_368_4.localEulerAngles.z = 0
				var_368_4.localEulerAngles.x = 0
				var_368_4.localEulerAngles = var_368_4.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_5 and arg_365_1.time_ < 0 + var_368_5 + arg_368_0 then
				var_368_4.localPosition = Vector3.New(0, 100, 0)
				var_368_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_4.position).x, (manager.ui.mainCamera.transform.position - var_368_4.position).y, (manager.ui.mainCamera.transform.position - var_368_4.position).z)
				var_368_4.localEulerAngles.z = 0
				var_368_4.localEulerAngles.x = 0
				var_368_4.localEulerAngles = var_368_4.localEulerAngles
			end

			local var_368_6 = 0
			local var_368_7 = 0.35

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_6 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_8 = arg_365_1:GetWordFromCfg(123101091)
				local var_368_9 = arg_365_1:FormatText(var_368_8.content)

				arg_365_1.text_.text = var_368_9

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_11 = 14 <= 0 and var_368_7 or var_368_7 * (utf8.len(var_368_9) / 14)

				if (14 <= 0 and var_368_7 or var_368_7 * (utf8.len(var_368_9) / 14)) > 0 and var_368_7 < var_368_11 then
					arg_365_1.talkMaxDuration = var_368_11

					if var_368_11 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_11 + var_368_6
					end
				end

				arg_365_1.text_.text = var_368_9
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101091", "story_v_out_123101.awb") ~= 0 then
					local var_368_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101091", "story_v_out_123101.awb") / 1000

					if var_368_12 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_12 + var_368_6
					end

					if var_368_8.prefab_name ~= "" and arg_365_1.actors_[var_368_8.prefab_name] ~= nil then
						local var_368_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_8.prefab_name].transform, "story_v_out_123101", "123101091", "story_v_out_123101.awb")

						arg_365_1:RecordAudio("123101091", var_368_13)
						arg_365_1:RecordAudio("123101091", var_368_13)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_123101", "123101091", "story_v_out_123101.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_123101", "123101091", "story_v_out_123101.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_14 = math.max(var_368_7, arg_365_1.talkMaxDuration)

			if var_368_6 <= arg_365_1.time_ and arg_365_1.time_ < var_368_6 + var_368_14 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_6) / var_368_14

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_6 + var_368_14 and arg_365_1.time_ < var_368_6 + var_368_14 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play123101092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 123101092
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play123101093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1093ui_story"]) and arg_369_1.var_.characterEffect1093ui_story == nil then
				arg_369_1.var_.characterEffect1093ui_story = arg_369_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1093ui_story"]) then
				if arg_369_1.var_.characterEffect1093ui_story and not isNil(arg_369_1.actors_["1093ui_story"]) then
					arg_369_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1093ui_story"]) and arg_369_1.var_.characterEffect1093ui_story then
				arg_369_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 1.15

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(123101092).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 46 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 46)

				if (46 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 46)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play123101093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 123101093
		arg_373_1.duration_ = 9.53

		local var_373_0 = {
			zh = 9.533,
			ja = 8.966
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
				arg_373_0:Play123101094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1093ui_story"]) and arg_373_1.var_.characterEffect1093ui_story == nil then
				arg_373_1.var_.characterEffect1093ui_story = arg_373_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1093ui_story"]) then
				if arg_373_1.var_.characterEffect1093ui_story and not isNil(arg_373_1.actors_["1093ui_story"]) then
					arg_373_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1093ui_story"]) and arg_373_1.var_.characterEffect1093ui_story then
				arg_373_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_2 = 0
			local var_376_3 = 1.05

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(123101093)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 42 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 42)

				if (42 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 42)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101093", "story_v_out_123101.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101093", "story_v_out_123101.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_123101", "123101093", "story_v_out_123101.awb")

						arg_373_1:RecordAudio("123101093", var_376_9)
						arg_373_1:RecordAudio("123101093", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_123101", "123101093", "story_v_out_123101.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_123101", "123101093", "story_v_out_123101.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play123101094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 123101094
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play123101095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1093ui_story"]) and arg_377_1.var_.characterEffect1093ui_story == nil then
				arg_377_1.var_.characterEffect1093ui_story = arg_377_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1093ui_story"]) then
				if arg_377_1.var_.characterEffect1093ui_story and not isNil(arg_377_1.actors_["1093ui_story"]) then
					arg_377_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1093ui_story"]) and arg_377_1.var_.characterEffect1093ui_story then
				arg_377_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 1.15

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(123101094).content)

				arg_377_1.text_.text = var_380_3

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 46 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 46)

				if (46 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_3) / 46)) > 0 and var_380_2 < var_380_5 then
					arg_377_1.talkMaxDuration = var_380_5

					if var_380_5 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_5 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_3
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_6 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_6 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_6

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_6 and arg_377_1.time_ < var_380_1 + var_380_6 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play123101095 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 123101095
		arg_381_1.duration_ = 2.3

		local var_381_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_381_0:Play123101096(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1093ui_story"]) and arg_381_1.var_.characterEffect1093ui_story == nil then
				arg_381_1.var_.characterEffect1093ui_story = arg_381_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1093ui_story"]) then
				if arg_381_1.var_.characterEffect1093ui_story and not isNil(arg_381_1.actors_["1093ui_story"]) then
					arg_381_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1093ui_story"]) and arg_381_1.var_.characterEffect1093ui_story then
				arg_381_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action3_2")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_384_2 = 0
			local var_384_3 = 0.125

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(123101095)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 5 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 5)

				if (5 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 5)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101095", "story_v_out_123101.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101095", "story_v_out_123101.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_out_123101", "123101095", "story_v_out_123101.awb")

						arg_381_1:RecordAudio("123101095", var_384_9)
						arg_381_1:RecordAudio("123101095", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_123101", "123101095", "story_v_out_123101.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_123101", "123101095", "story_v_out_123101.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_10 and arg_381_1.time_ < var_384_2 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play123101096 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 123101096
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play123101097(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1093ui_story"]) and arg_385_1.var_.characterEffect1093ui_story == nil then
				arg_385_1.var_.characterEffect1093ui_story = arg_385_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1093ui_story"]) then
				if arg_385_1.var_.characterEffect1093ui_story and not isNil(arg_385_1.actors_["1093ui_story"]) then
					arg_385_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1093ui_story"]) and arg_385_1.var_.characterEffect1093ui_story then
				arg_385_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 1.075

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(123101096).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 43 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 43)

				if (43 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 43)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play123101097 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 123101097
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play123101098(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.625

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(123101097).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 25 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 25)

				if (25 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 25)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play123101098 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 123101098
		arg_393_1.duration_ = 5.83

		local var_393_0 = {
			zh = 5.2,
			ja = 5.833
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
				arg_393_0:Play123101099(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1093ui_story"]) and arg_393_1.var_.characterEffect1093ui_story == nil then
				arg_393_1.var_.characterEffect1093ui_story = arg_393_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1093ui_story"]) then
				if arg_393_1.var_.characterEffect1093ui_story and not isNil(arg_393_1.actors_["1093ui_story"]) then
					arg_393_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1093ui_story"]) and arg_393_1.var_.characterEffect1093ui_story then
				arg_393_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_396_2 = 0
			local var_396_3 = 0.65

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:GetWordFromCfg(123101098)
				local var_396_5 = arg_393_1:FormatText(var_396_4.content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 26 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 26)

				if (26 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 26)) > 0 and var_396_3 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101098", "story_v_out_123101.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101098", "story_v_out_123101.awb") / 1000

					if var_396_8 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_2
					end

					if var_396_4.prefab_name ~= "" and arg_393_1.actors_[var_396_4.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_4.prefab_name].transform, "story_v_out_123101", "123101098", "story_v_out_123101.awb")

						arg_393_1:RecordAudio("123101098", var_396_9)
						arg_393_1:RecordAudio("123101098", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_123101", "123101098", "story_v_out_123101.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_123101", "123101098", "story_v_out_123101.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_10 and arg_393_1.time_ < var_396_2 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play123101099 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 123101099
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play123101100(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1093ui_story"]) and arg_397_1.var_.characterEffect1093ui_story == nil then
				arg_397_1.var_.characterEffect1093ui_story = arg_397_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1093ui_story"]) then
				if arg_397_1.var_.characterEffect1093ui_story and not isNil(arg_397_1.actors_["1093ui_story"]) then
					arg_397_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1093ui_story"]) and arg_397_1.var_.characterEffect1093ui_story then
				arg_397_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_400_1 = 0
			local var_400_2 = 1

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(123101099).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 40 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 40)

				if (40 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 40)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play123101100 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 123101100
		arg_401_1.duration_ = 8

		local var_401_0 = {
			zh = 5.2,
			ja = 8
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play123101101(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1055ui_story = arg_401_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1055ui_story"].transform.position).z)
				arg_401_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1055ui_story"].transform.localEulerAngles = arg_401_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_401_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1055ui_story"].transform.position).z)
				arg_401_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1055ui_story"].transform.localEulerAngles = arg_401_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["1055ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1055ui_story == nil then
				arg_401_1.var_.characterEffect1055ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect1055ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1055ui_story then
				arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_404_4 = arg_401_1.actors_["1093ui_story"].transform

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1093ui_story = var_404_4.localPosition
			end

			local var_404_5 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_5 then
				var_404_4.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_401_1.time_ - 0) / var_404_5)
				var_404_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_404_4.position).x, (manager.ui.mainCamera.transform.position - var_404_4.position).y, (manager.ui.mainCamera.transform.position - var_404_4.position).z)
				var_404_4.localEulerAngles.z = 0
				var_404_4.localEulerAngles.x = 0
				var_404_4.localEulerAngles = var_404_4.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_5 and arg_401_1.time_ < 0 + var_404_5 + arg_404_0 then
				var_404_4.localPosition = Vector3.New(0, 100, 0)
				var_404_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_404_4.position).x, (manager.ui.mainCamera.transform.position - var_404_4.position).y, (manager.ui.mainCamera.transform.position - var_404_4.position).z)
				var_404_4.localEulerAngles.z = 0
				var_404_4.localEulerAngles.x = 0
				var_404_4.localEulerAngles = var_404_4.localEulerAngles
			end

			local var_404_6 = 0
			local var_404_7 = 0.6

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_8 = arg_401_1:GetWordFromCfg(123101100)
				local var_404_9 = arg_401_1:FormatText(var_404_8.content)

				arg_401_1.text_.text = var_404_9

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 24 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 24)

				if (24 <= 0 and var_404_7 or var_404_7 * (utf8.len(var_404_9) / 24)) > 0 and var_404_7 < var_404_11 then
					arg_401_1.talkMaxDuration = var_404_11

					if var_404_11 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_9
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101100", "story_v_out_123101.awb") ~= 0 then
					local var_404_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101100", "story_v_out_123101.awb") / 1000

					if var_404_12 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_12 + var_404_6
					end

					if var_404_8.prefab_name ~= "" and arg_401_1.actors_[var_404_8.prefab_name] ~= nil then
						local var_404_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_8.prefab_name].transform, "story_v_out_123101", "123101100", "story_v_out_123101.awb")

						arg_401_1:RecordAudio("123101100", var_404_13)
						arg_401_1:RecordAudio("123101100", var_404_13)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_123101", "123101100", "story_v_out_123101.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_123101", "123101100", "story_v_out_123101.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
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

		arg_401_1:InitPlayNodeList()
	end,
	Play123101101 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 123101101
		arg_405_1.duration_ = 3.7

		local var_405_0 = {
			zh = 3.366,
			ja = 3.7
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
				arg_405_0:Play123101102(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1093ui_story = arg_405_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1093ui_story"].transform.position).z)
				arg_405_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1093ui_story"].transform.localEulerAngles = arg_405_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_405_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1093ui_story"].transform.position).z)
				arg_405_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1093ui_story"].transform.localEulerAngles = arg_405_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1093ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1093ui_story == nil then
				arg_405_1.var_.characterEffect1093ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1093ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1093ui_story then
				arg_405_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_408_4 = arg_405_1.actors_["1055ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect1055ui_story == nil then
				arg_405_1.var_.characterEffect1055ui_story = var_408_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_5 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_5 and not isNil(var_408_4) then
				if arg_405_1.var_.characterEffect1055ui_story and not isNil(var_408_4) then
					arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_5)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_5 and arg_405_1.time_ < 0 + var_408_5 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect1055ui_story then
				arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_408_6 = arg_405_1.actors_["1055ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1055ui_story = var_408_6.localPosition
			end

			local var_408_7 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				var_408_6.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_7)
				var_408_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_6.position).x, (manager.ui.mainCamera.transform.position - var_408_6.position).y, (manager.ui.mainCamera.transform.position - var_408_6.position).z)
				var_408_6.localEulerAngles.z = 0
				var_408_6.localEulerAngles.x = 0
				var_408_6.localEulerAngles = var_408_6.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				var_408_6.localPosition = Vector3.New(0, 100, 0)
				var_408_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_6.position).x, (manager.ui.mainCamera.transform.position - var_408_6.position).y, (manager.ui.mainCamera.transform.position - var_408_6.position).z)
				var_408_6.localEulerAngles.z = 0
				var_408_6.localEulerAngles.x = 0
				var_408_6.localEulerAngles = var_408_6.localEulerAngles
			end

			local var_408_8 = 0
			local var_408_9 = 0.4

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:GetWordFromCfg(123101101)
				local var_408_11 = arg_405_1:FormatText(var_408_10.content)

				arg_405_1.text_.text = var_408_11

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_13 = 16 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 16)

				if (16 <= 0 and var_408_9 or var_408_9 * (utf8.len(var_408_11) / 16)) > 0 and var_408_9 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_11
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101101", "story_v_out_123101.awb") ~= 0 then
					local var_408_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101101", "story_v_out_123101.awb") / 1000

					if var_408_14 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_8
					end

					if var_408_10.prefab_name ~= "" and arg_405_1.actors_[var_408_10.prefab_name] ~= nil then
						local var_408_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_10.prefab_name].transform, "story_v_out_123101", "123101101", "story_v_out_123101.awb")

						arg_405_1:RecordAudio("123101101", var_408_15)
						arg_405_1:RecordAudio("123101101", var_408_15)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_123101", "123101101", "story_v_out_123101.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_123101", "123101101", "story_v_out_123101.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_16 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_16 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_16

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_16 and arg_405_1.time_ < var_408_8 + var_408_16 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play123101102 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 123101102
		arg_409_1.duration_ = 10.1

		local var_409_0 = {
			zh = 6.766,
			ja = 10.1
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
				arg_409_0:Play123101103(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1093ui_story"]) and arg_409_1.var_.characterEffect1093ui_story == nil then
				arg_409_1.var_.characterEffect1093ui_story = arg_409_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1093ui_story"]) then
				if arg_409_1.var_.characterEffect1093ui_story and not isNil(arg_409_1.actors_["1093ui_story"]) then
					arg_409_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1093ui_story"]) and arg_409_1.var_.characterEffect1093ui_story then
				arg_409_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_412_1 = arg_409_1.actors_["1093ui_story"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1093ui_story = var_412_1.localPosition
			end

			local var_412_2 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 then
				var_412_1.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_2)
				var_412_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_1.position).x, (manager.ui.mainCamera.transform.position - var_412_1.position).y, (manager.ui.mainCamera.transform.position - var_412_1.position).z)
				var_412_1.localEulerAngles.z = 0
				var_412_1.localEulerAngles.x = 0
				var_412_1.localEulerAngles = var_412_1.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 then
				var_412_1.localPosition = Vector3.New(0, 100, 0)
				var_412_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_1.position).x, (manager.ui.mainCamera.transform.position - var_412_1.position).y, (manager.ui.mainCamera.transform.position - var_412_1.position).z)
				var_412_1.localEulerAngles.z = 0
				var_412_1.localEulerAngles.x = 0
				var_412_1.localEulerAngles = var_412_1.localEulerAngles
			end

			local var_412_3 = 0
			local var_412_4 = 0.525

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_5 = arg_409_1:GetWordFromCfg(123101102)
				local var_412_6 = arg_409_1:FormatText(var_412_5.content)

				arg_409_1.text_.text = var_412_6

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_8 = 21 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_6) / 21)

				if (21 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_6) / 21)) > 0 and var_412_4 < var_412_8 then
					arg_409_1.talkMaxDuration = var_412_8

					if var_412_8 + var_412_3 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_3
					end
				end

				arg_409_1.text_.text = var_412_6
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101102", "story_v_out_123101.awb") ~= 0 then
					local var_412_9 = manager.audio:GetVoiceLength("story_v_out_123101", "123101102", "story_v_out_123101.awb") / 1000

					if var_412_9 + var_412_3 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_3
					end

					if var_412_5.prefab_name ~= "" and arg_409_1.actors_[var_412_5.prefab_name] ~= nil then
						local var_412_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_5.prefab_name].transform, "story_v_out_123101", "123101102", "story_v_out_123101.awb")

						arg_409_1:RecordAudio("123101102", var_412_10)
						arg_409_1:RecordAudio("123101102", var_412_10)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_123101", "123101102", "story_v_out_123101.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_123101", "123101102", "story_v_out_123101.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_11 = math.max(var_412_4, arg_409_1.talkMaxDuration)

			if var_412_3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_3 + var_412_11 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_3) / var_412_11

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_3 + var_412_11 and arg_409_1.time_ < var_412_3 + var_412_11 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play123101103 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 123101103
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play123101104(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.8

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(123101103).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 32 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 32)

				if (32 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 32)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play123101104 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 123101104
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play123101105(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.525

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(123101104).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 21 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 21)

				if (21 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 21)) > 0 and var_420_0 < var_420_3 then
					arg_417_1.talkMaxDuration = var_420_3

					if var_420_3 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_3 + 0
					end
				end

				arg_417_1.text_.text = var_420_1
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_4 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_4

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play123101105 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 123101105
		arg_421_1.duration_ = 10.07

		local var_421_0 = {
			zh = 5.533,
			ja = 10.066
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play123101106(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1055ui_story = arg_421_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1055ui_story"].transform.position).z)
				arg_421_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1055ui_story"].transform.localEulerAngles = arg_421_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_421_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1055ui_story"].transform.position).z)
				arg_421_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1055ui_story"].transform.localEulerAngles = arg_421_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1055ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1055ui_story == nil then
				arg_421_1.var_.characterEffect1055ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1055ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1055ui_story then
				arg_421_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_424_4 = 0
			local var_424_5 = 0.575

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_6 = arg_421_1:GetWordFromCfg(123101105)
				local var_424_7 = arg_421_1:FormatText(var_424_6.content)

				arg_421_1.text_.text = var_424_7

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_9 = 23 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 23)

				if (23 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 23)) > 0 and var_424_5 < var_424_9 then
					arg_421_1.talkMaxDuration = var_424_9

					if var_424_9 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_9 + var_424_4
					end
				end

				arg_421_1.text_.text = var_424_7
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101105", "story_v_out_123101.awb") ~= 0 then
					local var_424_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101105", "story_v_out_123101.awb") / 1000

					if var_424_10 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_4
					end

					if var_424_6.prefab_name ~= "" and arg_421_1.actors_[var_424_6.prefab_name] ~= nil then
						local var_424_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_6.prefab_name].transform, "story_v_out_123101", "123101105", "story_v_out_123101.awb")

						arg_421_1:RecordAudio("123101105", var_424_11)
						arg_421_1:RecordAudio("123101105", var_424_11)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_123101", "123101105", "story_v_out_123101.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_123101", "123101105", "story_v_out_123101.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_12 = math.max(var_424_5, arg_421_1.talkMaxDuration)

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_12 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_4) / var_424_12

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_4 + var_424_12 and arg_421_1.time_ < var_424_4 + var_424_12 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	Play123101106 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 123101106
		arg_425_1.duration_ = 1.2

		local var_425_0 = {
			zh = 0.999999999999,
			ja = 1.2
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
				arg_425_0:Play123101107(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1055ui_story"]) and arg_425_1.var_.characterEffect1055ui_story == nil then
				arg_425_1.var_.characterEffect1055ui_story = arg_425_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1055ui_story"]) then
				if arg_425_1.var_.characterEffect1055ui_story and not isNil(arg_425_1.actors_["1055ui_story"]) then
					arg_425_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1055ui_story"]) and arg_425_1.var_.characterEffect1055ui_story then
				arg_425_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 0.075

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:GetWordFromCfg(123101106)
				local var_428_4 = arg_425_1:FormatText(var_428_3.content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_6 = 3 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_4) / 3)

				if (3 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_4) / 3)) > 0 and var_428_2 < var_428_6 then
					arg_425_1.talkMaxDuration = var_428_6

					if var_428_6 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_6 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101106", "story_v_out_123101.awb") ~= 0 then
					local var_428_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101106", "story_v_out_123101.awb") / 1000

					if var_428_7 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_1
					end

					if var_428_3.prefab_name ~= "" and arg_425_1.actors_[var_428_3.prefab_name] ~= nil then
						local var_428_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_3.prefab_name].transform, "story_v_out_123101", "123101106", "story_v_out_123101.awb")

						arg_425_1:RecordAudio("123101106", var_428_8)
						arg_425_1:RecordAudio("123101106", var_428_8)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_123101", "123101106", "story_v_out_123101.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_123101", "123101106", "story_v_out_123101.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_9 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_9 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_9

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_9 and arg_425_1.time_ < var_428_1 + var_428_9 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play123101107 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 123101107
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play123101108(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.725

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

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(123101107).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 29 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 29)

				if (29 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 29)) > 0 and var_432_0 < var_432_3 then
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
	Play123101108 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 123101108
		arg_433_1.duration_ = 6.67

		local var_433_0 = {
			zh = 4,
			ja = 6.666
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
				arg_433_0:Play123101109(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1055ui_story"]) and arg_433_1.var_.characterEffect1055ui_story == nil then
				arg_433_1.var_.characterEffect1055ui_story = arg_433_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1055ui_story"]) then
				if arg_433_1.var_.characterEffect1055ui_story and not isNil(arg_433_1.actors_["1055ui_story"]) then
					arg_433_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1055ui_story"]) and arg_433_1.var_.characterEffect1055ui_story then
				arg_433_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_2")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_436_2 = 0
			local var_436_3 = 0.4

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_2 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_4 = arg_433_1:GetWordFromCfg(123101108)
				local var_436_5 = arg_433_1:FormatText(var_436_4.content)

				arg_433_1.text_.text = var_436_5

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_7 = 16 <= 0 and var_436_3 or var_436_3 * (utf8.len(var_436_5) / 16)

				if (16 <= 0 and var_436_3 or var_436_3 * (utf8.len(var_436_5) / 16)) > 0 and var_436_3 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_2 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_2
					end
				end

				arg_433_1.text_.text = var_436_5
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101108", "story_v_out_123101.awb") ~= 0 then
					local var_436_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101108", "story_v_out_123101.awb") / 1000

					if var_436_8 + var_436_2 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_8 + var_436_2
					end

					if var_436_4.prefab_name ~= "" and arg_433_1.actors_[var_436_4.prefab_name] ~= nil then
						local var_436_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_4.prefab_name].transform, "story_v_out_123101", "123101108", "story_v_out_123101.awb")

						arg_433_1:RecordAudio("123101108", var_436_9)
						arg_433_1:RecordAudio("123101108", var_436_9)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_123101", "123101108", "story_v_out_123101.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_123101", "123101108", "story_v_out_123101.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_10 = math.max(var_436_3, arg_433_1.talkMaxDuration)

			if var_436_2 <= arg_433_1.time_ and arg_433_1.time_ < var_436_2 + var_436_10 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_2) / var_436_10

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_2 + var_436_10 and arg_433_1.time_ < var_436_2 + var_436_10 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play123101109 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 123101109
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play123101110(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1055ui_story"]) and arg_437_1.var_.characterEffect1055ui_story == nil then
				arg_437_1.var_.characterEffect1055ui_story = arg_437_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1055ui_story"]) then
				if arg_437_1.var_.characterEffect1055ui_story and not isNil(arg_437_1.actors_["1055ui_story"]) then
					arg_437_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1055ui_story"]) and arg_437_1.var_.characterEffect1055ui_story then
				arg_437_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_440_1 = arg_437_1.actors_["1055ui_story"].transform

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1055ui_story = var_440_1.localPosition
			end

			local var_440_2 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 then
				var_440_1.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_437_1.time_ - 0) / var_440_2)
				var_440_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_1.position).x, (manager.ui.mainCamera.transform.position - var_440_1.position).y, (manager.ui.mainCamera.transform.position - var_440_1.position).z)
				var_440_1.localEulerAngles.z = 0
				var_440_1.localEulerAngles.x = 0
				var_440_1.localEulerAngles = var_440_1.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 then
				var_440_1.localPosition = Vector3.New(0, 100, 0)
				var_440_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_1.position).x, (manager.ui.mainCamera.transform.position - var_440_1.position).y, (manager.ui.mainCamera.transform.position - var_440_1.position).z)
				var_440_1.localEulerAngles.z = 0
				var_440_1.localEulerAngles.x = 0
				var_440_1.localEulerAngles = var_440_1.localEulerAngles
			end

			local var_440_3 = 0
			local var_440_4 = 0.7

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_3 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_5 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(123101109).content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 28 <= 0 and var_440_4 or var_440_4 * (utf8.len(var_440_5) / 28)

				if (28 <= 0 and var_440_4 or var_440_4 * (utf8.len(var_440_5) / 28)) > 0 and var_440_4 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_3 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_3
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_8 = math.max(var_440_4, arg_437_1.talkMaxDuration)

			if var_440_3 <= arg_437_1.time_ and arg_437_1.time_ < var_440_3 + var_440_8 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_3) / var_440_8

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_3 + var_440_8 and arg_437_1.time_ < var_440_3 + var_440_8 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
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

		arg_437_1:InitPlayNodeList()
	end,
	Play123101110 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 123101110
		arg_441_1.duration_ = 4.1

		local var_441_0 = {
			zh = 4.1,
			ja = 2.5
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
				arg_441_0:Play123101111(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1055ui_story"]) and arg_441_1.var_.characterEffect1055ui_story == nil then
				arg_441_1.var_.characterEffect1055ui_story = arg_441_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1055ui_story"]) then
				if arg_441_1.var_.characterEffect1055ui_story and not isNil(arg_441_1.actors_["1055ui_story"]) then
					arg_441_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1055ui_story"]) and arg_441_1.var_.characterEffect1055ui_story then
				arg_441_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.15

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(123101110)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_6 = 6 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_4) / 6)

				if (6 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_4) / 6)) > 0 and var_444_2 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101110", "story_v_out_123101.awb") ~= 0 then
					local var_444_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101110", "story_v_out_123101.awb") / 1000

					if var_444_7 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_1
					end

					if var_444_3.prefab_name ~= "" and arg_441_1.actors_[var_444_3.prefab_name] ~= nil then
						local var_444_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_3.prefab_name].transform, "story_v_out_123101", "123101110", "story_v_out_123101.awb")

						arg_441_1:RecordAudio("123101110", var_444_8)
						arg_441_1:RecordAudio("123101110", var_444_8)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_123101", "123101110", "story_v_out_123101.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_123101", "123101110", "story_v_out_123101.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_9 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_9 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_9

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_9 and arg_441_1.time_ < var_444_1 + var_444_9 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play123101111 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 123101111
		arg_445_1.duration_ = 9

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play123101112(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if arg_445_1.bgs_.K05g == nil then
				local var_448_0 = Object.Instantiate(arg_445_1.paintGo_)

				var_448_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05g")
				var_448_0.name = "K05g"
				var_448_0.transform.parent = arg_445_1.stage_.transform
				var_448_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_445_1.bgs_.K05g = var_448_0
			end

			if 1.999999999999 < arg_445_1.time_ and arg_445_1.time_ <= 1.999999999999 + arg_448_0 then
				local var_448_1 = arg_445_1.bgs_.K05g

				arg_445_1.bgs_.K05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_448_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_448_2 = var_448_1:GetComponent("SpriteRenderer")

				if var_448_2 and var_448_2.sprite then
					local var_448_3 = 2 * (var_448_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_448_1.transform.localScale = Vector3.New(var_448_3 / var_448_2.sprite.bounds.size.y < var_448_3 * manager.ui.mainCameraCom_.aspect / var_448_2.sprite.bounds.size.x and var_448_3 * manager.ui.mainCameraCom_.aspect / var_448_2.sprite.bounds.size.x or var_448_3 / var_448_2.sprite.bounds.size.y, var_448_3 / var_448_2.sprite.bounds.size.y < var_448_3 * manager.ui.mainCameraCom_.aspect / var_448_2.sprite.bounds.size.x and var_448_3 * manager.ui.mainCameraCom_.aspect / var_448_2.sprite.bounds.size.x or var_448_3 / var_448_2.sprite.bounds.size.y, 0)
				end

				for iter_448_0, iter_448_1 in pairs(arg_445_1.bgs_) do
					if iter_448_0 ~= "K05g" then
						iter_448_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_448_4 = 0

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = true

				arg_445_1:SetGaussion(false)
			end

			local var_448_5 = 2

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_5 then
				local var_448_6 = Color.New(0, 0, 0)

				var_448_6.a = Mathf.Lerp(0, 1, (arg_445_1.time_ - var_448_4) / var_448_5)
				arg_445_1.mask_.color = var_448_6
			end

			if arg_445_1.time_ >= var_448_4 + var_448_5 and arg_445_1.time_ < var_448_4 + var_448_5 + arg_448_0 then
				local var_448_7 = Color.New(0, 0, 0)

				var_448_7.a = 1
				arg_445_1.mask_.color = var_448_7
			end

			local var_448_8 = 2

			if 2 < arg_445_1.time_ and arg_445_1.time_ <= var_448_8 + arg_448_0 then
				arg_445_1.mask_.enabled = true
				arg_445_1.mask_.raycastTarget = true

				arg_445_1:SetGaussion(false)
			end

			local var_448_9 = 2

			if var_448_8 <= arg_445_1.time_ and arg_445_1.time_ < var_448_8 + var_448_9 then
				local var_448_10 = Color.New(0, 0, 0)

				var_448_10.a = Mathf.Lerp(1, 0, (arg_445_1.time_ - var_448_8) / var_448_9)
				arg_445_1.mask_.color = var_448_10
			end

			if arg_445_1.time_ >= var_448_8 + var_448_9 and arg_445_1.time_ < var_448_8 + var_448_9 + arg_448_0 then
				local var_448_11 = Color.New(0, 0, 0)

				arg_445_1.mask_.enabled = false
				var_448_11.a = 0
				arg_445_1.mask_.color = var_448_11
			end

			if arg_445_1.frameCnt_ <= 1 then
				arg_445_1.dialog_:SetActive(false)
			end

			local var_448_12 = 4
			local var_448_13 = 0.85

			if 4 < arg_445_1.time_ and arg_445_1.time_ <= var_448_12 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0

				arg_445_1.dialog_:SetActive(true)

				arg_445_1.dialogCg_.alpha = 0

				local var_448_14 = LeanTween.value(arg_445_1.dialog_, 0, 1, 0.3)

				var_448_14:setOnUpdate(LuaHelper.FloatAction(function(arg_449_0)
					arg_445_1.dialogCg_.alpha = arg_449_0
				end))
				var_448_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_445_1.dialog_)
					var_448_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_445_1.duration_ = arg_445_1.duration_ + 0.3

				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_15 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(123101111).content)

				arg_445_1.text_.text = var_448_15

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_17 = 34 <= 0 and var_448_13 or var_448_13 * (utf8.len(var_448_15) / 34)

				if (34 <= 0 and var_448_13 or var_448_13 * (utf8.len(var_448_15) / 34)) > 0 and var_448_13 < var_448_17 then
					arg_445_1.talkMaxDuration = var_448_17
					var_448_12 = var_448_12 + 0.3

					if var_448_17 + var_448_12 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_17 + var_448_12
					end
				end

				arg_445_1.text_.text = var_448_15
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_18 = var_448_12 + 0.3
			local var_448_19 = math.max(var_448_13, arg_445_1.talkMaxDuration)

			if var_448_12 + 0.3 <= arg_445_1.time_ and arg_445_1.time_ < var_448_18 + var_448_19 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_18) / var_448_19

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_18 + var_448_19 and arg_445_1.time_ < var_448_18 + var_448_19 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play123101112 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 123101112
		arg_451_1.duration_ = 4.8

		local var_451_0 = {
			zh = 4.8,
			ja = 4
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play123101113(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos1055ui_story = arg_451_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1055ui_story"].transform.position).z)
				arg_451_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1055ui_story"].transform.localEulerAngles = arg_451_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_451_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["1055ui_story"].transform.position).z)
				arg_451_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["1055ui_story"].transform.localEulerAngles = arg_451_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["1055ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1055ui_story == nil then
				arg_451_1.var_.characterEffect1055ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect1055ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect1055ui_story then
				arg_451_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_454_4 = 0
			local var_454_5 = 0.45

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_6 = arg_451_1:GetWordFromCfg(123101112)
				local var_454_7 = arg_451_1:FormatText(var_454_6.content)

				arg_451_1.text_.text = var_454_7

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 18 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 18)

				if (18 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 18)) > 0 and var_454_5 < var_454_9 then
					arg_451_1.talkMaxDuration = var_454_9

					if var_454_9 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_7
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101112", "story_v_out_123101.awb") ~= 0 then
					local var_454_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101112", "story_v_out_123101.awb") / 1000

					if var_454_10 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_4
					end

					if var_454_6.prefab_name ~= "" and arg_451_1.actors_[var_454_6.prefab_name] ~= nil then
						local var_454_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_6.prefab_name].transform, "story_v_out_123101", "123101112", "story_v_out_123101.awb")

						arg_451_1:RecordAudio("123101112", var_454_11)
						arg_451_1:RecordAudio("123101112", var_454_11)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_123101", "123101112", "story_v_out_123101.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_123101", "123101112", "story_v_out_123101.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_12 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_12 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_12

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_12 and arg_451_1.time_ < var_454_4 + var_454_12 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
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

		arg_451_1:InitPlayNodeList()
	end,
	Play123101113 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 123101113
		arg_455_1.duration_ = 3.5

		local var_455_0 = {
			zh = 2.2,
			ja = 3.5
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play123101114(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["1055ui_story"]) and arg_455_1.var_.characterEffect1055ui_story == nil then
				arg_455_1.var_.characterEffect1055ui_story = arg_455_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["1055ui_story"]) then
				if arg_455_1.var_.characterEffect1055ui_story and not isNil(arg_455_1.actors_["1055ui_story"]) then
					arg_455_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_0)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["1055ui_story"]) and arg_455_1.var_.characterEffect1055ui_story then
				arg_455_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_458_1 = 0
			local var_458_2 = 0.275

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:GetWordFromCfg(123101113)
				local var_458_4 = arg_455_1:FormatText(var_458_3.content)

				arg_455_1.text_.text = var_458_4

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_6 = 11 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_4) / 11)

				if (11 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_4) / 11)) > 0 and var_458_2 < var_458_6 then
					arg_455_1.talkMaxDuration = var_458_6

					if var_458_6 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_6 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_4
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101113", "story_v_out_123101.awb") ~= 0 then
					local var_458_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101113", "story_v_out_123101.awb") / 1000

					if var_458_7 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_7 + var_458_1
					end

					if var_458_3.prefab_name ~= "" and arg_455_1.actors_[var_458_3.prefab_name] ~= nil then
						local var_458_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_3.prefab_name].transform, "story_v_out_123101", "123101113", "story_v_out_123101.awb")

						arg_455_1:RecordAudio("123101113", var_458_8)
						arg_455_1:RecordAudio("123101113", var_458_8)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_123101", "123101113", "story_v_out_123101.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_123101", "123101113", "story_v_out_123101.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_9 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_9 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_9

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_9 and arg_455_1.time_ < var_458_1 + var_458_9 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play123101114 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 123101114
		arg_459_1.duration_ = 3.5

		local var_459_0 = {
			zh = 3.5,
			ja = 2.733
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play123101115(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["1055ui_story"]) and arg_459_1.var_.characterEffect1055ui_story == nil then
				arg_459_1.var_.characterEffect1055ui_story = arg_459_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_462_0 = 0.200000002980232

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["1055ui_story"]) then
				if arg_459_1.var_.characterEffect1055ui_story and not isNil(arg_459_1.actors_["1055ui_story"]) then
					arg_459_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["1055ui_story"]) and arg_459_1.var_.characterEffect1055ui_story then
				arg_459_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_462_2 = 0
			local var_462_3 = 0.4

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_2 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_4 = arg_459_1:GetWordFromCfg(123101114)
				local var_462_5 = arg_459_1:FormatText(var_462_4.content)

				arg_459_1.text_.text = var_462_5

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_7 = 16 <= 0 and var_462_3 or var_462_3 * (utf8.len(var_462_5) / 16)

				if (16 <= 0 and var_462_3 or var_462_3 * (utf8.len(var_462_5) / 16)) > 0 and var_462_3 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_2 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_2
					end
				end

				arg_459_1.text_.text = var_462_5
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101114", "story_v_out_123101.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101114", "story_v_out_123101.awb") / 1000

					if var_462_8 + var_462_2 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_2
					end

					if var_462_4.prefab_name ~= "" and arg_459_1.actors_[var_462_4.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_4.prefab_name].transform, "story_v_out_123101", "123101114", "story_v_out_123101.awb")

						arg_459_1:RecordAudio("123101114", var_462_9)
						arg_459_1:RecordAudio("123101114", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_123101", "123101114", "story_v_out_123101.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_123101", "123101114", "story_v_out_123101.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_10 = math.max(var_462_3, arg_459_1.talkMaxDuration)

			if var_462_2 <= arg_459_1.time_ and arg_459_1.time_ < var_462_2 + var_462_10 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_2) / var_462_10

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_2 + var_462_10 and arg_459_1.time_ < var_462_2 + var_462_10 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play123101115 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 123101115
		arg_463_1.duration_ = 13.4

		local var_463_0 = {
			zh = 5.1,
			ja = 13.4
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play123101116(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["1055ui_story"]) and arg_463_1.var_.characterEffect1055ui_story == nil then
				arg_463_1.var_.characterEffect1055ui_story = arg_463_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.200000002980232

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["1055ui_story"]) then
				if arg_463_1.var_.characterEffect1055ui_story and not isNil(arg_463_1.actors_["1055ui_story"]) then
					arg_463_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_463_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_463_1.time_ - 0) / var_466_0)
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["1055ui_story"]) and arg_463_1.var_.characterEffect1055ui_story then
				arg_463_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_463_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_466_1 = 0
			local var_466_2 = 0.575

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_3 = arg_463_1:GetWordFromCfg(123101115)
				local var_466_4 = arg_463_1:FormatText(var_466_3.content)

				arg_463_1.text_.text = var_466_4

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_6 = 23 <= 0 and var_466_2 or var_466_2 * (utf8.len(var_466_4) / 23)

				if (23 <= 0 and var_466_2 or var_466_2 * (utf8.len(var_466_4) / 23)) > 0 and var_466_2 < var_466_6 then
					arg_463_1.talkMaxDuration = var_466_6

					if var_466_6 + var_466_1 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_6 + var_466_1
					end
				end

				arg_463_1.text_.text = var_466_4
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101115", "story_v_out_123101.awb") ~= 0 then
					local var_466_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101115", "story_v_out_123101.awb") / 1000

					if var_466_7 + var_466_1 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_7 + var_466_1
					end

					if var_466_3.prefab_name ~= "" and arg_463_1.actors_[var_466_3.prefab_name] ~= nil then
						local var_466_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_3.prefab_name].transform, "story_v_out_123101", "123101115", "story_v_out_123101.awb")

						arg_463_1:RecordAudio("123101115", var_466_8)
						arg_463_1:RecordAudio("123101115", var_466_8)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_123101", "123101115", "story_v_out_123101.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_123101", "123101115", "story_v_out_123101.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_9 = math.max(var_466_2, arg_463_1.talkMaxDuration)

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_9 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_1) / var_466_9

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_1 + var_466_9 and arg_463_1.time_ < var_466_1 + var_466_9 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play123101116 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 123101116
		arg_467_1.duration_ = 5.2

		local var_467_0 = {
			zh = 3.666,
			ja = 5.2
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play123101117(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["1055ui_story"]) and arg_467_1.var_.characterEffect1055ui_story == nil then
				arg_467_1.var_.characterEffect1055ui_story = arg_467_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_470_0 = 0.200000002980232

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["1055ui_story"]) then
				if arg_467_1.var_.characterEffect1055ui_story and not isNil(arg_467_1.actors_["1055ui_story"]) then
					arg_467_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["1055ui_story"]) and arg_467_1.var_.characterEffect1055ui_story then
				arg_467_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_470_2 = 0
			local var_470_3 = 0.325

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_2 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_4 = arg_467_1:GetWordFromCfg(123101116)
				local var_470_5 = arg_467_1:FormatText(var_470_4.content)

				arg_467_1.text_.text = var_470_5

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_7 = 13 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_5) / 13)

				if (13 <= 0 and var_470_3 or var_470_3 * (utf8.len(var_470_5) / 13)) > 0 and var_470_3 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_2
					end
				end

				arg_467_1.text_.text = var_470_5
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101116", "story_v_out_123101.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101116", "story_v_out_123101.awb") / 1000

					if var_470_8 + var_470_2 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_2
					end

					if var_470_4.prefab_name ~= "" and arg_467_1.actors_[var_470_4.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_4.prefab_name].transform, "story_v_out_123101", "123101116", "story_v_out_123101.awb")

						arg_467_1:RecordAudio("123101116", var_470_9)
						arg_467_1:RecordAudio("123101116", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_123101", "123101116", "story_v_out_123101.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_123101", "123101116", "story_v_out_123101.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_3, arg_467_1.talkMaxDuration)

			if var_470_2 <= arg_467_1.time_ and arg_467_1.time_ < var_470_2 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_2) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_2 + var_470_10 and arg_467_1.time_ < var_470_2 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play123101117 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 123101117
		arg_471_1.duration_ = 7.7

		local var_471_0 = {
			zh = 4.8,
			ja = 7.7
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play123101118(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["1055ui_story"]) and arg_471_1.var_.characterEffect1055ui_story == nil then
				arg_471_1.var_.characterEffect1055ui_story = arg_471_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_0 = 0.200000002980232

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["1055ui_story"]) then
				if arg_471_1.var_.characterEffect1055ui_story and not isNil(arg_471_1.actors_["1055ui_story"]) then
					arg_471_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_471_1.time_ - 0) / var_474_0)
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["1055ui_story"]) and arg_471_1.var_.characterEffect1055ui_story then
				arg_471_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_474_1 = 0
			local var_474_2 = 0.65

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_471_1.callingController_:SetSelectedState("normal")

				arg_471_1.keyicon_.color = Color.New(1, 1, 1)
				arg_471_1.icon_.color = Color.New(1, 1, 1)

				local var_474_3 = arg_471_1:GetWordFromCfg(123101117)
				local var_474_4 = arg_471_1:FormatText(var_474_3.content)

				arg_471_1.text_.text = var_474_4

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_6 = 26 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_4) / 26)

				if (26 <= 0 and var_474_2 or var_474_2 * (utf8.len(var_474_4) / 26)) > 0 and var_474_2 < var_474_6 then
					arg_471_1.talkMaxDuration = var_474_6

					if var_474_6 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_6 + var_474_1
					end
				end

				arg_471_1.text_.text = var_474_4
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101117", "story_v_out_123101.awb") ~= 0 then
					local var_474_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101117", "story_v_out_123101.awb") / 1000

					if var_474_7 + var_474_1 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_7 + var_474_1
					end

					if var_474_3.prefab_name ~= "" and arg_471_1.actors_[var_474_3.prefab_name] ~= nil then
						local var_474_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_3.prefab_name].transform, "story_v_out_123101", "123101117", "story_v_out_123101.awb")

						arg_471_1:RecordAudio("123101117", var_474_8)
						arg_471_1:RecordAudio("123101117", var_474_8)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_123101", "123101117", "story_v_out_123101.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_123101", "123101117", "story_v_out_123101.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_9 = math.max(var_474_2, arg_471_1.talkMaxDuration)

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_9 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_1) / var_474_9

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_1 + var_474_9 and arg_471_1.time_ < var_474_1 + var_474_9 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play123101118 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 123101118
		arg_475_1.duration_ = 8.27

		local var_475_0 = {
			zh = 6.566,
			ja = 8.266
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play123101119(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["1055ui_story"]) and arg_475_1.var_.characterEffect1055ui_story == nil then
				arg_475_1.var_.characterEffect1055ui_story = arg_475_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_0 = 0.200000002980232

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["1055ui_story"]) then
				if arg_475_1.var_.characterEffect1055ui_story and not isNil(arg_475_1.actors_["1055ui_story"]) then
					arg_475_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["1055ui_story"]) and arg_475_1.var_.characterEffect1055ui_story then
				arg_475_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_478_2 = 0
			local var_478_3 = 0.85

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_2 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_4 = arg_475_1:GetWordFromCfg(123101118)
				local var_478_5 = arg_475_1:FormatText(var_478_4.content)

				arg_475_1.text_.text = var_478_5

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_7 = 34 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 34)

				if (34 <= 0 and var_478_3 or var_478_3 * (utf8.len(var_478_5) / 34)) > 0 and var_478_3 < var_478_7 then
					arg_475_1.talkMaxDuration = var_478_7

					if var_478_7 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_7 + var_478_2
					end
				end

				arg_475_1.text_.text = var_478_5
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101118", "story_v_out_123101.awb") ~= 0 then
					local var_478_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101118", "story_v_out_123101.awb") / 1000

					if var_478_8 + var_478_2 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_8 + var_478_2
					end

					if var_478_4.prefab_name ~= "" and arg_475_1.actors_[var_478_4.prefab_name] ~= nil then
						local var_478_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_4.prefab_name].transform, "story_v_out_123101", "123101118", "story_v_out_123101.awb")

						arg_475_1:RecordAudio("123101118", var_478_9)
						arg_475_1:RecordAudio("123101118", var_478_9)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_123101", "123101118", "story_v_out_123101.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_123101", "123101118", "story_v_out_123101.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_10 = math.max(var_478_3, arg_475_1.talkMaxDuration)

			if var_478_2 <= arg_475_1.time_ and arg_475_1.time_ < var_478_2 + var_478_10 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_2) / var_478_10

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_2 + var_478_10 and arg_475_1.time_ < var_478_2 + var_478_10 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play123101119 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 123101119
		arg_479_1.duration_ = 4.47

		local var_479_0 = {
			zh = 3.633,
			ja = 4.466
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
				arg_479_0:Play123101120(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_0 = 0
			local var_482_1 = 0.375

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_2 = arg_479_1:GetWordFromCfg(123101119)
				local var_482_3 = arg_479_1:FormatText(var_482_2.content)

				arg_479_1.text_.text = var_482_3

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 15 <= 0 and var_482_1 or var_482_1 * (utf8.len(var_482_3) / 15)

				if (15 <= 0 and var_482_1 or var_482_1 * (utf8.len(var_482_3) / 15)) > 0 and var_482_1 < var_482_5 then
					arg_479_1.talkMaxDuration = var_482_5

					if var_482_5 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_5 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_3
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101119", "story_v_out_123101.awb") ~= 0 then
					local var_482_6 = manager.audio:GetVoiceLength("story_v_out_123101", "123101119", "story_v_out_123101.awb") / 1000

					if var_482_6 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_6 + var_482_0
					end

					if var_482_2.prefab_name ~= "" and arg_479_1.actors_[var_482_2.prefab_name] ~= nil then
						local var_482_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_2.prefab_name].transform, "story_v_out_123101", "123101119", "story_v_out_123101.awb")

						arg_479_1:RecordAudio("123101119", var_482_7)
						arg_479_1:RecordAudio("123101119", var_482_7)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_123101", "123101119", "story_v_out_123101.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_123101", "123101119", "story_v_out_123101.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_8 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_8 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_8

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_8 and arg_479_1.time_ < var_482_0 + var_482_8 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play123101120 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 123101120
		arg_483_1.duration_ = 8.7

		local var_483_0 = {
			zh = 6.9,
			ja = 8.7
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play123101121(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1055ui_story"]) and arg_483_1.var_.characterEffect1055ui_story == nil then
				arg_483_1.var_.characterEffect1055ui_story = arg_483_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_486_0 = 0.200000002980232

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1055ui_story"]) then
				if arg_483_1.var_.characterEffect1055ui_story and not isNil(arg_483_1.actors_["1055ui_story"]) then
					arg_483_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_483_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_483_1.time_ - 0) / var_486_0)
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1055ui_story"]) and arg_483_1.var_.characterEffect1055ui_story then
				arg_483_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_483_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_486_1 = 0
			local var_486_2 = 0.675

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_1 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_483_1.callingController_:SetSelectedState("normal")

				arg_483_1.keyicon_.color = Color.New(1, 1, 1)
				arg_483_1.icon_.color = Color.New(1, 1, 1)

				local var_486_3 = arg_483_1:GetWordFromCfg(123101120)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_6 = 27 <= 0 and var_486_2 or var_486_2 * (utf8.len(var_486_4) / 27)

				if (27 <= 0 and var_486_2 or var_486_2 * (utf8.len(var_486_4) / 27)) > 0 and var_486_2 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_1 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_1
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101120", "story_v_out_123101.awb") ~= 0 then
					local var_486_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101120", "story_v_out_123101.awb") / 1000

					if var_486_7 + var_486_1 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_1
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_123101", "123101120", "story_v_out_123101.awb")

						arg_483_1:RecordAudio("123101120", var_486_8)
						arg_483_1:RecordAudio("123101120", var_486_8)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_123101", "123101120", "story_v_out_123101.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_123101", "123101120", "story_v_out_123101.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_9 = math.max(var_486_2, arg_483_1.talkMaxDuration)

			if var_486_1 <= arg_483_1.time_ and arg_483_1.time_ < var_486_1 + var_486_9 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_1) / var_486_9

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_1 + var_486_9 and arg_483_1.time_ < var_486_1 + var_486_9 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play123101121 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 123101121
		arg_487_1.duration_ = 8.73

		local var_487_0 = {
			zh = 6.533,
			ja = 8.733
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
				arg_487_0:Play123101122(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["1055ui_story"]) and arg_487_1.var_.characterEffect1055ui_story == nil then
				arg_487_1.var_.characterEffect1055ui_story = arg_487_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_0 = 0.200000002980232

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["1055ui_story"]) then
				if arg_487_1.var_.characterEffect1055ui_story and not isNil(arg_487_1.actors_["1055ui_story"]) then
					arg_487_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["1055ui_story"]) and arg_487_1.var_.characterEffect1055ui_story then
				arg_487_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_490_2 = 0
			local var_490_3 = 0.675

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_2 + arg_490_0 then
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

				local var_490_4 = arg_487_1:GetWordFromCfg(123101121)
				local var_490_5 = arg_487_1:FormatText(var_490_4.content)

				arg_487_1.text_.text = var_490_5

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_7 = 27 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_5) / 27)

				if (27 <= 0 and var_490_3 or var_490_3 * (utf8.len(var_490_5) / 27)) > 0 and var_490_3 < var_490_7 then
					arg_487_1.talkMaxDuration = var_490_7

					if var_490_7 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_7 + var_490_2
					end
				end

				arg_487_1.text_.text = var_490_5
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101121", "story_v_out_123101.awb") ~= 0 then
					local var_490_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101121", "story_v_out_123101.awb") / 1000

					if var_490_8 + var_490_2 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_2
					end

					if var_490_4.prefab_name ~= "" and arg_487_1.actors_[var_490_4.prefab_name] ~= nil then
						local var_490_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_4.prefab_name].transform, "story_v_out_123101", "123101121", "story_v_out_123101.awb")

						arg_487_1:RecordAudio("123101121", var_490_9)
						arg_487_1:RecordAudio("123101121", var_490_9)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_123101", "123101121", "story_v_out_123101.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_123101", "123101121", "story_v_out_123101.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_10 = math.max(var_490_3, arg_487_1.talkMaxDuration)

			if var_490_2 <= arg_487_1.time_ and arg_487_1.time_ < var_490_2 + var_490_10 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_2) / var_490_10

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_2 + var_490_10 and arg_487_1.time_ < var_490_2 + var_490_10 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play123101122 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 123101122
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play123101123(arg_491_1)
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
			local var_494_2 = 0.275

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_3 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(123101122).content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 11 <= 0 and var_494_2 or var_494_2 * (utf8.len(var_494_3) / 11)

				if (11 <= 0 and var_494_2 or var_494_2 * (utf8.len(var_494_3) / 11)) > 0 and var_494_2 < var_494_5 then
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
	Play123101123 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 123101123
		arg_495_1.duration_ = 3.53

		local var_495_0 = {
			zh = 2.233,
			ja = 3.533
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
				arg_495_0:Play123101124(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.25

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:GetWordFromCfg(123101123)
				local var_498_2 = arg_495_1:FormatText(var_498_1.content)

				arg_495_1.text_.text = var_498_2

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_4 = 10 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 10)

				if (10 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_2) / 10)) > 0 and var_498_0 < var_498_4 then
					arg_495_1.talkMaxDuration = var_498_4

					if var_498_4 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_4 + 0
					end
				end

				arg_495_1.text_.text = var_498_2
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101123", "story_v_out_123101.awb") ~= 0 then
					local var_498_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101123", "story_v_out_123101.awb") / 1000

					if var_498_5 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + 0
					end

					if var_498_1.prefab_name ~= "" and arg_495_1.actors_[var_498_1.prefab_name] ~= nil then
						local var_498_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_1.prefab_name].transform, "story_v_out_123101", "123101123", "story_v_out_123101.awb")

						arg_495_1:RecordAudio("123101123", var_498_6)
						arg_495_1:RecordAudio("123101123", var_498_6)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_123101", "123101123", "story_v_out_123101.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_123101", "123101123", "story_v_out_123101.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_7 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_7

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play123101124 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 123101124
		arg_499_1.duration_ = 2

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play123101125(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1055ui_story"]) and arg_499_1.var_.characterEffect1055ui_story == nil then
				arg_499_1.var_.characterEffect1055ui_story = arg_499_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1055ui_story"]) then
				if arg_499_1.var_.characterEffect1055ui_story and not isNil(arg_499_1.actors_["1055ui_story"]) then
					arg_499_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1055ui_story"]) and arg_499_1.var_.characterEffect1055ui_story then
				arg_499_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_502_2 = 0
			local var_502_3 = 0.05

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_2 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_4 = arg_499_1:GetWordFromCfg(123101124)
				local var_502_5 = arg_499_1:FormatText(var_502_4.content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 2 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 2)

				if (2 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 2)) > 0 and var_502_3 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_2
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101124", "story_v_out_123101.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101124", "story_v_out_123101.awb") / 1000

					if var_502_8 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_2
					end

					if var_502_4.prefab_name ~= "" and arg_499_1.actors_[var_502_4.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_4.prefab_name].transform, "story_v_out_123101", "123101124", "story_v_out_123101.awb")

						arg_499_1:RecordAudio("123101124", var_502_9)
						arg_499_1:RecordAudio("123101124", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_123101", "123101124", "story_v_out_123101.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_123101", "123101124", "story_v_out_123101.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_3, arg_499_1.talkMaxDuration)

			if var_502_2 <= arg_499_1.time_ and arg_499_1.time_ < var_502_2 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_2) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_2 + var_502_10 and arg_499_1.time_ < var_502_2 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play123101125 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 123101125
		arg_503_1.duration_ = 6.93

		local var_503_0 = {
			zh = 6.333,
			ja = 6.933
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play123101126(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1055ui_story"]) and arg_503_1.var_.characterEffect1055ui_story == nil then
				arg_503_1.var_.characterEffect1055ui_story = arg_503_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1055ui_story"]) then
				if arg_503_1.var_.characterEffect1055ui_story and not isNil(arg_503_1.actors_["1055ui_story"]) then
					arg_503_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_0)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1055ui_story"]) and arg_503_1.var_.characterEffect1055ui_story then
				arg_503_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_506_1 = 0
			local var_506_2 = 0.675

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[496].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:GetWordFromCfg(123101125)
				local var_506_4 = arg_503_1:FormatText(var_506_3.content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_6 = 27 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_4) / 27)

				if (27 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_4) / 27)) > 0 and var_506_2 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101125", "story_v_out_123101.awb") ~= 0 then
					local var_506_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101125", "story_v_out_123101.awb") / 1000

					if var_506_7 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_7 + var_506_1
					end

					if var_506_3.prefab_name ~= "" and arg_503_1.actors_[var_506_3.prefab_name] ~= nil then
						local var_506_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_3.prefab_name].transform, "story_v_out_123101", "123101125", "story_v_out_123101.awb")

						arg_503_1:RecordAudio("123101125", var_506_8)
						arg_503_1:RecordAudio("123101125", var_506_8)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_123101", "123101125", "story_v_out_123101.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_123101", "123101125", "story_v_out_123101.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_9 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_9 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_9

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_9 and arg_503_1.time_ < var_506_1 + var_506_9 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play123101126 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 123101126
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play123101127(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0.75

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_1 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(123101126).content)

				arg_507_1.text_.text = var_510_1

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_3 = 30 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 30)

				if (30 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_1) / 30)) > 0 and var_510_0 < var_510_3 then
					arg_507_1.talkMaxDuration = var_510_3

					if var_510_3 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_3 + 0
					end
				end

				arg_507_1.text_.text = var_510_1
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_4 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_4

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play123101127 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 123101127
		arg_511_1.duration_ = 4.93

		local var_511_0 = {
			zh = 2.766,
			ja = 4.933
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play123101128(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1055ui_story"]) and arg_511_1.var_.characterEffect1055ui_story == nil then
				arg_511_1.var_.characterEffect1055ui_story = arg_511_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_0 = 0.200000002980232

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1055ui_story"]) then
				if arg_511_1.var_.characterEffect1055ui_story and not isNil(arg_511_1.actors_["1055ui_story"]) then
					arg_511_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1055ui_story"]) and arg_511_1.var_.characterEffect1055ui_story then
				arg_511_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_514_2 = 0
			local var_514_3 = 0.375

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_4 = arg_511_1:GetWordFromCfg(123101127)
				local var_514_5 = arg_511_1:FormatText(var_514_4.content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 15 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 15)

				if (15 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 15)) > 0 and var_514_3 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101127", "story_v_out_123101.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101127", "story_v_out_123101.awb") / 1000

					if var_514_8 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_2
					end

					if var_514_4.prefab_name ~= "" and arg_511_1.actors_[var_514_4.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_4.prefab_name].transform, "story_v_out_123101", "123101127", "story_v_out_123101.awb")

						arg_511_1:RecordAudio("123101127", var_514_9)
						arg_511_1:RecordAudio("123101127", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_123101", "123101127", "story_v_out_123101.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_123101", "123101127", "story_v_out_123101.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_10 and arg_511_1.time_ < var_514_2 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play123101128 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 123101128
		arg_515_1.duration_ = 8.83

		local var_515_0 = {
			zh = 4.533,
			ja = 8.833
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
				arg_515_0:Play123101129(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["1055ui_story"]) and arg_515_1.var_.characterEffect1055ui_story == nil then
				arg_515_1.var_.characterEffect1055ui_story = arg_515_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_0 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["1055ui_story"]) then
				if arg_515_1.var_.characterEffect1055ui_story and not isNil(arg_515_1.actors_["1055ui_story"]) then
					arg_515_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_0)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["1055ui_story"]) and arg_515_1.var_.characterEffect1055ui_story then
				arg_515_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_518_1 = 0
			local var_518_2 = 0.5

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_3 = arg_515_1:GetWordFromCfg(123101128)
				local var_518_4 = arg_515_1:FormatText(var_518_3.content)

				arg_515_1.text_.text = var_518_4

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_6 = 20 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_4) / 20)

				if (20 <= 0 and var_518_2 or var_518_2 * (utf8.len(var_518_4) / 20)) > 0 and var_518_2 < var_518_6 then
					arg_515_1.talkMaxDuration = var_518_6

					if var_518_6 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_6 + var_518_1
					end
				end

				arg_515_1.text_.text = var_518_4
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101128", "story_v_out_123101.awb") ~= 0 then
					local var_518_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101128", "story_v_out_123101.awb") / 1000

					if var_518_7 + var_518_1 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_7 + var_518_1
					end

					if var_518_3.prefab_name ~= "" and arg_515_1.actors_[var_518_3.prefab_name] ~= nil then
						local var_518_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_3.prefab_name].transform, "story_v_out_123101", "123101128", "story_v_out_123101.awb")

						arg_515_1:RecordAudio("123101128", var_518_8)
						arg_515_1:RecordAudio("123101128", var_518_8)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_123101", "123101128", "story_v_out_123101.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_123101", "123101128", "story_v_out_123101.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_9 = math.max(var_518_2, arg_515_1.talkMaxDuration)

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_9 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_1) / var_518_9

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_1 + var_518_9 and arg_515_1.time_ < var_518_1 + var_518_9 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play123101129 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 123101129
		arg_519_1.duration_ = 3.43

		local var_519_0 = {
			zh = 3.433,
			ja = 3.1
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
				arg_519_0:Play123101130(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["1055ui_story"]) and arg_519_1.var_.characterEffect1055ui_story == nil then
				arg_519_1.var_.characterEffect1055ui_story = arg_519_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_0 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["1055ui_story"]) then
				if arg_519_1.var_.characterEffect1055ui_story and not isNil(arg_519_1.actors_["1055ui_story"]) then
					arg_519_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["1055ui_story"]) and arg_519_1.var_.characterEffect1055ui_story then
				arg_519_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_522_2 = 0
			local var_522_3 = 0.425

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_2 + arg_522_0 then
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

				local var_522_4 = arg_519_1:GetWordFromCfg(123101129)
				local var_522_5 = arg_519_1:FormatText(var_522_4.content)

				arg_519_1.text_.text = var_522_5

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_7 = 17 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 17)

				if (17 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 17)) > 0 and var_522_3 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_2
					end
				end

				arg_519_1.text_.text = var_522_5
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101129", "story_v_out_123101.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101129", "story_v_out_123101.awb") / 1000

					if var_522_8 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_2
					end

					if var_522_4.prefab_name ~= "" and arg_519_1.actors_[var_522_4.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_4.prefab_name].transform, "story_v_out_123101", "123101129", "story_v_out_123101.awb")

						arg_519_1:RecordAudio("123101129", var_522_9)
						arg_519_1:RecordAudio("123101129", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_123101", "123101129", "story_v_out_123101.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_123101", "123101129", "story_v_out_123101.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_3, arg_519_1.talkMaxDuration)

			if var_522_2 <= arg_519_1.time_ and arg_519_1.time_ < var_522_2 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_2) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_2 + var_522_10 and arg_519_1.time_ < var_522_2 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play123101130 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 123101130
		arg_523_1.duration_ = 4.2

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play123101131(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1055ui_story"]) and arg_523_1.var_.characterEffect1055ui_story == nil then
				arg_523_1.var_.characterEffect1055ui_story = arg_523_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1055ui_story"]) then
				if arg_523_1.var_.characterEffect1055ui_story and not isNil(arg_523_1.actors_["1055ui_story"]) then
					arg_523_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1055ui_story"]) and arg_523_1.var_.characterEffect1055ui_story then
				arg_523_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_526_1 = 0
			local var_526_2 = 0.375

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(123101130)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_6 = 15 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_4) / 15)

				if (15 <= 0 and var_526_2 or var_526_2 * (utf8.len(var_526_4) / 15)) > 0 and var_526_2 < var_526_6 then
					arg_523_1.talkMaxDuration = var_526_6

					if var_526_6 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_6 + var_526_1
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101130", "story_v_out_123101.awb") ~= 0 then
					local var_526_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101130", "story_v_out_123101.awb") / 1000

					if var_526_7 + var_526_1 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_1
					end

					if var_526_3.prefab_name ~= "" and arg_523_1.actors_[var_526_3.prefab_name] ~= nil then
						local var_526_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_3.prefab_name].transform, "story_v_out_123101", "123101130", "story_v_out_123101.awb")

						arg_523_1:RecordAudio("123101130", var_526_8)
						arg_523_1:RecordAudio("123101130", var_526_8)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_123101", "123101130", "story_v_out_123101.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_123101", "123101130", "story_v_out_123101.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_9 = math.max(var_526_2, arg_523_1.talkMaxDuration)

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_9 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_1) / var_526_9

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_1 + var_526_9 and arg_523_1.time_ < var_526_1 + var_526_9 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play123101131 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 123101131
		arg_527_1.duration_ = 8.9

		local var_527_0 = {
			zh = 8.466,
			ja = 8.9
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play123101132(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.8

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:GetWordFromCfg(123101131)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 32 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 32)

				if (32 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 32)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101131", "story_v_out_123101.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101131", "story_v_out_123101.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_out_123101", "123101131", "story_v_out_123101.awb")

						arg_527_1:RecordAudio("123101131", var_530_6)
						arg_527_1:RecordAudio("123101131", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_123101", "123101131", "story_v_out_123101.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_123101", "123101131", "story_v_out_123101.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play123101132 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 123101132
		arg_531_1.duration_ = 4.6

		local var_531_0 = {
			zh = 4.6,
			ja = 2.033
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
				arg_531_0:Play123101133(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1055ui_story = arg_531_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["1055ui_story"].transform.position).z)
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["1055ui_story"].transform.localEulerAngles = arg_531_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
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
					arg_531_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_531_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_531_1.time_ - 0) / var_534_2)
				end
			end

			if arg_531_1.time_ >= 0 + var_534_2 and arg_531_1.time_ < 0 + var_534_2 + arg_534_0 and not isNil(var_534_1) and arg_531_1.var_.characterEffect1055ui_story then
				arg_531_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_531_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_534_3 = arg_531_1.actors_["1093ui_story"].transform

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos1093ui_story = var_534_3.localPosition
			end

			local var_534_4 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_4 then
				var_534_3.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_531_1.time_ - 0) / var_534_4)
				var_534_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_534_3.position).x, (manager.ui.mainCamera.transform.position - var_534_3.position).y, (manager.ui.mainCamera.transform.position - var_534_3.position).z)
				var_534_3.localEulerAngles.z = 0
				var_534_3.localEulerAngles.x = 0
				var_534_3.localEulerAngles = var_534_3.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_4 and arg_531_1.time_ < 0 + var_534_4 + arg_534_0 then
				var_534_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_534_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_534_3.position).x, (manager.ui.mainCamera.transform.position - var_534_3.position).y, (manager.ui.mainCamera.transform.position - var_534_3.position).z)
				var_534_3.localEulerAngles.z = 0
				var_534_3.localEulerAngles.x = 0
				var_534_3.localEulerAngles = var_534_3.localEulerAngles
			end

			local var_534_5 = arg_531_1.actors_["1093ui_story"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_5) and arg_531_1.var_.characterEffect1093ui_story == nil then
				arg_531_1.var_.characterEffect1093ui_story = var_534_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_6 = 0.200000002980232

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_6 and not isNil(var_534_5) then
				if arg_531_1.var_.characterEffect1093ui_story and not isNil(var_534_5) then
					arg_531_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= 0 + var_534_6 and arg_531_1.time_ < 0 + var_534_6 + arg_534_0 and not isNil(var_534_5) and arg_531_1.var_.characterEffect1093ui_story then
				arg_531_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_534_8 = 0
			local var_534_9 = 0.225

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_8 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_10 = arg_531_1:GetWordFromCfg(123101132)
				local var_534_11 = arg_531_1:FormatText(var_534_10.content)

				arg_531_1.text_.text = var_534_11

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_13 = 9 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 9)

				if (9 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 9)) > 0 and var_534_9 < var_534_13 then
					arg_531_1.talkMaxDuration = var_534_13

					if var_534_13 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_8
					end
				end

				arg_531_1.text_.text = var_534_11
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101132", "story_v_out_123101.awb") ~= 0 then
					local var_534_14 = manager.audio:GetVoiceLength("story_v_out_123101", "123101132", "story_v_out_123101.awb") / 1000

					if var_534_14 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_14 + var_534_8
					end

					if var_534_10.prefab_name ~= "" and arg_531_1.actors_[var_534_10.prefab_name] ~= nil then
						local var_534_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_10.prefab_name].transform, "story_v_out_123101", "123101132", "story_v_out_123101.awb")

						arg_531_1:RecordAudio("123101132", var_534_15)
						arg_531_1:RecordAudio("123101132", var_534_15)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_123101", "123101132", "story_v_out_123101.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_123101", "123101132", "story_v_out_123101.awb")
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
	Play123101133 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 123101133
		arg_535_1.duration_ = 2.37

		local var_535_0 = {
			zh = 2.366,
			ja = 1.999999999999
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play123101134(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["1093ui_story"]) and arg_535_1.var_.characterEffect1093ui_story == nil then
				arg_535_1.var_.characterEffect1093ui_story = arg_535_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_0 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["1093ui_story"]) then
				if arg_535_1.var_.characterEffect1093ui_story and not isNil(arg_535_1.actors_["1093ui_story"]) then
					arg_535_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_0)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["1093ui_story"]) and arg_535_1.var_.characterEffect1093ui_story then
				arg_535_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_538_1 = 0
			local var_538_2 = 0.15

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:GetWordFromCfg(123101133)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_6 = 6 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_4) / 6)

				if (6 <= 0 and var_538_2 or var_538_2 * (utf8.len(var_538_4) / 6)) > 0 and var_538_2 < var_538_6 then
					arg_535_1.talkMaxDuration = var_538_6

					if var_538_6 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_6 + var_538_1
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101133", "story_v_out_123101.awb") ~= 0 then
					local var_538_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101133", "story_v_out_123101.awb") / 1000

					if var_538_7 + var_538_1 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_1
					end

					if var_538_3.prefab_name ~= "" and arg_535_1.actors_[var_538_3.prefab_name] ~= nil then
						local var_538_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_3.prefab_name].transform, "story_v_out_123101", "123101133", "story_v_out_123101.awb")

						arg_535_1:RecordAudio("123101133", var_538_8)
						arg_535_1:RecordAudio("123101133", var_538_8)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_123101", "123101133", "story_v_out_123101.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_123101", "123101133", "story_v_out_123101.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_9 = math.max(var_538_2, arg_535_1.talkMaxDuration)

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_9 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_1) / var_538_9

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_1 + var_538_9 and arg_535_1.time_ < var_538_1 + var_538_9 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play123101134 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 123101134
		arg_539_1.duration_ = 6.07

		local var_539_0 = {
			zh = 3.666,
			ja = 6.066
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play123101135(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos1055ui_story = arg_539_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_542_0 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 then
				arg_539_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_539_1.time_ - 0) / var_542_0)
				arg_539_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1055ui_story"].transform.position).z)
				arg_539_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["1055ui_story"].transform.localEulerAngles = arg_539_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 then
				arg_539_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_539_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["1055ui_story"].transform.position).z)
				arg_539_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["1055ui_story"].transform.localEulerAngles = arg_539_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_542_1 = arg_539_1.actors_["1055ui_story"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_1) and arg_539_1.var_.characterEffect1055ui_story == nil then
				arg_539_1.var_.characterEffect1055ui_story = var_542_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_2 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_2 and not isNil(var_542_1) then
				if arg_539_1.var_.characterEffect1055ui_story and not isNil(var_542_1) then
					arg_539_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_2 and arg_539_1.time_ < 0 + var_542_2 + arg_542_0 and not isNil(var_542_1) and arg_539_1.var_.characterEffect1055ui_story then
				arg_539_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_542_4 = arg_539_1.actors_["1093ui_story"].transform

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos1093ui_story = var_542_4.localPosition
			end

			local var_542_5 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_5 then
				var_542_4.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_539_1.time_ - 0) / var_542_5)
				var_542_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_4.position).x, (manager.ui.mainCamera.transform.position - var_542_4.position).y, (manager.ui.mainCamera.transform.position - var_542_4.position).z)
				var_542_4.localEulerAngles.z = 0
				var_542_4.localEulerAngles.x = 0
				var_542_4.localEulerAngles = var_542_4.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_5 and arg_539_1.time_ < 0 + var_542_5 + arg_542_0 then
				var_542_4.localPosition = Vector3.New(0, 100, 0)
				var_542_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_542_4.position).x, (manager.ui.mainCamera.transform.position - var_542_4.position).y, (manager.ui.mainCamera.transform.position - var_542_4.position).z)
				var_542_4.localEulerAngles.z = 0
				var_542_4.localEulerAngles.x = 0
				var_542_4.localEulerAngles = var_542_4.localEulerAngles
			end

			local var_542_6 = 0
			local var_542_7 = 0.425

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_6 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_8 = arg_539_1:GetWordFromCfg(123101134)
				local var_542_9 = arg_539_1:FormatText(var_542_8.content)

				arg_539_1.text_.text = var_542_9

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_11 = 17 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 17)

				if (17 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 17)) > 0 and var_542_7 < var_542_11 then
					arg_539_1.talkMaxDuration = var_542_11

					if var_542_11 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_6
					end
				end

				arg_539_1.text_.text = var_542_9
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101134", "story_v_out_123101.awb") ~= 0 then
					local var_542_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101134", "story_v_out_123101.awb") / 1000

					if var_542_12 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_12 + var_542_6
					end

					if var_542_8.prefab_name ~= "" and arg_539_1.actors_[var_542_8.prefab_name] ~= nil then
						local var_542_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_8.prefab_name].transform, "story_v_out_123101", "123101134", "story_v_out_123101.awb")

						arg_539_1:RecordAudio("123101134", var_542_13)
						arg_539_1:RecordAudio("123101134", var_542_13)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_123101", "123101134", "story_v_out_123101.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_123101", "123101134", "story_v_out_123101.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_14 = math.max(var_542_7, arg_539_1.talkMaxDuration)

			if var_542_6 <= arg_539_1.time_ and arg_539_1.time_ < var_542_6 + var_542_14 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_6) / var_542_14

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_6 + var_542_14 and arg_539_1.time_ < var_542_6 + var_542_14 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
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

		arg_539_1:InitPlayNodeList()
	end,
	Play123101135 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 123101135
		arg_543_1.duration_ = 3.9

		local var_543_0 = {
			zh = 3.9,
			ja = 3.566
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play123101136(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["1055ui_story"]) and arg_543_1.var_.characterEffect1055ui_story == nil then
				arg_543_1.var_.characterEffect1055ui_story = arg_543_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_0 = 0.200000002980232

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["1055ui_story"]) then
				if arg_543_1.var_.characterEffect1055ui_story and not isNil(arg_543_1.actors_["1055ui_story"]) then
					arg_543_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_543_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_543_1.time_ - 0) / var_546_0)
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["1055ui_story"]) and arg_543_1.var_.characterEffect1055ui_story then
				arg_543_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_543_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_546_1 = 0
			local var_546_2 = 0.425

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, true)
				arg_543_1.iconController_:SetSelectedState("hero")

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_3 = arg_543_1:GetWordFromCfg(123101135)
				local var_546_4 = arg_543_1:FormatText(var_546_3.content)

				arg_543_1.text_.text = var_546_4

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_6 = 17 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_4) / 17)

				if (17 <= 0 and var_546_2 or var_546_2 * (utf8.len(var_546_4) / 17)) > 0 and var_546_2 < var_546_6 then
					arg_543_1.talkMaxDuration = var_546_6

					if var_546_6 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_6 + var_546_1
					end
				end

				arg_543_1.text_.text = var_546_4
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101135", "story_v_out_123101.awb") ~= 0 then
					local var_546_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101135", "story_v_out_123101.awb") / 1000

					if var_546_7 + var_546_1 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_7 + var_546_1
					end

					if var_546_3.prefab_name ~= "" and arg_543_1.actors_[var_546_3.prefab_name] ~= nil then
						local var_546_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_3.prefab_name].transform, "story_v_out_123101", "123101135", "story_v_out_123101.awb")

						arg_543_1:RecordAudio("123101135", var_546_8)
						arg_543_1:RecordAudio("123101135", var_546_8)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_123101", "123101135", "story_v_out_123101.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_123101", "123101135", "story_v_out_123101.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_9 = math.max(var_546_2, arg_543_1.talkMaxDuration)

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_9 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_1) / var_546_9

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_1 + var_546_9 and arg_543_1.time_ < var_546_1 + var_546_9 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {}

		arg_543_1:InitPlayNodeList()
	end,
	Play123101136 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 123101136
		arg_547_1.duration_ = 4.73

		local var_547_0 = {
			zh = 4.266,
			ja = 4.733
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play123101137(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["1055ui_story"]) and arg_547_1.var_.characterEffect1055ui_story == nil then
				arg_547_1.var_.characterEffect1055ui_story = arg_547_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_0 = 0.200000002980232

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["1055ui_story"]) then
				if arg_547_1.var_.characterEffect1055ui_story and not isNil(arg_547_1.actors_["1055ui_story"]) then
					arg_547_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["1055ui_story"]) and arg_547_1.var_.characterEffect1055ui_story then
				arg_547_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_550_2 = 0
			local var_550_3 = 0.4

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_2 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, false)
				arg_547_1.callingController_:SetSelectedState("normal")

				local var_550_4 = arg_547_1:GetWordFromCfg(123101136)
				local var_550_5 = arg_547_1:FormatText(var_550_4.content)

				arg_547_1.text_.text = var_550_5

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_7 = 16 <= 0 and var_550_3 or var_550_3 * (utf8.len(var_550_5) / 16)

				if (16 <= 0 and var_550_3 or var_550_3 * (utf8.len(var_550_5) / 16)) > 0 and var_550_3 < var_550_7 then
					arg_547_1.talkMaxDuration = var_550_7

					if var_550_7 + var_550_2 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_7 + var_550_2
					end
				end

				arg_547_1.text_.text = var_550_5
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101136", "story_v_out_123101.awb") ~= 0 then
					local var_550_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101136", "story_v_out_123101.awb") / 1000

					if var_550_8 + var_550_2 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_8 + var_550_2
					end

					if var_550_4.prefab_name ~= "" and arg_547_1.actors_[var_550_4.prefab_name] ~= nil then
						local var_550_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_4.prefab_name].transform, "story_v_out_123101", "123101136", "story_v_out_123101.awb")

						arg_547_1:RecordAudio("123101136", var_550_9)
						arg_547_1:RecordAudio("123101136", var_550_9)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_out_123101", "123101136", "story_v_out_123101.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_out_123101", "123101136", "story_v_out_123101.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_10 = math.max(var_550_3, arg_547_1.talkMaxDuration)

			if var_550_2 <= arg_547_1.time_ and arg_547_1.time_ < var_550_2 + var_550_10 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_2) / var_550_10

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_2 + var_550_10 and arg_547_1.time_ < var_550_2 + var_550_10 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play123101137 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 123101137
		arg_551_1.duration_ = 7.53

		local var_551_0 = {
			zh = 4.6,
			ja = 7.533
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
				arg_551_0:Play123101138(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 and not isNil(arg_551_1.actors_["1055ui_story"]) and arg_551_1.var_.characterEffect1055ui_story == nil then
				arg_551_1.var_.characterEffect1055ui_story = arg_551_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_0 = 0.200000002980232

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_0 and not isNil(arg_551_1.actors_["1055ui_story"]) then
				if arg_551_1.var_.characterEffect1055ui_story and not isNil(arg_551_1.actors_["1055ui_story"]) then
					arg_551_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_551_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_551_1.time_ - 0) / var_554_0)
				end
			end

			if arg_551_1.time_ >= 0 + var_554_0 and arg_551_1.time_ < 0 + var_554_0 + arg_554_0 and not isNil(arg_551_1.actors_["1055ui_story"]) and arg_551_1.var_.characterEffect1055ui_story then
				arg_551_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_551_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_554_1 = 0
			local var_554_2 = 0.5

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:GetWordFromCfg(123101137)
				local var_554_4 = arg_551_1:FormatText(var_554_3.content)

				arg_551_1.text_.text = var_554_4

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_6 = 20 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_4) / 20)

				if (20 <= 0 and var_554_2 or var_554_2 * (utf8.len(var_554_4) / 20)) > 0 and var_554_2 < var_554_6 then
					arg_551_1.talkMaxDuration = var_554_6

					if var_554_6 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_6 + var_554_1
					end
				end

				arg_551_1.text_.text = var_554_4
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101137", "story_v_out_123101.awb") ~= 0 then
					local var_554_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101137", "story_v_out_123101.awb") / 1000

					if var_554_7 + var_554_1 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_1
					end

					if var_554_3.prefab_name ~= "" and arg_551_1.actors_[var_554_3.prefab_name] ~= nil then
						local var_554_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_3.prefab_name].transform, "story_v_out_123101", "123101137", "story_v_out_123101.awb")

						arg_551_1:RecordAudio("123101137", var_554_8)
						arg_551_1:RecordAudio("123101137", var_554_8)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_out_123101", "123101137", "story_v_out_123101.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_out_123101", "123101137", "story_v_out_123101.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_9 = math.max(var_554_2, arg_551_1.talkMaxDuration)

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_9 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_1) / var_554_9

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_1 + var_554_9 and arg_551_1.time_ < var_554_1 + var_554_9 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play123101138 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 123101138
		arg_555_1.duration_ = 9.07

		local var_555_0 = {
			zh = 6.8,
			ja = 9.066
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play123101139(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["1055ui_story"]) and arg_555_1.var_.characterEffect1055ui_story == nil then
				arg_555_1.var_.characterEffect1055ui_story = arg_555_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_558_0 = 0.200000002980232

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["1055ui_story"]) then
				if arg_555_1.var_.characterEffect1055ui_story and not isNil(arg_555_1.actors_["1055ui_story"]) then
					arg_555_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["1055ui_story"]) and arg_555_1.var_.characterEffect1055ui_story then
				arg_555_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_558_2 = 0
			local var_558_3 = 0.675

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_2 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_4 = arg_555_1:GetWordFromCfg(123101138)
				local var_558_5 = arg_555_1:FormatText(var_558_4.content)

				arg_555_1.text_.text = var_558_5

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_7 = 27 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_5) / 27)

				if (27 <= 0 and var_558_3 or var_558_3 * (utf8.len(var_558_5) / 27)) > 0 and var_558_3 < var_558_7 then
					arg_555_1.talkMaxDuration = var_558_7

					if var_558_7 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_7 + var_558_2
					end
				end

				arg_555_1.text_.text = var_558_5
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101138", "story_v_out_123101.awb") ~= 0 then
					local var_558_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101138", "story_v_out_123101.awb") / 1000

					if var_558_8 + var_558_2 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_8 + var_558_2
					end

					if var_558_4.prefab_name ~= "" and arg_555_1.actors_[var_558_4.prefab_name] ~= nil then
						local var_558_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_4.prefab_name].transform, "story_v_out_123101", "123101138", "story_v_out_123101.awb")

						arg_555_1:RecordAudio("123101138", var_558_9)
						arg_555_1:RecordAudio("123101138", var_558_9)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_123101", "123101138", "story_v_out_123101.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_123101", "123101138", "story_v_out_123101.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_10 = math.max(var_558_3, arg_555_1.talkMaxDuration)

			if var_558_2 <= arg_555_1.time_ and arg_555_1.time_ < var_558_2 + var_558_10 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_2) / var_558_10

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_2 + var_558_10 and arg_555_1.time_ < var_558_2 + var_558_10 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play123101139 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 123101139
		arg_559_1.duration_ = 11.2

		local var_559_0 = {
			zh = 11.2,
			ja = 8.7
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play123101140(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 1.15

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:GetWordFromCfg(123101139)
				local var_562_2 = arg_559_1:FormatText(var_562_1.content)

				arg_559_1.text_.text = var_562_2

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_4 = 46 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 46)

				if (46 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_2) / 46)) > 0 and var_562_0 < var_562_4 then
					arg_559_1.talkMaxDuration = var_562_4

					if var_562_4 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_4 + 0
					end
				end

				arg_559_1.text_.text = var_562_2
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101139", "story_v_out_123101.awb") ~= 0 then
					local var_562_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101139", "story_v_out_123101.awb") / 1000

					if var_562_5 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_5 + 0
					end

					if var_562_1.prefab_name ~= "" and arg_559_1.actors_[var_562_1.prefab_name] ~= nil then
						local var_562_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_1.prefab_name].transform, "story_v_out_123101", "123101139", "story_v_out_123101.awb")

						arg_559_1:RecordAudio("123101139", var_562_6)
						arg_559_1:RecordAudio("123101139", var_562_6)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_out_123101", "123101139", "story_v_out_123101.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_out_123101", "123101139", "story_v_out_123101.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_7 and arg_559_1.time_ < 0 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play123101140 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 123101140
		arg_563_1.duration_ = 4.2

		local var_563_0 = {
			zh = 2.066,
			ja = 4.2
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play123101141(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 and not isNil(arg_563_1.actors_["1055ui_story"]) and arg_563_1.var_.characterEffect1055ui_story == nil then
				arg_563_1.var_.characterEffect1055ui_story = arg_563_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_566_0 = 0.200000002980232

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_0 and not isNil(arg_563_1.actors_["1055ui_story"]) then
				if arg_563_1.var_.characterEffect1055ui_story and not isNil(arg_563_1.actors_["1055ui_story"]) then
					arg_563_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_563_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_563_1.time_ - 0) / var_566_0)
				end
			end

			if arg_563_1.time_ >= 0 + var_566_0 and arg_563_1.time_ < 0 + var_566_0 + arg_566_0 and not isNil(arg_563_1.actors_["1055ui_story"]) and arg_563_1.var_.characterEffect1055ui_story then
				arg_563_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_563_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_566_1 = 0
			local var_566_2 = 0.2

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_3 = arg_563_1:GetWordFromCfg(123101140)
				local var_566_4 = arg_563_1:FormatText(var_566_3.content)

				arg_563_1.text_.text = var_566_4

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_6 = 8 <= 0 and var_566_2 or var_566_2 * (utf8.len(var_566_4) / 8)

				if (8 <= 0 and var_566_2 or var_566_2 * (utf8.len(var_566_4) / 8)) > 0 and var_566_2 < var_566_6 then
					arg_563_1.talkMaxDuration = var_566_6

					if var_566_6 + var_566_1 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_6 + var_566_1
					end
				end

				arg_563_1.text_.text = var_566_4
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101140", "story_v_out_123101.awb") ~= 0 then
					local var_566_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101140", "story_v_out_123101.awb") / 1000

					if var_566_7 + var_566_1 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_7 + var_566_1
					end

					if var_566_3.prefab_name ~= "" and arg_563_1.actors_[var_566_3.prefab_name] ~= nil then
						local var_566_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_3.prefab_name].transform, "story_v_out_123101", "123101140", "story_v_out_123101.awb")

						arg_563_1:RecordAudio("123101140", var_566_8)
						arg_563_1:RecordAudio("123101140", var_566_8)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_123101", "123101140", "story_v_out_123101.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_123101", "123101140", "story_v_out_123101.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_9 = math.max(var_566_2, arg_563_1.talkMaxDuration)

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_9 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_1) / var_566_9

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_1 + var_566_9 and arg_563_1.time_ < var_566_1 + var_566_9 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play123101141 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 123101141
		arg_567_1.duration_ = 2

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play123101142(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1055ui_story"]) and arg_567_1.var_.characterEffect1055ui_story == nil then
				arg_567_1.var_.characterEffect1055ui_story = arg_567_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_570_0 = 0.200000002980232

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1055ui_story"]) then
				if arg_567_1.var_.characterEffect1055ui_story and not isNil(arg_567_1.actors_["1055ui_story"]) then
					arg_567_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1055ui_story"]) and arg_567_1.var_.characterEffect1055ui_story then
				arg_567_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_570_2 = 0
			local var_570_3 = 0.1

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_2 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_4 = arg_567_1:GetWordFromCfg(123101141)
				local var_570_5 = arg_567_1:FormatText(var_570_4.content)

				arg_567_1.text_.text = var_570_5

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_7 = 4 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_5) / 4)

				if (4 <= 0 and var_570_3 or var_570_3 * (utf8.len(var_570_5) / 4)) > 0 and var_570_3 < var_570_7 then
					arg_567_1.talkMaxDuration = var_570_7

					if var_570_7 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_7 + var_570_2
					end
				end

				arg_567_1.text_.text = var_570_5
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101141", "story_v_out_123101.awb") ~= 0 then
					local var_570_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101141", "story_v_out_123101.awb") / 1000

					if var_570_8 + var_570_2 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_8 + var_570_2
					end

					if var_570_4.prefab_name ~= "" and arg_567_1.actors_[var_570_4.prefab_name] ~= nil then
						local var_570_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_4.prefab_name].transform, "story_v_out_123101", "123101141", "story_v_out_123101.awb")

						arg_567_1:RecordAudio("123101141", var_570_9)
						arg_567_1:RecordAudio("123101141", var_570_9)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_123101", "123101141", "story_v_out_123101.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_123101", "123101141", "story_v_out_123101.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_10 = math.max(var_570_3, arg_567_1.talkMaxDuration)

			if var_570_2 <= arg_567_1.time_ and arg_567_1.time_ < var_570_2 + var_570_10 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_2) / var_570_10

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_2 + var_570_10 and arg_567_1.time_ < var_570_2 + var_570_10 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play123101142 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 123101142
		arg_571_1.duration_ = 4.67

		local var_571_0 = {
			zh = 4.566,
			ja = 4.666
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play123101143(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1055ui_story"]) and arg_571_1.var_.characterEffect1055ui_story == nil then
				arg_571_1.var_.characterEffect1055ui_story = arg_571_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1055ui_story"]) then
				if arg_571_1.var_.characterEffect1055ui_story and not isNil(arg_571_1.actors_["1055ui_story"]) then
					arg_571_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_571_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_571_1.time_ - 0) / var_574_0)
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1055ui_story"]) and arg_571_1.var_.characterEffect1055ui_story then
				arg_571_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_571_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_574_1 = 0
			local var_574_2 = 0.325

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_1 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_3 = arg_571_1:GetWordFromCfg(123101142)
				local var_574_4 = arg_571_1:FormatText(var_574_3.content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_6 = 13 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_4) / 13)

				if (13 <= 0 and var_574_2 or var_574_2 * (utf8.len(var_574_4) / 13)) > 0 and var_574_2 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_1
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101142", "story_v_out_123101.awb") ~= 0 then
					local var_574_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101142", "story_v_out_123101.awb") / 1000

					if var_574_7 + var_574_1 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_7 + var_574_1
					end

					if var_574_3.prefab_name ~= "" and arg_571_1.actors_[var_574_3.prefab_name] ~= nil then
						local var_574_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_3.prefab_name].transform, "story_v_out_123101", "123101142", "story_v_out_123101.awb")

						arg_571_1:RecordAudio("123101142", var_574_8)
						arg_571_1:RecordAudio("123101142", var_574_8)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_123101", "123101142", "story_v_out_123101.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_123101", "123101142", "story_v_out_123101.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_9 = math.max(var_574_2, arg_571_1.talkMaxDuration)

			if var_574_1 <= arg_571_1.time_ and arg_571_1.time_ < var_574_1 + var_574_9 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_1) / var_574_9

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_1 + var_574_9 and arg_571_1.time_ < var_574_1 + var_574_9 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play123101143 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 123101143
		arg_575_1.duration_ = 9

		local var_575_0 = {
			zh = 5.433,
			ja = 9
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play123101144(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(arg_575_1.actors_["1055ui_story"]) and arg_575_1.var_.characterEffect1055ui_story == nil then
				arg_575_1.var_.characterEffect1055ui_story = arg_575_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_0 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 and not isNil(arg_575_1.actors_["1055ui_story"]) then
				if arg_575_1.var_.characterEffect1055ui_story and not isNil(arg_575_1.actors_["1055ui_story"]) then
					arg_575_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 and not isNil(arg_575_1.actors_["1055ui_story"]) and arg_575_1.var_.characterEffect1055ui_story then
				arg_575_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_578_2 = 0
			local var_578_3 = 0.575

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_2 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_4 = arg_575_1:GetWordFromCfg(123101143)
				local var_578_5 = arg_575_1:FormatText(var_578_4.content)

				arg_575_1.text_.text = var_578_5

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_7 = 23 <= 0 and var_578_3 or var_578_3 * (utf8.len(var_578_5) / 23)

				if (23 <= 0 and var_578_3 or var_578_3 * (utf8.len(var_578_5) / 23)) > 0 and var_578_3 < var_578_7 then
					arg_575_1.talkMaxDuration = var_578_7

					if var_578_7 + var_578_2 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_7 + var_578_2
					end
				end

				arg_575_1.text_.text = var_578_5
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101143", "story_v_out_123101.awb") ~= 0 then
					local var_578_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101143", "story_v_out_123101.awb") / 1000

					if var_578_8 + var_578_2 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_2
					end

					if var_578_4.prefab_name ~= "" and arg_575_1.actors_[var_578_4.prefab_name] ~= nil then
						local var_578_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_4.prefab_name].transform, "story_v_out_123101", "123101143", "story_v_out_123101.awb")

						arg_575_1:RecordAudio("123101143", var_578_9)
						arg_575_1:RecordAudio("123101143", var_578_9)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_123101", "123101143", "story_v_out_123101.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_123101", "123101143", "story_v_out_123101.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_10 = math.max(var_578_3, arg_575_1.talkMaxDuration)

			if var_578_2 <= arg_575_1.time_ and arg_575_1.time_ < var_578_2 + var_578_10 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_2) / var_578_10

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_2 + var_578_10 and arg_575_1.time_ < var_578_2 + var_578_10 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play123101144 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 123101144
		arg_579_1.duration_ = 3.1

		local var_579_0 = {
			zh = 3.1,
			ja = 1.8
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play123101145(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1055ui_story"]) and arg_579_1.var_.characterEffect1055ui_story == nil then
				arg_579_1.var_.characterEffect1055ui_story = arg_579_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_582_0 = 0.200000002980232

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1055ui_story"]) then
				if arg_579_1.var_.characterEffect1055ui_story and not isNil(arg_579_1.actors_["1055ui_story"]) then
					arg_579_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_579_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_579_1.time_ - 0) / var_582_0)
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1055ui_story"]) and arg_579_1.var_.characterEffect1055ui_story then
				arg_579_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_579_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_582_1 = 0
			local var_582_2 = 0.225

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_1 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_3 = arg_579_1:GetWordFromCfg(123101144)
				local var_582_4 = arg_579_1:FormatText(var_582_3.content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_6 = 9 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_4) / 9)

				if (9 <= 0 and var_582_2 or var_582_2 * (utf8.len(var_582_4) / 9)) > 0 and var_582_2 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_1
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101144", "story_v_out_123101.awb") ~= 0 then
					local var_582_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101144", "story_v_out_123101.awb") / 1000

					if var_582_7 + var_582_1 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_7 + var_582_1
					end

					if var_582_3.prefab_name ~= "" and arg_579_1.actors_[var_582_3.prefab_name] ~= nil then
						local var_582_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_3.prefab_name].transform, "story_v_out_123101", "123101144", "story_v_out_123101.awb")

						arg_579_1:RecordAudio("123101144", var_582_8)
						arg_579_1:RecordAudio("123101144", var_582_8)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_123101", "123101144", "story_v_out_123101.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_123101", "123101144", "story_v_out_123101.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_9 = math.max(var_582_2, arg_579_1.talkMaxDuration)

			if var_582_1 <= arg_579_1.time_ and arg_579_1.time_ < var_582_1 + var_582_9 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_1) / var_582_9

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_1 + var_582_9 and arg_579_1.time_ < var_582_1 + var_582_9 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play123101145 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 123101145
		arg_583_1.duration_ = 12.5

		local var_583_0 = {
			zh = 9.233,
			ja = 12.5
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play123101146(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(arg_583_1.actors_["1055ui_story"]) and arg_583_1.var_.characterEffect1055ui_story == nil then
				arg_583_1.var_.characterEffect1055ui_story = arg_583_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_0 = 0.200000002980232

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 and not isNil(arg_583_1.actors_["1055ui_story"]) then
				if arg_583_1.var_.characterEffect1055ui_story and not isNil(arg_583_1.actors_["1055ui_story"]) then
					arg_583_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 and not isNil(arg_583_1.actors_["1055ui_story"]) and arg_583_1.var_.characterEffect1055ui_story then
				arg_583_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_586_2 = 0
			local var_586_3 = 0.9

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_2 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_4 = arg_583_1:GetWordFromCfg(123101145)
				local var_586_5 = arg_583_1:FormatText(var_586_4.content)

				arg_583_1.text_.text = var_586_5

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_7 = 36 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_5) / 36)

				if (36 <= 0 and var_586_3 or var_586_3 * (utf8.len(var_586_5) / 36)) > 0 and var_586_3 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_2
					end
				end

				arg_583_1.text_.text = var_586_5
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101145", "story_v_out_123101.awb") ~= 0 then
					local var_586_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101145", "story_v_out_123101.awb") / 1000

					if var_586_8 + var_586_2 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_8 + var_586_2
					end

					if var_586_4.prefab_name ~= "" and arg_583_1.actors_[var_586_4.prefab_name] ~= nil then
						local var_586_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_4.prefab_name].transform, "story_v_out_123101", "123101145", "story_v_out_123101.awb")

						arg_583_1:RecordAudio("123101145", var_586_9)
						arg_583_1:RecordAudio("123101145", var_586_9)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_123101", "123101145", "story_v_out_123101.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_123101", "123101145", "story_v_out_123101.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_10 = math.max(var_586_3, arg_583_1.talkMaxDuration)

			if var_586_2 <= arg_583_1.time_ and arg_583_1.time_ < var_586_2 + var_586_10 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_2) / var_586_10

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_2 + var_586_10 and arg_583_1.time_ < var_586_2 + var_586_10 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play123101146 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 123101146
		arg_587_1.duration_ = 7.63

		local var_587_0 = {
			zh = 4.6,
			ja = 7.633
		}
		local var_587_1 = manager.audio:GetLocalizationFlag()

		if var_587_0[var_587_1] ~= nil then
			arg_587_1.duration_ = var_587_0[var_587_1]
		end

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play123101147(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_590_0 = 0
			local var_590_1 = 0.425

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, true)

				arg_587_1.leftNameTxt_.text = arg_587_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_587_1.leftNameTxt_.transform)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1.leftNameTxt_.text)
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_2 = arg_587_1:GetWordFromCfg(123101146)
				local var_590_3 = arg_587_1:FormatText(var_590_2.content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 17 <= 0 and var_590_1 or var_590_1 * (utf8.len(var_590_3) / 17)

				if (17 <= 0 and var_590_1 or var_590_1 * (utf8.len(var_590_3) / 17)) > 0 and var_590_1 < var_590_5 then
					arg_587_1.talkMaxDuration = var_590_5

					if var_590_5 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + var_590_0
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101146", "story_v_out_123101.awb") ~= 0 then
					local var_590_6 = manager.audio:GetVoiceLength("story_v_out_123101", "123101146", "story_v_out_123101.awb") / 1000

					if var_590_6 + var_590_0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_6 + var_590_0
					end

					if var_590_2.prefab_name ~= "" and arg_587_1.actors_[var_590_2.prefab_name] ~= nil then
						local var_590_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_587_1.actors_[var_590_2.prefab_name].transform, "story_v_out_123101", "123101146", "story_v_out_123101.awb")

						arg_587_1:RecordAudio("123101146", var_590_7)
						arg_587_1:RecordAudio("123101146", var_590_7)
					else
						arg_587_1:AudioAction("play", "voice", "story_v_out_123101", "123101146", "story_v_out_123101.awb")
					end

					arg_587_1:RecordHistoryTalkVoice("story_v_out_123101", "123101146", "story_v_out_123101.awb")
				end

				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_8 = math.max(var_590_1, arg_587_1.talkMaxDuration)

			if var_590_0 <= arg_587_1.time_ and arg_587_1.time_ < var_590_0 + var_590_8 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_0) / var_590_8

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_0 + var_590_8 and arg_587_1.time_ < var_590_0 + var_590_8 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play123101147 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 123101147
		arg_591_1.duration_ = 6.47

		local var_591_0 = {
			zh = 5.166,
			ja = 6.466
		}
		local var_591_1 = manager.audio:GetLocalizationFlag()

		if var_591_0[var_591_1] ~= nil then
			arg_591_1.duration_ = var_591_0[var_591_1]
		end

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play123101148(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 and not isNil(arg_591_1.actors_["1055ui_story"]) and arg_591_1.var_.characterEffect1055ui_story == nil then
				arg_591_1.var_.characterEffect1055ui_story = arg_591_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_594_0 = 0.200000002980232

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_0 and not isNil(arg_591_1.actors_["1055ui_story"]) then
				if arg_591_1.var_.characterEffect1055ui_story and not isNil(arg_591_1.actors_["1055ui_story"]) then
					arg_591_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_591_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_591_1.time_ - 0) / var_594_0)
				end
			end

			if arg_591_1.time_ >= 0 + var_594_0 and arg_591_1.time_ < 0 + var_594_0 + arg_594_0 and not isNil(arg_591_1.actors_["1055ui_story"]) and arg_591_1.var_.characterEffect1055ui_story then
				arg_591_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_591_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_594_1 = 0
			local var_594_2 = 0.525

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_1 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(123101147)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_6 = 21 <= 0 and var_594_2 or var_594_2 * (utf8.len(var_594_4) / 21)

				if (21 <= 0 and var_594_2 or var_594_2 * (utf8.len(var_594_4) / 21)) > 0 and var_594_2 < var_594_6 then
					arg_591_1.talkMaxDuration = var_594_6

					if var_594_6 + var_594_1 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_6 + var_594_1
					end
				end

				arg_591_1.text_.text = var_594_4
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101147", "story_v_out_123101.awb") ~= 0 then
					local var_594_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101147", "story_v_out_123101.awb") / 1000

					if var_594_7 + var_594_1 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_7 + var_594_1
					end

					if var_594_3.prefab_name ~= "" and arg_591_1.actors_[var_594_3.prefab_name] ~= nil then
						local var_594_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_591_1.actors_[var_594_3.prefab_name].transform, "story_v_out_123101", "123101147", "story_v_out_123101.awb")

						arg_591_1:RecordAudio("123101147", var_594_8)
						arg_591_1:RecordAudio("123101147", var_594_8)
					else
						arg_591_1:AudioAction("play", "voice", "story_v_out_123101", "123101147", "story_v_out_123101.awb")
					end

					arg_591_1:RecordHistoryTalkVoice("story_v_out_123101", "123101147", "story_v_out_123101.awb")
				end

				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_9 = math.max(var_594_2, arg_591_1.talkMaxDuration)

			if var_594_1 <= arg_591_1.time_ and arg_591_1.time_ < var_594_1 + var_594_9 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_1) / var_594_9

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_1 + var_594_9 and arg_591_1.time_ < var_594_1 + var_594_9 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play123101148 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 123101148
		arg_595_1.duration_ = 11.8

		local var_595_0 = {
			zh = 11.8,
			ja = 8.3
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play123101149(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 1.025

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_1 = arg_595_1:GetWordFromCfg(123101148)
				local var_598_2 = arg_595_1:FormatText(var_598_1.content)

				arg_595_1.text_.text = var_598_2

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 41 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 41)

				if (41 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 41)) > 0 and var_598_0 < var_598_4 then
					arg_595_1.talkMaxDuration = var_598_4

					if var_598_4 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_4 + 0
					end
				end

				arg_595_1.text_.text = var_598_2
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101148", "story_v_out_123101.awb") ~= 0 then
					local var_598_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101148", "story_v_out_123101.awb") / 1000

					if var_598_5 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + 0
					end

					if var_598_1.prefab_name ~= "" and arg_595_1.actors_[var_598_1.prefab_name] ~= nil then
						local var_598_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_1.prefab_name].transform, "story_v_out_123101", "123101148", "story_v_out_123101.awb")

						arg_595_1:RecordAudio("123101148", var_598_6)
						arg_595_1:RecordAudio("123101148", var_598_6)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_123101", "123101148", "story_v_out_123101.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_123101", "123101148", "story_v_out_123101.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_7 and arg_595_1.time_ < 0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play123101149 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 123101149
		arg_599_1.duration_ = 11.17

		local var_599_0 = {
			zh = 10.166,
			ja = 11.166
		}
		local var_599_1 = manager.audio:GetLocalizationFlag()

		if var_599_0[var_599_1] ~= nil then
			arg_599_1.duration_ = var_599_0[var_599_1]
		end

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play123101150(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 1.225

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_1 = arg_599_1:GetWordFromCfg(123101149)
				local var_602_2 = arg_599_1:FormatText(var_602_1.content)

				arg_599_1.text_.text = var_602_2

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_4 = 49 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 49)

				if (49 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_2) / 49)) > 0 and var_602_0 < var_602_4 then
					arg_599_1.talkMaxDuration = var_602_4

					if var_602_4 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_4 + 0
					end
				end

				arg_599_1.text_.text = var_602_2
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101149", "story_v_out_123101.awb") ~= 0 then
					local var_602_5 = manager.audio:GetVoiceLength("story_v_out_123101", "123101149", "story_v_out_123101.awb") / 1000

					if var_602_5 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + 0
					end

					if var_602_1.prefab_name ~= "" and arg_599_1.actors_[var_602_1.prefab_name] ~= nil then
						local var_602_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_599_1.actors_[var_602_1.prefab_name].transform, "story_v_out_123101", "123101149", "story_v_out_123101.awb")

						arg_599_1:RecordAudio("123101149", var_602_6)
						arg_599_1:RecordAudio("123101149", var_602_6)
					else
						arg_599_1:AudioAction("play", "voice", "story_v_out_123101", "123101149", "story_v_out_123101.awb")
					end

					arg_599_1:RecordHistoryTalkVoice("story_v_out_123101", "123101149", "story_v_out_123101.awb")
				end

				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_7 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_7 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_7

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_7 and arg_599_1.time_ < 0 + var_602_7 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play123101150 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 123101150
		arg_603_1.duration_ = 2

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play123101151(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["1055ui_story"]) and arg_603_1.var_.characterEffect1055ui_story == nil then
				arg_603_1.var_.characterEffect1055ui_story = arg_603_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_0 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["1055ui_story"]) then
				if arg_603_1.var_.characterEffect1055ui_story and not isNil(arg_603_1.actors_["1055ui_story"]) then
					arg_603_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["1055ui_story"]) and arg_603_1.var_.characterEffect1055ui_story then
				arg_603_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_606_2 = 0
			local var_606_3 = 0.125

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_2 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_4 = arg_603_1:GetWordFromCfg(123101150)
				local var_606_5 = arg_603_1:FormatText(var_606_4.content)

				arg_603_1.text_.text = var_606_5

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_7 = 5 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_5) / 5)

				if (5 <= 0 and var_606_3 or var_606_3 * (utf8.len(var_606_5) / 5)) > 0 and var_606_3 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_2
					end
				end

				arg_603_1.text_.text = var_606_5
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101150", "story_v_out_123101.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101150", "story_v_out_123101.awb") / 1000

					if var_606_8 + var_606_2 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_2
					end

					if var_606_4.prefab_name ~= "" and arg_603_1.actors_[var_606_4.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_4.prefab_name].transform, "story_v_out_123101", "123101150", "story_v_out_123101.awb")

						arg_603_1:RecordAudio("123101150", var_606_9)
						arg_603_1:RecordAudio("123101150", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_123101", "123101150", "story_v_out_123101.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_123101", "123101150", "story_v_out_123101.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_3, arg_603_1.talkMaxDuration)

			if var_606_2 <= arg_603_1.time_ and arg_603_1.time_ < var_606_2 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_2) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_2 + var_606_10 and arg_603_1.time_ < var_606_2 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play123101151 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 123101151
		arg_607_1.duration_ = 1.47

		local var_607_0 = {
			zh = 1.233,
			ja = 1.466
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play123101152(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["1055ui_story"]) and arg_607_1.var_.characterEffect1055ui_story == nil then
				arg_607_1.var_.characterEffect1055ui_story = arg_607_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_0 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["1055ui_story"]) then
				if arg_607_1.var_.characterEffect1055ui_story and not isNil(arg_607_1.actors_["1055ui_story"]) then
					arg_607_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_607_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_607_1.time_ - 0) / var_610_0)
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["1055ui_story"]) and arg_607_1.var_.characterEffect1055ui_story then
				arg_607_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_607_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_610_1 = 0
			local var_610_2 = 0.1

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[497].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_3 = arg_607_1:GetWordFromCfg(123101151)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_6 = 4 <= 0 and var_610_2 or var_610_2 * (utf8.len(var_610_4) / 4)

				if (4 <= 0 and var_610_2 or var_610_2 * (utf8.len(var_610_4) / 4)) > 0 and var_610_2 < var_610_6 then
					arg_607_1.talkMaxDuration = var_610_6

					if var_610_6 + var_610_1 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_6 + var_610_1
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101151", "story_v_out_123101.awb") ~= 0 then
					local var_610_7 = manager.audio:GetVoiceLength("story_v_out_123101", "123101151", "story_v_out_123101.awb") / 1000

					if var_610_7 + var_610_1 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_1
					end

					if var_610_3.prefab_name ~= "" and arg_607_1.actors_[var_610_3.prefab_name] ~= nil then
						local var_610_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_3.prefab_name].transform, "story_v_out_123101", "123101151", "story_v_out_123101.awb")

						arg_607_1:RecordAudio("123101151", var_610_8)
						arg_607_1:RecordAudio("123101151", var_610_8)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_out_123101", "123101151", "story_v_out_123101.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_out_123101", "123101151", "story_v_out_123101.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_9 = math.max(var_610_2, arg_607_1.talkMaxDuration)

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_9 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_1) / var_610_9

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_1 + var_610_9 and arg_607_1.time_ < var_610_1 + var_610_9 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play123101152 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 123101152
		arg_611_1.duration_ = 5.87

		local var_611_0 = {
			zh = 3.466,
			ja = 5.866
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play123101153(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1055ui_story"]) and arg_611_1.var_.characterEffect1055ui_story == nil then
				arg_611_1.var_.characterEffect1055ui_story = arg_611_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1055ui_story"]) then
				if arg_611_1.var_.characterEffect1055ui_story and not isNil(arg_611_1.actors_["1055ui_story"]) then
					arg_611_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1055ui_story"]) and arg_611_1.var_.characterEffect1055ui_story then
				arg_611_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action472")
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_614_2 = 0
			local var_614_3 = 0.175

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_2 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_4 = arg_611_1:GetWordFromCfg(123101152)
				local var_614_5 = arg_611_1:FormatText(var_614_4.content)

				arg_611_1.text_.text = var_614_5

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_7 = 7 <= 0 and var_614_3 or var_614_3 * (utf8.len(var_614_5) / 7)

				if (7 <= 0 and var_614_3 or var_614_3 * (utf8.len(var_614_5) / 7)) > 0 and var_614_3 < var_614_7 then
					arg_611_1.talkMaxDuration = var_614_7

					if var_614_7 + var_614_2 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_2
					end
				end

				arg_611_1.text_.text = var_614_5
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101152", "story_v_out_123101.awb") ~= 0 then
					local var_614_8 = manager.audio:GetVoiceLength("story_v_out_123101", "123101152", "story_v_out_123101.awb") / 1000

					if var_614_8 + var_614_2 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_8 + var_614_2
					end

					if var_614_4.prefab_name ~= "" and arg_611_1.actors_[var_614_4.prefab_name] ~= nil then
						local var_614_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_4.prefab_name].transform, "story_v_out_123101", "123101152", "story_v_out_123101.awb")

						arg_611_1:RecordAudio("123101152", var_614_9)
						arg_611_1:RecordAudio("123101152", var_614_9)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_out_123101", "123101152", "story_v_out_123101.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_out_123101", "123101152", "story_v_out_123101.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_10 = math.max(var_614_3, arg_611_1.talkMaxDuration)

			if var_614_2 <= arg_611_1.time_ and arg_611_1.time_ < var_614_2 + var_614_10 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_2) / var_614_10

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_2 + var_614_10 and arg_611_1.time_ < var_614_2 + var_614_10 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play123101153 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 123101153
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play123101154(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.var_.moveOldPos1055ui_story = arg_615_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_618_0 = 0.001

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_0 then
				arg_615_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_615_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_615_1.time_ - 0) / var_618_0)
				arg_615_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_615_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1055ui_story"].transform.position).z)
				arg_615_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_615_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_615_1.actors_["1055ui_story"].transform.localEulerAngles = arg_615_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_615_1.time_ >= 0 + var_618_0 and arg_615_1.time_ < 0 + var_618_0 + arg_618_0 then
				arg_615_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_615_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_615_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_615_1.actors_["1055ui_story"].transform.position).z)
				arg_615_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_615_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_615_1.actors_["1055ui_story"].transform.localEulerAngles = arg_615_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_618_1 = arg_615_1.actors_["1055ui_story"]

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 and not isNil(var_618_1) and arg_615_1.var_.characterEffect1055ui_story == nil then
				arg_615_1.var_.characterEffect1055ui_story = var_618_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_2 = 0.200000002980232

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_2 and not isNil(var_618_1) then
				if arg_615_1.var_.characterEffect1055ui_story and not isNil(var_618_1) then
					arg_615_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_615_1.time_ - 0) / var_618_2)
				end
			end

			if arg_615_1.time_ >= 0 + var_618_2 and arg_615_1.time_ < 0 + var_618_2 + arg_618_0 and not isNil(var_618_1) and arg_615_1.var_.characterEffect1055ui_story then
				arg_615_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_618_3 = 0
			local var_618_4 = 0.475

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_3 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_5 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(123101153).content)

				arg_615_1.text_.text = var_618_5

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_7 = 19 <= 0 and var_618_4 or var_618_4 * (utf8.len(var_618_5) / 19)

				if (19 <= 0 and var_618_4 or var_618_4 * (utf8.len(var_618_5) / 19)) > 0 and var_618_4 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_3 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_3
					end
				end

				arg_615_1.text_.text = var_618_5
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_8 = math.max(var_618_4, arg_615_1.talkMaxDuration)

			if var_618_3 <= arg_615_1.time_ and arg_615_1.time_ < var_618_3 + var_618_8 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_3) / var_618_8

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_3 + var_618_8 and arg_615_1.time_ < var_618_3 + var_618_8 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {
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

		arg_615_1:InitPlayNodeList()
	end,
	Play123101154 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 123101154
		arg_619_1.duration_ = 4.4

		local var_619_0 = {
			zh = 4.4,
			ja = 2.1
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play123101155(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1093ui_story = arg_619_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_622_0 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 then
				arg_619_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_619_1.time_ - 0) / var_622_0)
				arg_619_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1093ui_story"].transform.position).z)
				arg_619_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1093ui_story"].transform.localEulerAngles = arg_619_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 then
				arg_619_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_619_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1093ui_story"].transform.position).z)
				arg_619_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1093ui_story"].transform.localEulerAngles = arg_619_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_622_1 = arg_619_1.actors_["1093ui_story"]

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect1093ui_story == nil then
				arg_619_1.var_.characterEffect1093ui_story = var_622_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_2 and not isNil(var_622_1) then
				if arg_619_1.var_.characterEffect1093ui_story and not isNil(var_622_1) then
					arg_619_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_2 and arg_619_1.time_ < 0 + var_622_2 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect1093ui_story then
				arg_619_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_622_4 = 0
			local var_622_5 = 0.275

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_4 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_6 = arg_619_1:GetWordFromCfg(123101154)
				local var_622_7 = arg_619_1:FormatText(var_622_6.content)

				arg_619_1.text_.text = var_622_7

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_9 = 11 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 11)

				if (11 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 11)) > 0 and var_622_5 < var_622_9 then
					arg_619_1.talkMaxDuration = var_622_9

					if var_622_9 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_9 + var_622_4
					end
				end

				arg_619_1.text_.text = var_622_7
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101154", "story_v_out_123101.awb") ~= 0 then
					local var_622_10 = manager.audio:GetVoiceLength("story_v_out_123101", "123101154", "story_v_out_123101.awb") / 1000

					if var_622_10 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_10 + var_622_4
					end

					if var_622_6.prefab_name ~= "" and arg_619_1.actors_[var_622_6.prefab_name] ~= nil then
						local var_622_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_6.prefab_name].transform, "story_v_out_123101", "123101154", "story_v_out_123101.awb")

						arg_619_1:RecordAudio("123101154", var_622_11)
						arg_619_1:RecordAudio("123101154", var_622_11)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_out_123101", "123101154", "story_v_out_123101.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_out_123101", "123101154", "story_v_out_123101.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_12 = math.max(var_622_5, arg_619_1.talkMaxDuration)

			if var_622_4 <= arg_619_1.time_ and arg_619_1.time_ < var_622_4 + var_622_12 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_4) / var_622_12

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_4 + var_622_12 and arg_619_1.time_ < var_622_4 + var_622_12 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
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

		arg_619_1:InitPlayNodeList()
	end,
	Play123101155 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 123101155
		arg_623_1.duration_ = 12.53

		local var_623_0 = {
			zh = 9.133,
			ja = 12.533
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
			arg_623_1.auto_ = false
		end

		function arg_623_1.playNext_(arg_625_0)
			arg_623_1.onStoryFinished_()
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1055ui_story = arg_623_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_626_0 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 then
				arg_623_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1055ui_story, Vector3.New(0.7, -0.965, -6.2), (arg_623_1.time_ - 0) / var_626_0)
				arg_623_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1055ui_story"].transform.position).z)
				arg_623_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1055ui_story"].transform.localEulerAngles = arg_623_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 then
				arg_623_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0.7, -0.965, -6.2)
				arg_623_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1055ui_story"].transform.position).z)
				arg_623_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1055ui_story"].transform.localEulerAngles = arg_623_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_626_1 = arg_623_1.actors_["1055ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_1) and arg_623_1.var_.characterEffect1055ui_story == nil then
				arg_623_1.var_.characterEffect1055ui_story = var_626_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_2 and not isNil(var_626_1) then
				if arg_623_1.var_.characterEffect1055ui_story and not isNil(var_626_1) then
					arg_623_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_2 and arg_623_1.time_ < 0 + var_626_2 + arg_626_0 and not isNil(var_626_1) and arg_623_1.var_.characterEffect1055ui_story then
				arg_623_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_626_4 = arg_623_1.actors_["1093ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_4) and arg_623_1.var_.characterEffect1093ui_story == nil then
				arg_623_1.var_.characterEffect1093ui_story = var_626_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_5 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_5 and not isNil(var_626_4) then
				if arg_623_1.var_.characterEffect1093ui_story and not isNil(var_626_4) then
					arg_623_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_5)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_5 and arg_623_1.time_ < 0 + var_626_5 + arg_626_0 and not isNil(var_626_4) and arg_623_1.var_.characterEffect1093ui_story then
				arg_623_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_626_6 = 0
			local var_626_7 = 0.975

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_6 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_8 = arg_623_1:GetWordFromCfg(123101155)
				local var_626_9 = arg_623_1:FormatText(var_626_8.content)

				arg_623_1.text_.text = var_626_9

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_11 = 39 <= 0 and var_626_7 or var_626_7 * (utf8.len(var_626_9) / 39)

				if (39 <= 0 and var_626_7 or var_626_7 * (utf8.len(var_626_9) / 39)) > 0 and var_626_7 < var_626_11 then
					arg_623_1.talkMaxDuration = var_626_11

					if var_626_11 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_11 + var_626_6
					end
				end

				arg_623_1.text_.text = var_626_9
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123101", "123101155", "story_v_out_123101.awb") ~= 0 then
					local var_626_12 = manager.audio:GetVoiceLength("story_v_out_123101", "123101155", "story_v_out_123101.awb") / 1000

					if var_626_12 + var_626_6 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_12 + var_626_6
					end

					if var_626_8.prefab_name ~= "" and arg_623_1.actors_[var_626_8.prefab_name] ~= nil then
						local var_626_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_8.prefab_name].transform, "story_v_out_123101", "123101155", "story_v_out_123101.awb")

						arg_623_1:RecordAudio("123101155", var_626_13)
						arg_623_1:RecordAudio("123101155", var_626_13)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_123101", "123101155", "story_v_out_123101.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_123101", "123101155", "story_v_out_123101.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_14 = math.max(var_626_7, arg_623_1.talkMaxDuration)

			if var_626_6 <= arg_623_1.time_ and arg_623_1.time_ < var_626_6 + var_626_14 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_6) / var_626_14

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_6 + var_626_14 and arg_623_1.time_ < var_626_6 + var_626_14 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
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

		arg_623_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K05f",
		"TextureConfig/Background/K05g"
	},
	voices = {
		"story_v_out_123101.awb"
	}
}
