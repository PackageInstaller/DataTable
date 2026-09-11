return {
	Play123501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123501001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K01g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K01g")
				var_4_0.name = "K01g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K01g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K01g

				arg_1_1.bgs_.K01g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K01g" then
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

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_forest", "bgm_activity_2_4_story_forest")

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

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_cannon_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 1.575

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123501001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 63 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 63)

				if (63 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 63)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play123501002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123501002
		arg_9_1.duration_ = 8.2

		local var_9_0 = {
			zh = 4.733,
			ja = 8.2
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
				arg_9_0:Play123501003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1093ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1093ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1093ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1093ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1093ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1093ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1093ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1093ui_story == nil then
				arg_9_1.var_.characterEffect1093ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1093ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1093ui_story then
				arg_9_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.6

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(123501002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 24 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 24)

				if (24 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 24)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501002", "story_v_out_123501.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_123501", "123501002", "story_v_out_123501.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_123501", "123501002", "story_v_out_123501.awb")

						arg_9_1:RecordAudio("123501002", var_12_15)
						arg_9_1:RecordAudio("123501002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_123501", "123501002", "story_v_out_123501.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_123501", "123501002", "story_v_out_123501.awb")
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
				actorName = "1093ui_story",
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
	Play123501003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123501003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123501004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1093ui_story"]) and arg_13_1.var_.characterEffect1093ui_story == nil then
				arg_13_1.var_.characterEffect1093ui_story = arg_13_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1093ui_story"]) then
				if arg_13_1.var_.characterEffect1093ui_story and not isNil(arg_13_1.actors_["1093ui_story"]) then
					arg_13_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1093ui_story"]) and arg_13_1.var_.characterEffect1093ui_story then
				arg_13_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.525

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(123501003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 21 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 21)

				if (21 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 21)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play123501004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123501004
		arg_17_1.duration_ = 10.93

		local var_17_0 = {
			zh = 6.633,
			ja = 10.933
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
				arg_17_0:Play123501005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.825

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(123501004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 33)

				if (33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 33)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501004", "story_v_out_123501.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_123501", "123501004", "story_v_out_123501.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_123501", "123501004", "story_v_out_123501.awb")

						arg_17_1:RecordAudio("123501004", var_20_6)
						arg_17_1:RecordAudio("123501004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123501", "123501004", "story_v_out_123501.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123501", "123501004", "story_v_out_123501.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play123501005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123501005
		arg_21_1.duration_ = 5.83

		local var_21_0 = {
			zh = 4.533,
			ja = 5.833
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
				arg_21_0:Play123501006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1093ui_story = arg_21_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).z)
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles = arg_21_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_21_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).z)
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles = arg_21_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
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

				local var_24_6 = arg_21_1:GetWordFromCfg(123501005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)

				if (25 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 25)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501005", "story_v_out_123501.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501005", "story_v_out_123501.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_123501", "123501005", "story_v_out_123501.awb")

						arg_21_1:RecordAudio("123501005", var_24_11)
						arg_21_1:RecordAudio("123501005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123501", "123501005", "story_v_out_123501.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123501", "123501005", "story_v_out_123501.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play123501006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123501006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123501007(arg_25_1)
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

			local var_28_3 = manager.ui.mainCamera.transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_3.localPosition
			end

			local var_28_4 = 0.6

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				local var_28_5, var_28_6 = math.modf((arg_25_1.time_ - 0) / 0.066)

				var_28_3.localPosition = Vector3.New(var_28_6 * 0.13, var_28_6 * 0.13, var_28_6 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_7 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_7 + 0.6 and arg_25_1.time_ < var_28_7 + 0.6 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_8 = 0
			local var_28_9 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(123501006).content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 41 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_10) / 41)

				if (41 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_10) / 41)) > 0 and var_28_9 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_13 and arg_25_1.time_ < var_28_8 + var_28_13 + arg_28_0 then
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
	Play123501007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123501007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play123501008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.725

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(123501007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 29)

				if (29 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 29)) > 0 and var_32_0 < var_32_3 then
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
	Play123501008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123501008
		arg_33_1.duration_ = 4.73

		local var_33_0 = {
			zh = 2.166,
			ja = 4.733
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
				arg_33_0:Play123501009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1050ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1050ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1050ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1050ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1050ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1050ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1050ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1050ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1050ui_story == nil then
				arg_33_1.var_.characterEffect1050ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1050ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1050ui_story then
				arg_33_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_8 = arg_33_1.actors_["1093ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1093ui_story = var_36_8.localPosition
			end

			local var_36_9 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 then
				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_33_1.time_ - 0) / var_36_9)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			local var_36_10 = arg_33_1.actors_["1093ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect1093ui_story == nil then
				arg_33_1.var_.characterEffect1093ui_story = var_36_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 and not isNil(var_36_10) then
				if arg_33_1.var_.characterEffect1093ui_story and not isNil(var_36_10) then
					arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_11)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect1093ui_story then
				arg_33_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_36_12 = 0
			local var_36_13 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(123501008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 10 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 10)

				if (10 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 10)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501008", "story_v_out_123501.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_123501", "123501008", "story_v_out_123501.awb") / 1000

					if var_36_18 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_12
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_123501", "123501008", "story_v_out_123501.awb")

						arg_33_1:RecordAudio("123501008", var_36_19)
						arg_33_1:RecordAudio("123501008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_123501", "123501008", "story_v_out_123501.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_123501", "123501008", "story_v_out_123501.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_20 and arg_33_1.time_ < var_36_12 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_33_1:InitPlayNodeList()
	end,
	Play123501009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123501009
		arg_37_1.duration_ = 8.97

		local var_37_0 = {
			zh = 3.033,
			ja = 8.966
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
				arg_37_0:Play123501010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = arg_37_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(arg_37_1.actors_["1093ui_story"]) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1093ui_story"]) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_40_2 = arg_37_1.actors_["1050ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1050ui_story == nil then
				arg_37_1.var_.characterEffect1050ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect1050ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect1050ui_story then
				arg_37_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_40_4 = 0
			local var_40_5 = 0.35

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(123501009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 14 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 14)

				if (14 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 14)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501009", "story_v_out_123501.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501009", "story_v_out_123501.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_123501", "123501009", "story_v_out_123501.awb")

						arg_37_1:RecordAudio("123501009", var_40_11)
						arg_37_1:RecordAudio("123501009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123501", "123501009", "story_v_out_123501.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123501", "123501009", "story_v_out_123501.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play123501010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123501010
		arg_41_1.duration_ = 2.97

		local var_41_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_41_0:Play123501011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1050ui_story = arg_41_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).z)
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles = arg_41_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_41_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1050ui_story"].transform.position).z)
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1050ui_story"].transform.localEulerAngles = arg_41_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1050ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1050ui_story == nil then
				arg_41_1.var_.characterEffect1050ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1050ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1050ui_story then
				arg_41_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action5_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_44_4 = arg_41_1.actors_["1093ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1093ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 0.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(123501010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 11 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 11)

				if (11 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 11)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501010", "story_v_out_123501.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_123501", "123501010", "story_v_out_123501.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_123501", "123501010", "story_v_out_123501.awb")

						arg_41_1:RecordAudio("123501010", var_44_13)
						arg_41_1:RecordAudio("123501010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123501", "123501010", "story_v_out_123501.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123501", "123501010", "story_v_out_123501.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play123501011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123501011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play123501012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1050ui_story"]) and arg_45_1.var_.characterEffect1050ui_story == nil then
				arg_45_1.var_.characterEffect1050ui_story = arg_45_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1050ui_story"]) then
				if arg_45_1.var_.characterEffect1050ui_story and not isNil(arg_45_1.actors_["1050ui_story"]) then
					arg_45_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1050ui_story"]) and arg_45_1.var_.characterEffect1050ui_story then
				arg_45_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(123501011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)

				if (11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play123501012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123501012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123501013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1050ui_story = arg_49_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).z)
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles = arg_49_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1050ui_story"].transform.position).z)
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1050ui_story"].transform.localEulerAngles = arg_49_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1050ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1050ui_story == nil then
				arg_49_1.var_.characterEffect1050ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1050ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1050ui_story then
				arg_49_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_52_3 = arg_49_1.actors_["1093ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1093ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, 100, 0)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["1093ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect1093ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_6)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_52_7 = 0
			local var_52_8 = 1.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(123501012).content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 46 <= 0 and var_52_8 or var_52_8 * (utf8.len(var_52_9) / 46)

				if (46 <= 0 and var_52_8 or var_52_8 * (utf8.len(var_52_9) / 46)) > 0 and var_52_8 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_12 and arg_49_1.time_ < var_52_7 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_49_1:InitPlayNodeList()
	end,
	Play123501013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123501013
		arg_53_1.duration_ = 10.33

		local var_53_0 = {
			zh = 7.433,
			ja = 10.333
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
				arg_53_0:Play123501014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1050ui_story = arg_53_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1050ui_story"].transform.position).z)
				arg_53_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1050ui_story"].transform.localEulerAngles = arg_53_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, -1, -6.1)
				arg_53_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1050ui_story"].transform.position).z)
				arg_53_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1050ui_story"].transform.localEulerAngles = arg_53_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1050ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1050ui_story == nil then
				arg_53_1.var_.characterEffect1050ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1050ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1050ui_story then
				arg_53_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = 0
			local var_56_5 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(123501013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 42 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 42)

				if (42 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 42)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501013", "story_v_out_123501.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501013", "story_v_out_123501.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_123501", "123501013", "story_v_out_123501.awb")

						arg_53_1:RecordAudio("123501013", var_56_11)
						arg_53_1:RecordAudio("123501013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123501", "123501013", "story_v_out_123501.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123501", "123501013", "story_v_out_123501.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play123501014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123501014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play123501015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1050ui_story"]) and arg_57_1.var_.characterEffect1050ui_story == nil then
				arg_57_1.var_.characterEffect1050ui_story = arg_57_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1050ui_story"]) then
				if arg_57_1.var_.characterEffect1050ui_story and not isNil(arg_57_1.actors_["1050ui_story"]) then
					arg_57_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1050ui_story"]) and arg_57_1.var_.characterEffect1050ui_story then
				arg_57_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(123501014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 10 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 10)

				if (10 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 10)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play123501015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123501015
		arg_61_1.duration_ = 12.07

		local var_61_0 = {
			zh = 8.9,
			ja = 12.066
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123501016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1050ui_story"]) and arg_61_1.var_.characterEffect1050ui_story == nil then
				arg_61_1.var_.characterEffect1050ui_story = arg_61_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1050ui_story"]) then
				if arg_61_1.var_.characterEffect1050ui_story and not isNil(arg_61_1.actors_["1050ui_story"]) then
					arg_61_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1050ui_story"]) and arg_61_1.var_.characterEffect1050ui_story then
				arg_61_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action4_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_64_2 = 0
			local var_64_3 = 1.175

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:GetWordFromCfg(123501015)
				local var_64_5 = arg_61_1:FormatText(var_64_4.content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 47 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 47)

				if (47 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_5) / 47)) > 0 and var_64_3 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501015", "story_v_out_123501.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_123501", "123501015", "story_v_out_123501.awb") / 1000

					if var_64_8 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_2
					end

					if var_64_4.prefab_name ~= "" and arg_61_1.actors_[var_64_4.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_4.prefab_name].transform, "story_v_out_123501", "123501015", "story_v_out_123501.awb")

						arg_61_1:RecordAudio("123501015", var_64_9)
						arg_61_1:RecordAudio("123501015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_123501", "123501015", "story_v_out_123501.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_123501", "123501015", "story_v_out_123501.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_10 and arg_61_1.time_ < var_64_2 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play123501016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123501016
		arg_65_1.duration_ = 6.87

		local var_65_0 = {
			zh = 4.6,
			ja = 6.866
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
				arg_65_0:Play123501017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.625

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(123501016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 25 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 25)

				if (25 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 25)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501016", "story_v_out_123501.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_123501", "123501016", "story_v_out_123501.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_123501", "123501016", "story_v_out_123501.awb")

						arg_65_1:RecordAudio("123501016", var_68_7)
						arg_65_1:RecordAudio("123501016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123501", "123501016", "story_v_out_123501.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123501", "123501016", "story_v_out_123501.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play123501017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123501017
		arg_69_1.duration_ = 4.07

		local var_69_0 = {
			zh = 1.733,
			ja = 4.066
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
				arg_69_0:Play123501018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.225

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(123501017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 9 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 9)

				if (9 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 9)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501017", "story_v_out_123501.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_123501", "123501017", "story_v_out_123501.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_123501", "123501017", "story_v_out_123501.awb")

						arg_69_1:RecordAudio("123501017", var_72_6)
						arg_69_1:RecordAudio("123501017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_123501", "123501017", "story_v_out_123501.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_123501", "123501017", "story_v_out_123501.awb")
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
	Play123501018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123501018
		arg_73_1.duration_ = 14.6

		local var_73_0 = {
			zh = 13.5,
			ja = 14.6
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
				arg_73_0:Play123501019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1050ui_story = arg_73_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).z)
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles = arg_73_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_73_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1050ui_story"].transform.position).z)
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1050ui_story"].transform.localEulerAngles = arg_73_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1050ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1050ui_story == nil then
				arg_73_1.var_.characterEffect1050ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1050ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1050ui_story then
				arg_73_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_76_3 = arg_73_1.actors_["1093ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1093ui_story = var_76_3.localPosition
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_73_1.time_ - 0) / var_76_4)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			local var_76_5 = arg_73_1.actors_["1093ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1093ui_story == nil then
				arg_73_1.var_.characterEffect1093ui_story = var_76_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_6 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 and not isNil(var_76_5) then
				if arg_73_1.var_.characterEffect1093ui_story and not isNil(var_76_5) then
					arg_73_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and not isNil(var_76_5) and arg_73_1.var_.characterEffect1093ui_story then
				arg_73_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_8 = 0
			local var_76_9 = 1.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(123501018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 66 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 66)

				if (66 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 66)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501018", "story_v_out_123501.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_123501", "123501018", "story_v_out_123501.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_123501", "123501018", "story_v_out_123501.awb")

						arg_73_1:RecordAudio("123501018", var_76_15)
						arg_73_1:RecordAudio("123501018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123501", "123501018", "story_v_out_123501.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123501", "123501018", "story_v_out_123501.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_73_1:InitPlayNodeList()
	end,
	Play123501019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123501019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play123501020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1050ui_story = arg_77_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).z)
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles = arg_77_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1050ui_story"].transform.position).z)
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1050ui_story"].transform.localEulerAngles = arg_77_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1050ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1050ui_story == nil then
				arg_77_1.var_.characterEffect1050ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1050ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1050ui_story then
				arg_77_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_80_3 = arg_77_1.actors_["1093ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1093ui_story = var_80_3.localPosition
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_3.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_4)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_3.localPosition = Vector3.New(0, 100, 0)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			local var_80_5 = arg_77_1.actors_["1093ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.characterEffect1093ui_story and not isNil(var_80_5) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_6)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_80_7 = 0
			local var_80_8 = 0.65

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_9 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(123501019).content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 26 <= 0 and var_80_8 or var_80_8 * (utf8.len(var_80_9) / 26)

				if (26 <= 0 and var_80_8 or var_80_8 * (utf8.len(var_80_9) / 26)) > 0 and var_80_8 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_7 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_7
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_8, arg_77_1.talkMaxDuration)

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_7) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_7 + var_80_12 and arg_77_1.time_ < var_80_7 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_77_1:InitPlayNodeList()
	end,
	Play123501020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123501020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123501021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.725

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(123501020).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 29 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 29)

				if (29 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 29)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123501021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123501021
		arg_85_1.duration_ = 4.63

		local var_85_0 = {
			zh = 4.633,
			ja = 4.3
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
				arg_85_0:Play123501022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1050ui_story = arg_85_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1050ui_story"].transform.position).z)
				arg_85_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1050ui_story"].transform.localEulerAngles = arg_85_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_85_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1050ui_story"].transform.position).z)
				arg_85_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1050ui_story"].transform.localEulerAngles = arg_85_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1050ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1050ui_story == nil then
				arg_85_1.var_.characterEffect1050ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1050ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1050ui_story then
				arg_85_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = arg_85_1.actors_["1093ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1093ui_story = var_88_4.localPosition
			end

			local var_88_5 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 then
				var_88_4.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_85_1.time_ - 0) / var_88_5)
				var_88_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_4.position).x, (manager.ui.mainCamera.transform.position - var_88_4.position).y, (manager.ui.mainCamera.transform.position - var_88_4.position).z)
				var_88_4.localEulerAngles.z = 0
				var_88_4.localEulerAngles.x = 0
				var_88_4.localEulerAngles = var_88_4.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 then
				var_88_4.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_88_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_4.position).x, (manager.ui.mainCamera.transform.position - var_88_4.position).y, (manager.ui.mainCamera.transform.position - var_88_4.position).z)
				var_88_4.localEulerAngles.z = 0
				var_88_4.localEulerAngles.x = 0
				var_88_4.localEulerAngles = var_88_4.localEulerAngles
			end

			local var_88_6 = arg_85_1.actors_["1093ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect1093ui_story == nil then
				arg_85_1.var_.characterEffect1093ui_story = var_88_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_7 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 and not isNil(var_88_6) then
				if arg_85_1.var_.characterEffect1093ui_story and not isNil(var_88_6) then
					arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_7)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 and not isNil(var_88_6) and arg_85_1.var_.characterEffect1093ui_story then
				arg_85_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_88_8 = 0
			local var_88_9 = 0.45

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(123501021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 18 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 18)

				if (18 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 18)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501021", "story_v_out_123501.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_123501", "123501021", "story_v_out_123501.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_123501", "123501021", "story_v_out_123501.awb")

						arg_85_1:RecordAudio("123501021", var_88_15)
						arg_85_1:RecordAudio("123501021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123501", "123501021", "story_v_out_123501.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123501", "123501021", "story_v_out_123501.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_85_1:InitPlayNodeList()
	end,
	Play123501022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123501022
		arg_89_1.duration_ = 5.83

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play123501023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1093ui_story"]) and arg_89_1.var_.characterEffect1093ui_story == nil then
				arg_89_1.var_.characterEffect1093ui_story = arg_89_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1093ui_story"]) then
				if arg_89_1.var_.characterEffect1093ui_story and not isNil(arg_89_1.actors_["1093ui_story"]) then
					arg_89_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1093ui_story"]) and arg_89_1.var_.characterEffect1093ui_story then
				arg_89_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = arg_89_1.actors_["1050ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1050ui_story == nil then
				arg_89_1.var_.characterEffect1050ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect1050ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect1050ui_story then
				arg_89_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_92_4 = 0
			local var_92_5 = 0.7

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(123501022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 28 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 28)

				if (28 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 28)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501022", "story_v_out_123501.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501022", "story_v_out_123501.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_123501", "123501022", "story_v_out_123501.awb")

						arg_89_1:RecordAudio("123501022", var_92_11)
						arg_89_1:RecordAudio("123501022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_123501", "123501022", "story_v_out_123501.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_123501", "123501022", "story_v_out_123501.awb")
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

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play123501023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123501023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play123501024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1093ui_story"]) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = arg_93_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1093ui_story"]) then
				if arg_93_1.var_.characterEffect1093ui_story and not isNil(arg_93_1.actors_["1093ui_story"]) then
					arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1093ui_story"]) and arg_93_1.var_.characterEffect1093ui_story then
				arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.425

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(123501023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 17 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 17)

				if (17 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 17)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play123501024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123501024
		arg_97_1.duration_ = 6.1

		local var_97_0 = {
			zh = 6.1,
			ja = 4.266
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
				arg_97_0:Play123501025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1093ui_story = arg_97_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1093ui_story"].transform.position).z)
				arg_97_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1093ui_story"].transform.localEulerAngles = arg_97_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_97_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1093ui_story"].transform.position).z)
				arg_97_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1093ui_story"].transform.localEulerAngles = arg_97_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1093ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1093ui_story == nil then
				arg_97_1.var_.characterEffect1093ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1093ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1093ui_story then
				arg_97_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action426")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.7

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(123501024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 28 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 28)

				if (28 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 28)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501024", "story_v_out_123501.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501024", "story_v_out_123501.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_123501", "123501024", "story_v_out_123501.awb")

						arg_97_1:RecordAudio("123501024", var_100_11)
						arg_97_1:RecordAudio("123501024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123501", "123501024", "story_v_out_123501.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123501", "123501024", "story_v_out_123501.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play123501025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123501025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play123501026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) and arg_101_1.var_.characterEffect1093ui_story == nil then
				arg_101_1.var_.characterEffect1093ui_story = arg_101_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) then
				if arg_101_1.var_.characterEffect1093ui_story and not isNil(arg_101_1.actors_["1093ui_story"]) then
					arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1093ui_story"]) and arg_101_1.var_.characterEffect1093ui_story then
				arg_101_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.15

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(123501025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 6 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 6)

				if (6 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 6)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play123501026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123501026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play123501027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.825

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
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

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(123501026).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 33 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 33)

				if (33 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 33)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123501027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123501027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play123501028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1050ui_story = arg_109_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1050ui_story"].transform.position).z)
				arg_109_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1050ui_story"].transform.localEulerAngles = arg_109_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1050ui_story"].transform.position).z)
				arg_109_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1050ui_story"].transform.localEulerAngles = arg_109_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1050ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1050ui_story == nil then
				arg_109_1.var_.characterEffect1050ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1050ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1050ui_story then
				arg_109_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_112_3 = arg_109_1.actors_["1093ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1093ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0, 100, 0)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["1093ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect1093ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_6)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_112_7 = 0
			local var_112_8 = 1.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_9 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(123501027).content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 48 <= 0 and var_112_8 or var_112_8 * (utf8.len(var_112_9) / 48)

				if (48 <= 0 and var_112_8 or var_112_8 * (utf8.len(var_112_9) / 48)) > 0 and var_112_8 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_7
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_8, arg_109_1.talkMaxDuration)

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_7) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_7 + var_112_12 and arg_109_1.time_ < var_112_7 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_109_1:InitPlayNodeList()
	end,
	Play123501028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123501028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123501029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_statue", "")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:AudioAction("stop", "effect", "se_story_123_02", "se_story_123_02_cannon_loop", "")
			end

			local var_116_2 = 0
			local var_116_3 = 0.95

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(123501028).content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 38 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 38)

				if (38 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 38)) > 0 and var_116_3 < var_116_6 then
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
	Play123501029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123501029
		arg_117_1.duration_ = 6.6

		local var_117_0 = {
			zh = 2.866,
			ja = 6.6
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
				arg_117_0:Play123501030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1050ui_story = arg_117_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1050ui_story"].transform.position).z)
				arg_117_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1050ui_story"].transform.localEulerAngles = arg_117_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_117_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1050ui_story"].transform.position).z)
				arg_117_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1050ui_story"].transform.localEulerAngles = arg_117_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1050ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1050ui_story == nil then
				arg_117_1.var_.characterEffect1050ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1050ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1050ui_story then
				arg_117_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_120_3 = arg_117_1.actors_["1093ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1093ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0.7, -1.11, -5.88)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			local var_120_5 = arg_117_1.actors_["1093ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1093ui_story == nil then
				arg_117_1.var_.characterEffect1093ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.characterEffect1093ui_story and not isNil(var_120_5) then
					arg_117_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1093ui_story then
				arg_117_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_8 = 0
			local var_120_9 = 0.25

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(123501029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 10 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 10)

				if (10 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 10)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501029", "story_v_out_123501.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_out_123501", "123501029", "story_v_out_123501.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_out_123501", "123501029", "story_v_out_123501.awb")

						arg_117_1:RecordAudio("123501029", var_120_15)
						arg_117_1:RecordAudio("123501029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_123501", "123501029", "story_v_out_123501.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_123501", "123501029", "story_v_out_123501.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_117_1:InitPlayNodeList()
	end,
	Play123501030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 123501030
		arg_121_1.duration_ = 3.3

		local var_121_0 = {
			zh = 1.633,
			ja = 3.3
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
				arg_121_0:Play123501031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1050ui_story = arg_121_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1050ui_story"].transform.position).z)
				arg_121_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1050ui_story"].transform.localEulerAngles = arg_121_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_121_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1050ui_story"].transform.position).z)
				arg_121_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1050ui_story"].transform.localEulerAngles = arg_121_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1050ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1050ui_story == nil then
				arg_121_1.var_.characterEffect1050ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1050ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1050ui_story then
				arg_121_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = arg_121_1.actors_["1093ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1093ui_story == nil then
				arg_121_1.var_.characterEffect1093ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect1093ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1093ui_story then
				arg_121_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_124_6 = 0
			local var_124_7 = 0.275

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(123501030)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 11 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 11)

				if (11 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 11)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501030", "story_v_out_123501.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_123501", "123501030", "story_v_out_123501.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_123501", "123501030", "story_v_out_123501.awb")

						arg_121_1:RecordAudio("123501030", var_124_13)
						arg_121_1:RecordAudio("123501030", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_123501", "123501030", "story_v_out_123501.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_123501", "123501030", "story_v_out_123501.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play123501031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 123501031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play123501032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1050ui_story"]) and arg_125_1.var_.characterEffect1050ui_story == nil then
				arg_125_1.var_.characterEffect1050ui_story = arg_125_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1050ui_story"]) then
				if arg_125_1.var_.characterEffect1050ui_story and not isNil(arg_125_1.actors_["1050ui_story"]) then
					arg_125_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1050ui_story"]) and arg_125_1.var_.characterEffect1050ui_story then
				arg_125_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_signal", "")
			end

			local var_128_2 = 0
			local var_128_3 = 0.8

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(123501031).content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_6 = 32 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_4) / 32)

				if (32 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_4) / 32)) > 0 and var_128_3 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_7 and arg_125_1.time_ < var_128_2 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play123501032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 123501032
		arg_129_1.duration_ = 4.13

		local var_129_0 = {
			zh = 3.566,
			ja = 4.133
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
				arg_129_0:Play123501033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1093ui_story = arg_129_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1093ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story == nil then
				arg_129_1.var_.characterEffect1093ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1093ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story then
				arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.425

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(123501032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 17 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 17)

				if (17 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 17)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501032", "story_v_out_123501.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501032", "story_v_out_123501.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_123501", "123501032", "story_v_out_123501.awb")

						arg_129_1:RecordAudio("123501032", var_132_11)
						arg_129_1:RecordAudio("123501032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_123501", "123501032", "story_v_out_123501.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_123501", "123501032", "story_v_out_123501.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play123501033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 123501033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play123501034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) and arg_133_1.var_.characterEffect1093ui_story == nil then
				arg_133_1.var_.characterEffect1093ui_story = arg_133_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) then
				if arg_133_1.var_.characterEffect1093ui_story and not isNil(arg_133_1.actors_["1093ui_story"]) then
					arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1093ui_story"]) and arg_133_1.var_.characterEffect1093ui_story then
				arg_133_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(123501033).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 23 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 23)

				if (23 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 23)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play123501034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 123501034
		arg_137_1.duration_ = 4.83

		local var_137_0 = {
			zh = 4.566,
			ja = 4.833
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
				arg_137_0:Play123501035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) and arg_137_1.var_.characterEffect1093ui_story == nil then
				arg_137_1.var_.characterEffect1093ui_story = arg_137_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) then
				if arg_137_1.var_.characterEffect1093ui_story and not isNil(arg_137_1.actors_["1093ui_story"]) then
					arg_137_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1093ui_story"]) and arg_137_1.var_.characterEffect1093ui_story then
				arg_137_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_2 = 0
			local var_140_3 = 0.5

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(123501034)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 20 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 20)

				if (20 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_5) / 20)) > 0 and var_140_3 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501034", "story_v_out_123501.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_123501", "123501034", "story_v_out_123501.awb") / 1000

					if var_140_8 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_2
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_123501", "123501034", "story_v_out_123501.awb")

						arg_137_1:RecordAudio("123501034", var_140_9)
						arg_137_1:RecordAudio("123501034", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_123501", "123501034", "story_v_out_123501.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_123501", "123501034", "story_v_out_123501.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_10 and arg_137_1.time_ < var_140_2 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play123501035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 123501035
		arg_141_1.duration_ = 2.6

		local var_141_0 = {
			zh = 2.433,
			ja = 2.6
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
				arg_141_0:Play123501036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1050ui_story = arg_141_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1050ui_story"].transform.position).z)
				arg_141_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1050ui_story"].transform.localEulerAngles = arg_141_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6.1)
				arg_141_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1050ui_story"].transform.position).z)
				arg_141_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1050ui_story"].transform.localEulerAngles = arg_141_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1050ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1050ui_story == nil then
				arg_141_1.var_.characterEffect1050ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1050ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1050ui_story then
				arg_141_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_4 = arg_141_1.actors_["1093ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1093ui_story == nil then
				arg_141_1.var_.characterEffect1093ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect1093ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect1093ui_story then
				arg_141_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_144_6 = 0
			local var_144_7 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(123501035)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 14 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 14)

				if (14 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 14)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501035", "story_v_out_123501.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_123501", "123501035", "story_v_out_123501.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_123501", "123501035", "story_v_out_123501.awb")

						arg_141_1:RecordAudio("123501035", var_144_13)
						arg_141_1:RecordAudio("123501035", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_123501", "123501035", "story_v_out_123501.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_123501", "123501035", "story_v_out_123501.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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
	Play123501036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 123501036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play123501037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1050ui_story"]) and arg_145_1.var_.characterEffect1050ui_story == nil then
				arg_145_1.var_.characterEffect1050ui_story = arg_145_1.actors_["1050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1050ui_story"]) then
				if arg_145_1.var_.characterEffect1050ui_story and not isNil(arg_145_1.actors_["1050ui_story"]) then
					arg_145_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1050ui_story"]) and arg_145_1.var_.characterEffect1050ui_story then
				arg_145_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 1.675

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(123501036).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 67 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 67)

				if (67 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 67)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play123501037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 123501037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play123501038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1050ui_story = arg_149_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1050ui_story"].transform.position).z)
				arg_149_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1050ui_story"].transform.localEulerAngles = arg_149_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1050ui_story"].transform.position).z)
				arg_149_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1050ui_story"].transform.localEulerAngles = arg_149_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1050ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1050ui_story == nil then
				arg_149_1.var_.characterEffect1050ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1050ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_2)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1050ui_story then
				arg_149_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_152_3 = arg_149_1.actors_["1093ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1093ui_story = var_152_3.localPosition
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_3.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_4)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = Vector3.New(0, 100, 0)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			local var_152_5 = arg_149_1.actors_["1093ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1093ui_story == nil then
				arg_149_1.var_.characterEffect1093ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.characterEffect1093ui_story and not isNil(var_152_5) then
					arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_6)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1093ui_story then
				arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_152_7 = 0
			local var_152_8 = 0.9

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(123501037).content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 36 <= 0 and var_152_8 or var_152_8 * (utf8.len(var_152_9) / 36)

				if (36 <= 0 and var_152_8 or var_152_8 * (utf8.len(var_152_9) / 36)) > 0 and var_152_8 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_7 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_7
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_8, arg_149_1.talkMaxDuration)

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_7) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_7 + var_152_12 and arg_149_1.time_ < var_152_7 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
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

		arg_149_1:InitPlayNodeList()
	end,
	Play123501038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 123501038
		arg_153_1.duration_ = 10.93

		local var_153_0 = {
			zh = 6.966,
			ja = 10.933
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
				arg_153_0:Play123501039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_156_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_153_1.stage_.transform)

				var_156_0.name = "1029ui_story"
				var_156_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1029ui_story"] = var_156_0

				local var_156_1 = var_156_0:GetComponentInChildren(typeof(CharacterEffect))

				var_156_1.enabled = true

				local var_156_2 = GameObjectTools.GetOrAddComponent(var_156_0, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(false)
				end

				arg_153_1:ShowWeapon(var_156_1.transform, false)

				arg_153_1.var_["1029ui_story" .. "Animator"] = var_156_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_153_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_153_1.var_["1029ui_story" .. "LipSync"] = var_156_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_156_3 = arg_153_1.actors_["1029ui_story"].transform

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= 2 + arg_156_0 then
				arg_153_1.var_.moveOldPos1029ui_story = var_156_3.localPosition
			end

			local var_156_4 = 0.001

			if 2 <= arg_153_1.time_ and arg_153_1.time_ < 2 + var_156_4 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_153_1.time_ - 2) / var_156_4)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			if arg_153_1.time_ >= 2 + var_156_4 and arg_153_1.time_ < 2 + var_156_4 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, -1.09, -6.2)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			local var_156_5 = arg_153_1.actors_["1029ui_story"]

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= 2 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1029ui_story == nil then
				arg_153_1.var_.characterEffect1029ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if 2 <= arg_153_1.time_ and arg_153_1.time_ < 2 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.characterEffect1029ui_story and not isNil(var_156_5) then
					arg_153_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 2 + var_156_6 and arg_153_1.time_ < 2 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1029ui_story then
				arg_153_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= 2 + arg_156_0 then
				arg_153_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= 2 + arg_156_0 then
				arg_153_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_8 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_9 = 2

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_9 then
				local var_156_10 = Color.New(0, 0, 0)

				var_156_10.a = Mathf.Lerp(0, 1, (arg_153_1.time_ - var_156_8) / var_156_9)
				arg_153_1.mask_.color = var_156_10
			end

			if arg_153_1.time_ >= var_156_8 + var_156_9 and arg_153_1.time_ < var_156_8 + var_156_9 + arg_156_0 then
				local var_156_11 = Color.New(0, 0, 0)

				var_156_11.a = 1
				arg_153_1.mask_.color = var_156_11
			end

			local var_156_12 = 2

			if 2 < arg_153_1.time_ and arg_153_1.time_ <= var_156_12 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_13 = 2

			if var_156_12 <= arg_153_1.time_ and arg_153_1.time_ < var_156_12 + var_156_13 then
				local var_156_14 = Color.New(0, 0, 0)

				var_156_14.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_12) / var_156_13)
				arg_153_1.mask_.color = var_156_14
			end

			if arg_153_1.time_ >= var_156_12 + var_156_13 and arg_153_1.time_ < var_156_12 + var_156_13 + arg_156_0 then
				local var_156_15 = Color.New(0, 0, 0)

				arg_153_1.mask_.enabled = false
				var_156_15.a = 0
				arg_153_1.mask_.color = var_156_15
			end

			local var_156_16 = 2

			arg_153_1.isInRecall_ = false

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.screenFilterGo_:SetActive(true)

				arg_153_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_156_0, iter_156_1 in pairs(arg_153_1.actors_) do
					for iter_156_2, iter_156_3 in ipairs((iter_156_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_156_3.color = iter_156_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_156_17 = 0.1

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_17 then
				arg_153_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_153_1.time_ - var_156_16) / var_156_17)
			end

			if arg_153_1.time_ >= var_156_16 + var_156_17 and arg_153_1.time_ < var_156_16 + var_156_17 + arg_156_0 then
				arg_153_1.screenFilterEffect_.weight = 1
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_18 = 2.5
			local var_156_19 = 0.375

			if 2.5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_18 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_20 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_20:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_21 = arg_153_1:GetWordFromCfg(123501038)
				local var_156_22 = arg_153_1:FormatText(var_156_21.content)

				arg_153_1.text_.text = var_156_22

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_24 = 15 <= 0 and var_156_19 or var_156_19 * (utf8.len(var_156_22) / 15)

				if (15 <= 0 and var_156_19 or var_156_19 * (utf8.len(var_156_22) / 15)) > 0 and var_156_19 < var_156_24 then
					arg_153_1.talkMaxDuration = var_156_24
					var_156_18 = var_156_18 + 0.3

					if var_156_24 + var_156_18 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_24 + var_156_18
					end
				end

				arg_153_1.text_.text = var_156_22
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501038", "story_v_out_123501.awb") ~= 0 then
					local var_156_25 = manager.audio:GetVoiceLength("story_v_out_123501", "123501038", "story_v_out_123501.awb") / 1000

					if var_156_25 + var_156_18 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_25 + var_156_18
					end

					if var_156_21.prefab_name ~= "" and arg_153_1.actors_[var_156_21.prefab_name] ~= nil then
						local var_156_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_21.prefab_name].transform, "story_v_out_123501", "123501038", "story_v_out_123501.awb")

						arg_153_1:RecordAudio("123501038", var_156_26)
						arg_153_1:RecordAudio("123501038", var_156_26)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_123501", "123501038", "story_v_out_123501.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_123501", "123501038", "story_v_out_123501.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_27 = var_156_18 + 0.3
			local var_156_28 = math.max(var_156_19, arg_153_1.talkMaxDuration)

			if var_156_18 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_27 + var_156_28 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_27) / var_156_28

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_27 + var_156_28 and arg_153_1.time_ < var_156_27 + var_156_28 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play123501039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 123501039
		arg_159_1.duration_ = 3.37

		local var_159_0 = {
			zh = 2.933,
			ja = 3.366
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
				arg_159_0:Play123501040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1029ui_story = arg_159_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1029ui_story"].transform.position).z)
				arg_159_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1029ui_story"].transform.localEulerAngles = arg_159_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1029ui_story"].transform.position).z)
				arg_159_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1029ui_story"].transform.localEulerAngles = arg_159_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1029ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1029ui_story == nil then
				arg_159_1.var_.characterEffect1029ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1029ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_2)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1029ui_story then
				arg_159_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_162_3 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_4 = 2

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_4 then
				local var_162_5 = Color.New(1, 1, 1)

				var_162_5.a = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_3) / var_162_4)
				arg_159_1.mask_.color = var_162_5
			end

			if arg_159_1.time_ >= var_162_3 + var_162_4 and arg_159_1.time_ < var_162_3 + var_162_4 + arg_162_0 then
				local var_162_6 = Color.New(1, 1, 1)

				arg_159_1.mask_.enabled = false
				var_162_6.a = 0
				arg_159_1.mask_.color = var_162_6
			end

			local var_162_7 = 0

			arg_159_1.isInRecall_ = false

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.screenFilterGo_:SetActive(false)

				for iter_162_0, iter_162_1 in pairs(arg_159_1.actors_) do
					for iter_162_2, iter_162_3 in ipairs((iter_162_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_162_3.color = iter_162_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_162_8 = 0.1

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 then
				arg_159_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_7) / var_162_8)
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 then
				arg_159_1.screenFilterEffect_.weight = 0
			end

			local var_162_9 = arg_159_1.actors_["1093ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1093ui_story = var_162_9.localPosition
			end

			local var_162_10 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_10 then
				var_162_9.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_159_1.time_ - 0) / var_162_10)
				var_162_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_9.position).x, (manager.ui.mainCamera.transform.position - var_162_9.position).y, (manager.ui.mainCamera.transform.position - var_162_9.position).z)
				var_162_9.localEulerAngles.z = 0
				var_162_9.localEulerAngles.x = 0
				var_162_9.localEulerAngles = var_162_9.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_10 and arg_159_1.time_ < 0 + var_162_10 + arg_162_0 then
				var_162_9.localPosition = Vector3.New(0, -1.11, -5.88)
				var_162_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_9.position).x, (manager.ui.mainCamera.transform.position - var_162_9.position).y, (manager.ui.mainCamera.transform.position - var_162_9.position).z)
				var_162_9.localEulerAngles.z = 0
				var_162_9.localEulerAngles.x = 0
				var_162_9.localEulerAngles = var_162_9.localEulerAngles
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			local var_162_11 = arg_159_1.actors_["1093ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect1093ui_story == nil then
				arg_159_1.var_.characterEffect1093ui_story = var_162_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_12 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_12 and not isNil(var_162_11) then
				if arg_159_1.var_.characterEffect1093ui_story and not isNil(var_162_11) then
					arg_159_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_12 and arg_159_1.time_ < 0 + var_162_12 + arg_162_0 and not isNil(var_162_11) and arg_159_1.var_.characterEffect1093ui_story then
				arg_159_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_14 = 0.8
			local var_162_15 = 0.275

			if 0.8 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_16 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_16:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_17 = arg_159_1:GetWordFromCfg(123501039)
				local var_162_18 = arg_159_1:FormatText(var_162_17.content)

				arg_159_1.text_.text = var_162_18

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 11 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_18) / 11)

				if (11 <= 0 and var_162_15 or var_162_15 * (utf8.len(var_162_18) / 11)) > 0 and var_162_15 < var_162_20 then
					arg_159_1.talkMaxDuration = var_162_20
					var_162_14 = var_162_14 + 0.3

					if var_162_20 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_20 + var_162_14
					end
				end

				arg_159_1.text_.text = var_162_18
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501039", "story_v_out_123501.awb") ~= 0 then
					local var_162_21 = manager.audio:GetVoiceLength("story_v_out_123501", "123501039", "story_v_out_123501.awb") / 1000

					if var_162_21 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_21 + var_162_14
					end

					if var_162_17.prefab_name ~= "" and arg_159_1.actors_[var_162_17.prefab_name] ~= nil then
						local var_162_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_17.prefab_name].transform, "story_v_out_123501", "123501039", "story_v_out_123501.awb")

						arg_159_1:RecordAudio("123501039", var_162_22)
						arg_159_1:RecordAudio("123501039", var_162_22)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_123501", "123501039", "story_v_out_123501.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_123501", "123501039", "story_v_out_123501.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_23 = var_162_14 + 0.3
			local var_162_24 = math.max(var_162_15, arg_159_1.talkMaxDuration)

			if var_162_14 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_23 + var_162_24 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_23) / var_162_24

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_23 + var_162_24 and arg_159_1.time_ < var_162_23 + var_162_24 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play123501040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 123501040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play123501041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) and arg_165_1.var_.characterEffect1093ui_story == nil then
				arg_165_1.var_.characterEffect1093ui_story = arg_165_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) then
				if arg_165_1.var_.characterEffect1093ui_story and not isNil(arg_165_1.actors_["1093ui_story"]) then
					arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1093ui_story"]) and arg_165_1.var_.characterEffect1093ui_story then
				arg_165_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.725

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(123501040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 29 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 29)

				if (29 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 29)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play123501041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 123501041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play123501042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.725

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(123501041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 29 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 29)

				if (29 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 29)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play123501042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 123501042
		arg_173_1.duration_ = 3.7

		local var_173_0 = {
			zh = 3.7,
			ja = 2.8
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
				arg_173_0:Play123501043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1093ui_story = arg_173_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1093ui_story"].transform.position).z)
				arg_173_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1093ui_story"].transform.localEulerAngles = arg_173_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_173_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1093ui_story"].transform.position).z)
				arg_173_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1093ui_story"].transform.localEulerAngles = arg_173_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1093ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1093ui_story == nil then
				arg_173_1.var_.characterEffect1093ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1093ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1093ui_story then
				arg_173_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action446")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(123501042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 14 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 14)

				if (14 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 14)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501042", "story_v_out_123501.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_123501", "123501042", "story_v_out_123501.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_123501", "123501042", "story_v_out_123501.awb")

						arg_173_1:RecordAudio("123501042", var_176_11)
						arg_173_1:RecordAudio("123501042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_123501", "123501042", "story_v_out_123501.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_123501", "123501042", "story_v_out_123501.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play123501043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 123501043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play123501044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1093ui_story"]) and arg_177_1.var_.characterEffect1093ui_story == nil then
				arg_177_1.var_.characterEffect1093ui_story = arg_177_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1093ui_story"]) then
				if arg_177_1.var_.characterEffect1093ui_story and not isNil(arg_177_1.actors_["1093ui_story"]) then
					arg_177_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1093ui_story"]) and arg_177_1.var_.characterEffect1093ui_story then
				arg_177_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.75

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

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(123501043).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 30 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 30)

				if (30 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 30)) > 0 and var_180_2 < var_180_5 then
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
	Play123501044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 123501044
		arg_181_1.duration_ = 7.87

		local var_181_0 = {
			zh = 4.966,
			ja = 7.866
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
				arg_181_0:Play123501045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1093ui_story = arg_181_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).z)
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles = arg_181_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1093ui_story"].transform.position).z)
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1093ui_story"].transform.localEulerAngles = arg_181_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1093ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1093ui_story == nil then
				arg_181_1.var_.characterEffect1093ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1093ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1093ui_story then
				arg_181_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_184_3 = arg_181_1.actors_["1050ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1050ui_story = var_184_3.localPosition
			end

			local var_184_4 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				var_184_3.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_181_1.time_ - 0) / var_184_4)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				var_184_3.localPosition = Vector3.New(0, -1, -6.1)
				var_184_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_3.position).x, (manager.ui.mainCamera.transform.position - var_184_3.position).y, (manager.ui.mainCamera.transform.position - var_184_3.position).z)
				var_184_3.localEulerAngles.z = 0
				var_184_3.localEulerAngles.x = 0
				var_184_3.localEulerAngles = var_184_3.localEulerAngles
			end

			local var_184_5 = arg_181_1.actors_["1050ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1050ui_story == nil then
				arg_181_1.var_.characterEffect1050ui_story = var_184_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_6 and not isNil(var_184_5) then
				if arg_181_1.var_.characterEffect1050ui_story and not isNil(var_184_5) then
					arg_181_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_6 and arg_181_1.time_ < 0 + var_184_6 + arg_184_0 and not isNil(var_184_5) and arg_181_1.var_.characterEffect1050ui_story then
				arg_181_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_184_8 = 0
			local var_184_9 = 0.675

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(123501044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 27 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 27)

				if (27 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 27)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123501", "123501044", "story_v_out_123501.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_123501", "123501044", "story_v_out_123501.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_123501", "123501044", "story_v_out_123501.awb")

						arg_181_1:RecordAudio("123501044", var_184_15)
						arg_181_1:RecordAudio("123501044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_123501", "123501044", "story_v_out_123501.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_123501", "123501044", "story_v_out_123501.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play123501045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 123501045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play123501046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1050ui_story = arg_185_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1050ui_story"].transform.position).z)
				arg_185_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1050ui_story"].transform.localEulerAngles = arg_185_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1050ui_story"].transform.position).z)
				arg_185_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1050ui_story"].transform.localEulerAngles = arg_185_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1050ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1050ui_story == nil then
				arg_185_1.var_.characterEffect1050ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1050ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_2)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1050ui_story then
				arg_185_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_188_3 = 0
			local var_188_4 = 0.65

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_5 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(123501045).content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 26 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 26)

				if (26 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_5) / 26)) > 0 and var_188_4 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_8 and arg_185_1.time_ < var_188_3 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play123501046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 123501046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
			arg_189_1.auto_ = false
		end

		function arg_189_1.playNext_(arg_191_0)
			arg_189_1.onStoryFinished_()
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.275

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(123501046).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 11 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 11)

				if (11 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 11)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K01g"
	},
	voices = {
		"story_v_out_123501.awb"
	}
}
