return {
	Play112211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112211001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play112211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H02a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02a")
				var_4_0.name = "H02a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H02a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H02a

				arg_1_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02a" then
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
				local var_4_6 = Color.New(0.0471698, 0.04650231, 0.04650231)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0.0471698, 0.04650231, 0.04650231)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.925

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(112211001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 37 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 37)

				if (37 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 37)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play112211002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 112211002
		arg_8_1.duration_ = 5.5

		local var_8_0 = {
			ja = 4.5,
			ko = 4.466,
			zh = 4.866,
			en = 5.5
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play112211003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1039ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1039ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1039ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1039ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1039ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1039ui_story = var_11_3.localPosition

				arg_8_1:ShowWeapon(arg_8_1.var_["1039ui_story" .. "Animator"].transform, false)
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1039ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1039ui_story == nil then
				arg_8_1.var_.characterEffect1039ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1039ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1039ui_story then
				arg_8_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_11_8 = 0
			local var_11_9 = 0.475

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(112211002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 19 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 19)

				if (19 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 19)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211002", "story_v_out_112211.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211002", "story_v_out_112211.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_112211", "112211002", "story_v_out_112211.awb")

						arg_8_1:RecordAudio("112211002", var_11_15)
						arg_8_1:RecordAudio("112211002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_112211", "112211002", "story_v_out_112211.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_112211", "112211002", "story_v_out_112211.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play112211003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 112211003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play112211004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1039ui_story"]) and arg_12_1.var_.characterEffect1039ui_story == nil then
				arg_12_1.var_.characterEffect1039ui_story = arg_12_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1039ui_story"]) then
				if arg_12_1.var_.characterEffect1039ui_story and not isNil(arg_12_1.actors_["1039ui_story"]) then
					arg_12_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1039ui_story"]) and arg_12_1.var_.characterEffect1039ui_story then
				arg_12_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.55

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(112211003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 22 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 22)

				if (22 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 22)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play112211004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 112211004
		arg_16_1.duration_ = 4.23

		local var_16_0 = {
			ja = 3.433,
			ko = 4.233,
			zh = 2.766,
			en = 3.3
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play112211005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1039ui_story = arg_16_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1039ui_story"].transform.position).z)
				arg_16_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1039ui_story"].transform.localEulerAngles = arg_16_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1039ui_story"].transform.position).z)
				arg_16_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1039ui_story"].transform.localEulerAngles = arg_16_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_19_1 = "1027ui_story"

			if arg_16_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_16_1.stage_.transform)

				var_19_2.name = var_19_1
				var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_1] = var_19_2

				local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

				var_19_3.enabled = true

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_3.transform, false)

				arg_16_1.var_[var_19_1 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_1 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_1 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_5 = arg_16_1.actors_["1027ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1027ui_story = var_19_5.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1027ui_story" .. "Animator"].transform, false)
			end

			local var_19_6 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 then
				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_16_1.time_ - 0) / var_19_6)
				var_19_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_5.position).x, (manager.ui.mainCamera.transform.position - var_19_5.position).y, (manager.ui.mainCamera.transform.position - var_19_5.position).z)
				var_19_5.localEulerAngles.z = 0
				var_19_5.localEulerAngles.x = 0
				var_19_5.localEulerAngles = var_19_5.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -0.81, -5.8)
				var_19_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_5.position).x, (manager.ui.mainCamera.transform.position - var_19_5.position).y, (manager.ui.mainCamera.transform.position - var_19_5.position).z)
				var_19_5.localEulerAngles.z = 0
				var_19_5.localEulerAngles.x = 0
				var_19_5.localEulerAngles = var_19_5.localEulerAngles
			end

			local var_19_7 = arg_16_1.actors_["1027ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect1027ui_story == nil then
				arg_16_1.var_.characterEffect1027ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect1027ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect1027ui_story then
				arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_19_10 = 0
			local var_19_11 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(112211004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 14 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 14)

				if (14 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 14)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211004", "story_v_out_112211.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_112211", "112211004", "story_v_out_112211.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_112211", "112211004", "story_v_out_112211.awb")

						arg_16_1:RecordAudio("112211004", var_19_17)
						arg_16_1:RecordAudio("112211004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_112211", "112211004", "story_v_out_112211.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_112211", "112211004", "story_v_out_112211.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play112211005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 112211005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play112211006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1027ui_story"]) and arg_20_1.var_.characterEffect1027ui_story == nil then
				arg_20_1.var_.characterEffect1027ui_story = arg_20_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1027ui_story"]) then
				if arg_20_1.var_.characterEffect1027ui_story and not isNil(arg_20_1.actors_["1027ui_story"]) then
					arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1027ui_story"]) and arg_20_1.var_.characterEffect1027ui_story then
				arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.175

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(112211005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 7 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 7)

				if (7 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 7)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play112211006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 112211006
		arg_24_1.duration_ = 14.2

		local var_24_0 = {
			ja = 11.4,
			ko = 8.6,
			zh = 11.333,
			en = 14.2
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play112211007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1027ui_story"]) and arg_24_1.var_.characterEffect1027ui_story == nil then
				arg_24_1.var_.characterEffect1027ui_story = arg_24_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1027ui_story"]) then
				if arg_24_1.var_.characterEffect1027ui_story and not isNil(arg_24_1.actors_["1027ui_story"]) then
					arg_24_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1027ui_story"]) and arg_24_1.var_.characterEffect1027ui_story then
				arg_24_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action474")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_27_2 = 0
			local var_27_3 = 1

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(112211006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 40 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 40)

				if (40 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_5) / 40)) > 0 and var_27_3 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211006", "story_v_out_112211.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211006", "story_v_out_112211.awb") / 1000

					if var_27_8 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_2
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_112211", "112211006", "story_v_out_112211.awb")

						arg_24_1:RecordAudio("112211006", var_27_9)
						arg_24_1:RecordAudio("112211006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_112211", "112211006", "story_v_out_112211.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_112211", "112211006", "story_v_out_112211.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_10 and arg_24_1.time_ < var_27_2 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play112211007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 112211007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play112211008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1027ui_story"]) and arg_28_1.var_.characterEffect1027ui_story == nil then
				arg_28_1.var_.characterEffect1027ui_story = arg_28_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1027ui_story"]) then
				if arg_28_1.var_.characterEffect1027ui_story and not isNil(arg_28_1.actors_["1027ui_story"]) then
					arg_28_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1027ui_story"]) and arg_28_1.var_.characterEffect1027ui_story then
				arg_28_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.075

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(112211007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 3 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 3)

				if (3 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 3)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play112211008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 112211008
		arg_32_1.duration_ = 4.6

		local var_32_0 = {
			ja = 4.333,
			ko = 4.233,
			zh = 3.366,
			en = 4.6
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play112211009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1027ui_story = arg_32_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1027ui_story"].transform.position).z)
				arg_32_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1027ui_story"].transform.localEulerAngles = arg_32_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1027ui_story"].transform.position).z)
				arg_32_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1027ui_story"].transform.localEulerAngles = arg_32_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_35_1 = "1148ui_story"

			if arg_32_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_32_1.stage_.transform)

				var_35_2.name = var_35_1
				var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_[var_35_1] = var_35_2

				local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

				var_35_3.enabled = true

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_3.transform, false)

				arg_32_1.var_[var_35_1 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_[var_35_1 .. "Animator"].applyRootMotion = true
				arg_32_1.var_[var_35_1 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_5 = arg_32_1.actors_["1148ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1148ui_story = var_35_5.localPosition

				arg_32_1:ShowWeapon(arg_32_1.var_["1148ui_story" .. "Animator"].transform, false)
			end

			local var_35_6 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 then
				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_32_1.time_ - 0) / var_35_6)
				var_35_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_5.position).x, (manager.ui.mainCamera.transform.position - var_35_5.position).y, (manager.ui.mainCamera.transform.position - var_35_5.position).z)
				var_35_5.localEulerAngles.z = 0
				var_35_5.localEulerAngles.x = 0
				var_35_5.localEulerAngles = var_35_5.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -0.8, -6.2)
				var_35_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_5.position).x, (manager.ui.mainCamera.transform.position - var_35_5.position).y, (manager.ui.mainCamera.transform.position - var_35_5.position).z)
				var_35_5.localEulerAngles.z = 0
				var_35_5.localEulerAngles.x = 0
				var_35_5.localEulerAngles = var_35_5.localEulerAngles
			end

			local var_35_7 = arg_32_1.actors_["1148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect1148ui_story == nil then
				arg_32_1.var_.characterEffect1148ui_story = var_35_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 and not isNil(var_35_7) then
				if arg_32_1.var_.characterEffect1148ui_story and not isNil(var_35_7) then
					arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect1148ui_story then
				arg_32_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_35_10 = 0
			local var_35_11 = 0.35

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_12 = arg_32_1:GetWordFromCfg(112211008)
				local var_35_13 = arg_32_1:FormatText(var_35_12.content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 14 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 14)

				if (14 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 14)) > 0 and var_35_11 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211008", "story_v_out_112211.awb") ~= 0 then
					local var_35_16 = manager.audio:GetVoiceLength("story_v_out_112211", "112211008", "story_v_out_112211.awb") / 1000

					if var_35_16 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_10
					end

					if var_35_12.prefab_name ~= "" and arg_32_1.actors_[var_35_12.prefab_name] ~= nil then
						local var_35_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_12.prefab_name].transform, "story_v_out_112211", "112211008", "story_v_out_112211.awb")

						arg_32_1:RecordAudio("112211008", var_35_17)
						arg_32_1:RecordAudio("112211008", var_35_17)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_112211", "112211008", "story_v_out_112211.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_112211", "112211008", "story_v_out_112211.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_18 and arg_32_1.time_ < var_35_10 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play112211009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 112211009
		arg_36_1.duration_ = 5.67

		local var_36_0 = {
			ja = 5.666,
			ko = 2.6,
			zh = 2.666,
			en = 2.866
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play112211010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148ui_story = arg_36_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).z)
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles = arg_36_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1148ui_story"].transform.position).z)
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1148ui_story"].transform.localEulerAngles = arg_36_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1039ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1039ui_story = var_39_1.localPosition
			end

			local var_39_2 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_36_1.time_ - 0) / var_39_2)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, -1.01, -5.9)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			local var_39_3 = arg_36_1.actors_["1039ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1039ui_story == nil then
				arg_36_1.var_.characterEffect1039ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect1039ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1039ui_story then
				arg_36_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_6 = 0
			local var_39_7 = 0.275

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(112211009)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 11 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 11)

				if (11 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 11)) > 0 and var_39_7 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211009", "story_v_out_112211.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211009", "story_v_out_112211.awb") / 1000

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_112211", "112211009", "story_v_out_112211.awb")

						arg_36_1:RecordAudio("112211009", var_39_13)
						arg_36_1:RecordAudio("112211009", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_112211", "112211009", "story_v_out_112211.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_112211", "112211009", "story_v_out_112211.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play112211010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 112211010
		arg_40_1.duration_ = 6.47

		local var_40_0 = {
			ja = 6.466,
			ko = 4.6,
			zh = 3.766,
			en = 4.1
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play112211011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1039ui_story = arg_40_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1039ui_story"].transform.position).z)
				arg_40_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1039ui_story"].transform.localEulerAngles = arg_40_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1039ui_story"].transform.position).z)
				arg_40_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1039ui_story"].transform.localEulerAngles = arg_40_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_43_1 = "1081ui_story"

			if arg_40_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_40_1.stage_.transform)

				var_43_2.name = var_43_1
				var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_[var_43_1] = var_43_2

				local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

				var_43_3.enabled = true

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_3.transform, false)

				arg_40_1.var_[var_43_1 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_[var_43_1 .. "Animator"].applyRootMotion = true
				arg_40_1.var_[var_43_1 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_5 = arg_40_1.actors_["1081ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1081ui_story = var_43_5.localPosition

				arg_40_1:ShowWeapon(arg_40_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_43_6 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_40_1.time_ - 0) / var_43_6)
				var_43_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_5.position).x, (manager.ui.mainCamera.transform.position - var_43_5.position).y, (manager.ui.mainCamera.transform.position - var_43_5.position).z)
				var_43_5.localEulerAngles.z = 0
				var_43_5.localEulerAngles.x = 0
				var_43_5.localEulerAngles = var_43_5.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0, -0.92, -5.8)
				var_43_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_5.position).x, (manager.ui.mainCamera.transform.position - var_43_5.position).y, (manager.ui.mainCamera.transform.position - var_43_5.position).z)
				var_43_5.localEulerAngles.z = 0
				var_43_5.localEulerAngles.x = 0
				var_43_5.localEulerAngles = var_43_5.localEulerAngles
			end

			local var_43_7 = arg_40_1.actors_["1081ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1081ui_story == nil then
				arg_40_1.var_.characterEffect1081ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1081ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1081ui_story then
				arg_40_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_43_10 = 0
			local var_43_11 = 0.425

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_12 = arg_40_1:GetWordFromCfg(112211010)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 17 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 17)

				if (17 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 17)) > 0 and var_43_11 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211010", "story_v_out_112211.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_out_112211", "112211010", "story_v_out_112211.awb") / 1000

					if var_43_16 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_10
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_out_112211", "112211010", "story_v_out_112211.awb")

						arg_40_1:RecordAudio("112211010", var_43_17)
						arg_40_1:RecordAudio("112211010", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_112211", "112211010", "story_v_out_112211.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_112211", "112211010", "story_v_out_112211.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_18 and arg_40_1.time_ < var_43_10 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play112211011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 112211011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play112211012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1081ui_story"]) and arg_44_1.var_.characterEffect1081ui_story == nil then
				arg_44_1.var_.characterEffect1081ui_story = arg_44_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1081ui_story"]) then
				if arg_44_1.var_.characterEffect1081ui_story and not isNil(arg_44_1.actors_["1081ui_story"]) then
					arg_44_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1081ui_story"]) and arg_44_1.var_.characterEffect1081ui_story then
				arg_44_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.85

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(112211011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 34 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 34)

				if (34 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 34)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play112211012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 112211012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play112211013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_51_0 = 0
			local var_51_1 = 0.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(112211012).content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 19 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_2) / 19)

				if (19 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_2) / 19)) > 0 and var_51_1 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_5 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_5 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_5

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_5 and arg_48_1.time_ < var_51_0 + var_51_5 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play112211013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 112211013
		arg_52_1.duration_ = 5.87

		local var_52_0 = {
			ja = 5.866,
			ko = 4.066,
			zh = 3.466,
			en = 3.366
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play112211014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1081ui_story"]) and arg_52_1.var_.characterEffect1081ui_story == nil then
				arg_52_1.var_.characterEffect1081ui_story = arg_52_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1081ui_story"]) then
				if arg_52_1.var_.characterEffect1081ui_story and not isNil(arg_52_1.actors_["1081ui_story"]) then
					arg_52_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1081ui_story"]) and arg_52_1.var_.characterEffect1081ui_story then
				arg_52_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_55_2 = 0
			local var_55_3 = 0.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(112211013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 12 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 12)

				if (12 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 12)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211013", "story_v_out_112211.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211013", "story_v_out_112211.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_112211", "112211013", "story_v_out_112211.awb")

						arg_52_1:RecordAudio("112211013", var_55_9)
						arg_52_1:RecordAudio("112211013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_112211", "112211013", "story_v_out_112211.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_112211", "112211013", "story_v_out_112211.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play112211014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 112211014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play112211015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1081ui_story"]) and arg_56_1.var_.characterEffect1081ui_story == nil then
				arg_56_1.var_.characterEffect1081ui_story = arg_56_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1081ui_story"]) then
				if arg_56_1.var_.characterEffect1081ui_story and not isNil(arg_56_1.actors_["1081ui_story"]) then
					arg_56_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1081ui_story"]) and arg_56_1.var_.characterEffect1081ui_story then
				arg_56_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_59_1 = arg_56_1.actors_["1081ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1081ui_story = var_59_1.localPosition

				arg_56_1:ShowWeapon(arg_56_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = 0
			local var_59_4 = 0.425

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(112211014).content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 17 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_5) / 17)

				if (17 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_5) / 17)) > 0 and var_59_4 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_3
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_8 = math.max(var_59_4, arg_56_1.talkMaxDuration)

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_8 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_3) / var_59_8

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_3 + var_59_8 and arg_56_1.time_ < var_59_3 + var_59_8 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play112211015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 112211015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play112211016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.45

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(112211015).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 18)

				if (18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 18)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play112211016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 112211016
		arg_64_1.duration_ = 10.47

		local var_64_0 = {
			ja = 7.7,
			ko = 7.3,
			zh = 8.3,
			en = 10.466
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play112211017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1081ui_story"]) and arg_64_1.var_.characterEffect1081ui_story == nil then
				arg_64_1.var_.characterEffect1081ui_story = arg_64_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1081ui_story"]) then
				if arg_64_1.var_.characterEffect1081ui_story and not isNil(arg_64_1.actors_["1081ui_story"]) then
					arg_64_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1081ui_story"]) and arg_64_1.var_.characterEffect1081ui_story then
				arg_64_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_67_2 = arg_64_1.actors_["1081ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1081ui_story = var_67_2.localPosition

				arg_64_1:ShowWeapon(arg_64_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_67_3 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 then
				var_67_2.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_64_1.time_ - 0) / var_67_3)
				var_67_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_2.position).x, (manager.ui.mainCamera.transform.position - var_67_2.position).y, (manager.ui.mainCamera.transform.position - var_67_2.position).z)
				var_67_2.localEulerAngles.z = 0
				var_67_2.localEulerAngles.x = 0
				var_67_2.localEulerAngles = var_67_2.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 then
				var_67_2.localPosition = Vector3.New(0, -0.92, -5.8)
				var_67_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_2.position).x, (manager.ui.mainCamera.transform.position - var_67_2.position).y, (manager.ui.mainCamera.transform.position - var_67_2.position).z)
				var_67_2.localEulerAngles.z = 0
				var_67_2.localEulerAngles.x = 0
				var_67_2.localEulerAngles = var_67_2.localEulerAngles
			end

			local var_67_4 = 0
			local var_67_5 = 0.9

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(112211016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 36 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 36)

				if (36 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 36)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211016", "story_v_out_112211.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211016", "story_v_out_112211.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_112211", "112211016", "story_v_out_112211.awb")

						arg_64_1:RecordAudio("112211016", var_67_11)
						arg_64_1:RecordAudio("112211016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_112211", "112211016", "story_v_out_112211.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_112211", "112211016", "story_v_out_112211.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play112211017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 112211017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play112211018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1081ui_story"]) and arg_68_1.var_.characterEffect1081ui_story == nil then
				arg_68_1.var_.characterEffect1081ui_story = arg_68_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1081ui_story"]) then
				if arg_68_1.var_.characterEffect1081ui_story and not isNil(arg_68_1.actors_["1081ui_story"]) then
					arg_68_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1081ui_story"]) and arg_68_1.var_.characterEffect1081ui_story then
				arg_68_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.175

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(112211017).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 7 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 7)

				if (7 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 7)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play112211018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 112211018
		arg_72_1.duration_ = 2

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play112211019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1081ui_story"]) and arg_72_1.var_.characterEffect1081ui_story == nil then
				arg_72_1.var_.characterEffect1081ui_story = arg_72_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1081ui_story"]) then
				if arg_72_1.var_.characterEffect1081ui_story and not isNil(arg_72_1.actors_["1081ui_story"]) then
					arg_72_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1081ui_story"]) and arg_72_1.var_.characterEffect1081ui_story then
				arg_72_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_75_2 = 0
			local var_75_3 = 0.1

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(112211018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 4 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 4)

				if (4 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 4)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211018", "story_v_out_112211.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211018", "story_v_out_112211.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_112211", "112211018", "story_v_out_112211.awb")

						arg_72_1:RecordAudio("112211018", var_75_9)
						arg_72_1:RecordAudio("112211018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_112211", "112211018", "story_v_out_112211.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_112211", "112211018", "story_v_out_112211.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play112211019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 112211019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play112211020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1081ui_story = arg_76_1.actors_["1081ui_story"].transform.localPosition

				arg_76_1:ShowWeapon(arg_76_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).z)
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles = arg_76_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1081ui_story"].transform.position).z)
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1081ui_story"].transform.localEulerAngles = arg_76_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_79_1 = 0
			local var_79_2 = 0.7

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(112211019).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 28 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 28)

				if (28 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 28)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play112211020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 112211020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play112211021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.375

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(112211020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 15 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 15)

				if (15 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 15)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play112211021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 112211021
		arg_84_1.duration_ = 2.83

		local var_84_0 = {
			ja = 2.666,
			ko = 2.833,
			zh = 2.2,
			en = 2.7
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play112211022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.175

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(112211021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 7 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 7)

				if (7 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 7)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211021", "story_v_out_112211.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_112211", "112211021", "story_v_out_112211.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_112211", "112211021", "story_v_out_112211.awb")

						arg_84_1:RecordAudio("112211021", var_87_6)
						arg_84_1:RecordAudio("112211021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_112211", "112211021", "story_v_out_112211.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_112211", "112211021", "story_v_out_112211.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play112211022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 112211022
		arg_88_1.duration_ = 5.83

		local var_88_0 = {
			ja = 4.566,
			ko = 3.766,
			zh = 3.066,
			en = 5.833
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play112211023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1081ui_story"]) and arg_88_1.var_.characterEffect1081ui_story == nil then
				arg_88_1.var_.characterEffect1081ui_story = arg_88_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1081ui_story"]) then
				if arg_88_1.var_.characterEffect1081ui_story and not isNil(arg_88_1.actors_["1081ui_story"]) then
					arg_88_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1081ui_story"]) and arg_88_1.var_.characterEffect1081ui_story then
				arg_88_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_2 = arg_88_1.actors_["1081ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1081ui_story = var_91_2.localPosition

				arg_88_1:ShowWeapon(arg_88_1.var_["1081ui_story" .. "Animator"].transform, false)
			end

			local var_91_3 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 then
				var_91_2.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_88_1.time_ - 0) / var_91_3)
				var_91_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_2.position).x, (manager.ui.mainCamera.transform.position - var_91_2.position).y, (manager.ui.mainCamera.transform.position - var_91_2.position).z)
				var_91_2.localEulerAngles.z = 0
				var_91_2.localEulerAngles.x = 0
				var_91_2.localEulerAngles = var_91_2.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 then
				var_91_2.localPosition = Vector3.New(0, -0.92, -5.8)
				var_91_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_2.position).x, (manager.ui.mainCamera.transform.position - var_91_2.position).y, (manager.ui.mainCamera.transform.position - var_91_2.position).z)
				var_91_2.localEulerAngles.z = 0
				var_91_2.localEulerAngles.x = 0
				var_91_2.localEulerAngles = var_91_2.localEulerAngles
			end

			local var_91_4 = 0
			local var_91_5 = 0.325

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(112211022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 13 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 13)

				if (13 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 13)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211022", "story_v_out_112211.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211022", "story_v_out_112211.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_112211", "112211022", "story_v_out_112211.awb")

						arg_88_1:RecordAudio("112211022", var_91_11)
						arg_88_1:RecordAudio("112211022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_112211", "112211022", "story_v_out_112211.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_112211", "112211022", "story_v_out_112211.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play112211023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 112211023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play112211024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1081ui_story"]) and arg_92_1.var_.characterEffect1081ui_story == nil then
				arg_92_1.var_.characterEffect1081ui_story = arg_92_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1081ui_story"]) then
				if arg_92_1.var_.characterEffect1081ui_story and not isNil(arg_92_1.actors_["1081ui_story"]) then
					arg_92_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1081ui_story"]) and arg_92_1.var_.characterEffect1081ui_story then
				arg_92_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_95_1 = 0
			local var_95_2 = 0.8

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(112211023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 32 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 32)

				if (32 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 32)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play112211024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 112211024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play112211025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.525

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(112211024).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 21 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 21)

				if (21 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 21)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play112211025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 112211025
		arg_100_1.duration_ = 3.17

		local var_100_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 2.066,
			en = 3.166
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play112211026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1081ui_story"]) and arg_100_1.var_.characterEffect1081ui_story == nil then
				arg_100_1.var_.characterEffect1081ui_story = arg_100_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1081ui_story"]) then
				if arg_100_1.var_.characterEffect1081ui_story and not isNil(arg_100_1.actors_["1081ui_story"]) then
					arg_100_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1081ui_story"]) and arg_100_1.var_.characterEffect1081ui_story then
				arg_100_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_103_2 = 0
			local var_103_3 = 0.075

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(112211025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 3 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 3)

				if (3 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 3)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211025", "story_v_out_112211.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211025", "story_v_out_112211.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_112211", "112211025", "story_v_out_112211.awb")

						arg_100_1:RecordAudio("112211025", var_103_9)
						arg_100_1:RecordAudio("112211025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_112211", "112211025", "story_v_out_112211.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_112211", "112211025", "story_v_out_112211.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play112211026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 112211026
		arg_104_1.duration_ = 4.7

		local var_104_0 = {
			ja = 3.3,
			ko = 4.7,
			zh = 4.1,
			en = 4.7
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play112211027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1081ui_story = arg_104_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1081ui_story"].transform.position).z)
				arg_104_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1081ui_story"].transform.localEulerAngles = arg_104_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_104_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1081ui_story"].transform.position).z)
				arg_104_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1081ui_story"].transform.localEulerAngles = arg_104_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_2")
			end

			local var_107_1 = arg_104_1.actors_["1148ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1148ui_story = var_107_1.localPosition
			end

			local var_107_2 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 then
				var_107_1.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_104_1.time_ - 0) / var_107_2)
				var_107_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_1.position).x, (manager.ui.mainCamera.transform.position - var_107_1.position).y, (manager.ui.mainCamera.transform.position - var_107_1.position).z)
				var_107_1.localEulerAngles.z = 0
				var_107_1.localEulerAngles.x = 0
				var_107_1.localEulerAngles = var_107_1.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 then
				var_107_1.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_107_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_1.position).x, (manager.ui.mainCamera.transform.position - var_107_1.position).y, (manager.ui.mainCamera.transform.position - var_107_1.position).z)
				var_107_1.localEulerAngles.z = 0
				var_107_1.localEulerAngles.x = 0
				var_107_1.localEulerAngles = var_107_1.localEulerAngles
			end

			local var_107_3 = arg_104_1.actors_["1148ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_4 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 and not isNil(var_107_3) then
				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_3) then
					arg_104_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 and not isNil(var_107_3) and arg_104_1.var_.characterEffect1148ui_story then
				arg_104_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			local var_107_6 = arg_104_1.actors_["1081ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1081ui_story == nil then
				arg_104_1.var_.characterEffect1081ui_story = var_107_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_7 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 and not isNil(var_107_6) then
				if arg_104_1.var_.characterEffect1081ui_story and not isNil(var_107_6) then
					arg_104_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_7)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 and not isNil(var_107_6) and arg_104_1.var_.characterEffect1081ui_story then
				arg_104_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_107_8 = 0
			local var_107_9 = 0.475

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_8 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:GetWordFromCfg(112211026)
				local var_107_11 = arg_104_1:FormatText(var_107_10.content)

				arg_104_1.text_.text = var_107_11

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_13 = 19 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 19)

				if (19 <= 0 and var_107_9 or var_107_9 * (utf8.len(var_107_11) / 19)) > 0 and var_107_9 < var_107_13 then
					arg_104_1.talkMaxDuration = var_107_13

					if var_107_13 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_8
					end
				end

				arg_104_1.text_.text = var_107_11
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211026", "story_v_out_112211.awb") ~= 0 then
					local var_107_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211026", "story_v_out_112211.awb") / 1000

					if var_107_14 + var_107_8 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_14 + var_107_8
					end

					if var_107_10.prefab_name ~= "" and arg_104_1.actors_[var_107_10.prefab_name] ~= nil then
						local var_107_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_10.prefab_name].transform, "story_v_out_112211", "112211026", "story_v_out_112211.awb")

						arg_104_1:RecordAudio("112211026", var_107_15)
						arg_104_1:RecordAudio("112211026", var_107_15)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_112211", "112211026", "story_v_out_112211.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_112211", "112211026", "story_v_out_112211.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_9, arg_104_1.talkMaxDuration)

			if var_107_8 <= arg_104_1.time_ and arg_104_1.time_ < var_107_8 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_8) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_8 + var_107_16 and arg_104_1.time_ < var_107_8 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play112211027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 112211027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play112211028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story == nil then
				arg_108_1.var_.characterEffect1148ui_story = arg_108_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) then
				if arg_108_1.var_.characterEffect1148ui_story and not isNil(arg_108_1.actors_["1148ui_story"]) then
					arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story then
				arg_108_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.2

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(112211027).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 8 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 8)

				if (8 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 8)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play112211028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 112211028
		arg_112_1.duration_ = 7.6

		local var_112_0 = {
			ja = 7.6,
			ko = 6.533,
			zh = 7.433,
			en = 6.533
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play112211029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1081ui_story"]) and arg_112_1.var_.characterEffect1081ui_story == nil then
				arg_112_1.var_.characterEffect1081ui_story = arg_112_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1081ui_story"]) then
				if arg_112_1.var_.characterEffect1081ui_story and not isNil(arg_112_1.actors_["1081ui_story"]) then
					arg_112_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1081ui_story"]) and arg_112_1.var_.characterEffect1081ui_story then
				arg_112_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_115_2 = 0
			local var_115_3 = 0.8

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(112211028)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 32 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 32)

				if (32 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 32)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211028", "story_v_out_112211.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211028", "story_v_out_112211.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_112211", "112211028", "story_v_out_112211.awb")

						arg_112_1:RecordAudio("112211028", var_115_9)
						arg_112_1:RecordAudio("112211028", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_112211", "112211028", "story_v_out_112211.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_112211", "112211028", "story_v_out_112211.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play112211029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 112211029
		arg_116_1.duration_ = 4.97

		local var_116_0 = {
			ja = 4.666,
			ko = 4.6,
			zh = 4.466,
			en = 4.966
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play112211030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1081ui_story"]) and arg_116_1.var_.characterEffect1081ui_story == nil then
				arg_116_1.var_.characterEffect1081ui_story = arg_116_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1081ui_story"]) then
				if arg_116_1.var_.characterEffect1081ui_story and not isNil(arg_116_1.actors_["1081ui_story"]) then
					arg_116_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1081ui_story"]) and arg_116_1.var_.characterEffect1081ui_story then
				arg_116_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_119_1 = arg_116_1.actors_["1148ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1148ui_story == nil then
				arg_116_1.var_.characterEffect1148ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1148ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1148ui_story then
				arg_116_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_119_4 = 0
			local var_119_5 = 0.475

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(112211029)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 19 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 19)

				if (19 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 19)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211029", "story_v_out_112211.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211029", "story_v_out_112211.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_112211", "112211029", "story_v_out_112211.awb")

						arg_116_1:RecordAudio("112211029", var_119_11)
						arg_116_1:RecordAudio("112211029", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_112211", "112211029", "story_v_out_112211.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_112211", "112211029", "story_v_out_112211.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play112211030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 112211030
		arg_120_1.duration_ = 7.4

		local var_120_0 = {
			ja = 7.4,
			ko = 5.6,
			zh = 3.866,
			en = 3.8
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play112211031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1148ui_story = arg_120_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1148ui_story"].transform.position).z)
				arg_120_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1148ui_story"].transform.localEulerAngles = arg_120_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1148ui_story"].transform.position).z)
				arg_120_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1148ui_story"].transform.localEulerAngles = arg_120_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["1081ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1081ui_story = var_123_1.localPosition
			end

			local var_123_2 = 0.166666666666667

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_120_1.time_ - 0) / var_123_2)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0, -0.92, -5.8)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action457")
			end

			local var_123_3 = arg_120_1.actors_["1081ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1081ui_story == nil then
				arg_120_1.var_.characterEffect1081ui_story = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect1081ui_story and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect1081ui_story then
				arg_120_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_123_6 = 0
			local var_123_7 = 0.375

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(112211030)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 15 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 15)

				if (15 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 15)) > 0 and var_123_7 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211030", "story_v_out_112211.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211030", "story_v_out_112211.awb") / 1000

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_out_112211", "112211030", "story_v_out_112211.awb")

						arg_120_1:RecordAudio("112211030", var_123_13)
						arg_120_1:RecordAudio("112211030", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_112211", "112211030", "story_v_out_112211.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_112211", "112211030", "story_v_out_112211.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play112211031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 112211031
		arg_124_1.duration_ = 16.17

		local var_124_0 = {
			ja = 12.133,
			ko = 8.266,
			zh = 9.1,
			en = 16.166
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play112211032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1081ui_story = arg_124_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1081ui_story"].transform.position).z)
				arg_124_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1081ui_story"].transform.localEulerAngles = arg_124_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1081ui_story"].transform.position).z)
				arg_124_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1081ui_story"].transform.localEulerAngles = arg_124_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_127_1 = arg_124_1.actors_["1039ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1039ui_story = var_127_1.localPosition
			end

			local var_127_2 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 then
				var_127_1.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_124_1.time_ - 0) / var_127_2)
				var_127_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_1.position).x, (manager.ui.mainCamera.transform.position - var_127_1.position).y, (manager.ui.mainCamera.transform.position - var_127_1.position).z)
				var_127_1.localEulerAngles.z = 0
				var_127_1.localEulerAngles.x = 0
				var_127_1.localEulerAngles = var_127_1.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 then
				var_127_1.localPosition = Vector3.New(0, -1.01, -5.9)
				var_127_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_1.position).x, (manager.ui.mainCamera.transform.position - var_127_1.position).y, (manager.ui.mainCamera.transform.position - var_127_1.position).z)
				var_127_1.localEulerAngles.z = 0
				var_127_1.localEulerAngles.x = 0
				var_127_1.localEulerAngles = var_127_1.localEulerAngles
			end

			local var_127_3 = arg_124_1.actors_["1039ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1039ui_story == nil then
				arg_124_1.var_.characterEffect1039ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect1039ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1039ui_story then
				arg_124_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_127_6 = 0
			local var_127_7 = 1.15

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(112211031)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 46 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 46)

				if (46 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 46)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211031", "story_v_out_112211.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211031", "story_v_out_112211.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_112211", "112211031", "story_v_out_112211.awb")

						arg_124_1:RecordAudio("112211031", var_127_13)
						arg_124_1:RecordAudio("112211031", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_112211", "112211031", "story_v_out_112211.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_112211", "112211031", "story_v_out_112211.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play112211032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 112211032
		arg_128_1.duration_ = 4.03

		local var_128_0 = {
			ja = 3.433,
			ko = 3.066,
			zh = 2.333,
			en = 4.033
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play112211033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1039ui_story = arg_128_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1039ui_story"].transform.position).z)
				arg_128_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1039ui_story"].transform.localEulerAngles = arg_128_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1039ui_story"].transform.position).z)
				arg_128_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1039ui_story"].transform.localEulerAngles = arg_128_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1148ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1148ui_story = var_131_1.localPosition
			end

			local var_131_2 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 then
				var_131_1.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_128_1.time_ - 0) / var_131_2)
				var_131_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_1.position).x, (manager.ui.mainCamera.transform.position - var_131_1.position).y, (manager.ui.mainCamera.transform.position - var_131_1.position).z)
				var_131_1.localEulerAngles.z = 0
				var_131_1.localEulerAngles.x = 0
				var_131_1.localEulerAngles = var_131_1.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 then
				var_131_1.localPosition = Vector3.New(0, -0.8, -6.2)
				var_131_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_1.position).x, (manager.ui.mainCamera.transform.position - var_131_1.position).y, (manager.ui.mainCamera.transform.position - var_131_1.position).z)
				var_131_1.localEulerAngles.z = 0
				var_131_1.localEulerAngles.x = 0
				var_131_1.localEulerAngles = var_131_1.localEulerAngles
			end

			local var_131_3 = arg_128_1.actors_["1148ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1148ui_story == nil then
				arg_128_1.var_.characterEffect1148ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1148ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1148ui_story then
				arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_131_6 = 0
			local var_131_7 = 0.25

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(112211032)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 10 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 10)

				if (10 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 10)) > 0 and var_131_7 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211032", "story_v_out_112211.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211032", "story_v_out_112211.awb") / 1000

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_out_112211", "112211032", "story_v_out_112211.awb")

						arg_128_1:RecordAudio("112211032", var_131_13)
						arg_128_1:RecordAudio("112211032", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_112211", "112211032", "story_v_out_112211.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_112211", "112211032", "story_v_out_112211.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play112211033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 112211033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play112211034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1148ui_story"]) and arg_132_1.var_.characterEffect1148ui_story == nil then
				arg_132_1.var_.characterEffect1148ui_story = arg_132_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1148ui_story"]) then
				if arg_132_1.var_.characterEffect1148ui_story and not isNil(arg_132_1.actors_["1148ui_story"]) then
					arg_132_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1148ui_story"]) and arg_132_1.var_.characterEffect1148ui_story then
				arg_132_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_2")
			end

			local var_135_1 = 0
			local var_135_2 = 1.425

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(112211033).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 57 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 57)

				if (57 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 57)) > 0 and var_135_2 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_6 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_6 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_6

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_6 and arg_132_1.time_ < var_135_1 + var_135_6 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play112211034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 112211034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play112211035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.2

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(112211034).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 8 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 8)

				if (8 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 8)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play112211035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 112211035
		arg_140_1.duration_ = 5.67

		local var_140_0 = {
			ja = 5.666,
			ko = 2.933,
			zh = 3.766,
			en = 5.4
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play112211036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1148ui_story"]) and arg_140_1.var_.characterEffect1148ui_story == nil then
				arg_140_1.var_.characterEffect1148ui_story = arg_140_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1148ui_story"]) then
				if arg_140_1.var_.characterEffect1148ui_story and not isNil(arg_140_1.actors_["1148ui_story"]) then
					arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1148ui_story"]) and arg_140_1.var_.characterEffect1148ui_story then
				arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_143_2 = 0
			local var_143_3 = 0.475

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(112211035)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 19 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 19)

				if (19 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 19)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211035", "story_v_out_112211.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211035", "story_v_out_112211.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_112211", "112211035", "story_v_out_112211.awb")

						arg_140_1:RecordAudio("112211035", var_143_9)
						arg_140_1:RecordAudio("112211035", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_112211", "112211035", "story_v_out_112211.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_112211", "112211035", "story_v_out_112211.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play112211036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 112211036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play112211037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1148ui_story"]) and arg_144_1.var_.characterEffect1148ui_story == nil then
				arg_144_1.var_.characterEffect1148ui_story = arg_144_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1148ui_story"]) then
				if arg_144_1.var_.characterEffect1148ui_story and not isNil(arg_144_1.actors_["1148ui_story"]) then
					arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1148ui_story"]) and arg_144_1.var_.characterEffect1148ui_story then
				arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.45

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(112211036).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 18 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 18)

				if (18 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 18)) > 0 and var_147_2 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5

					if var_147_5 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_6 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_6

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_6 and arg_144_1.time_ < var_147_1 + var_147_6 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play112211037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 112211037
		arg_148_1.duration_ = 6.8

		local var_148_0 = {
			ja = 6.8,
			ko = 4.733,
			zh = 4.1,
			en = 5.866
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play112211038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1148ui_story"]) and arg_148_1.var_.characterEffect1148ui_story == nil then
				arg_148_1.var_.characterEffect1148ui_story = arg_148_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1148ui_story"]) then
				if arg_148_1.var_.characterEffect1148ui_story and not isNil(arg_148_1.actors_["1148ui_story"]) then
					arg_148_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1148ui_story"]) and arg_148_1.var_.characterEffect1148ui_story then
				arg_148_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_151_2 = 0
			local var_151_3 = 0.5

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(112211037)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 20 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 20)

				if (20 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 20)) > 0 and var_151_3 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211037", "story_v_out_112211.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211037", "story_v_out_112211.awb") / 1000

					if var_151_8 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_2
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_112211", "112211037", "story_v_out_112211.awb")

						arg_148_1:RecordAudio("112211037", var_151_9)
						arg_148_1:RecordAudio("112211037", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_112211", "112211037", "story_v_out_112211.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_112211", "112211037", "story_v_out_112211.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_10 and arg_148_1.time_ < var_151_2 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play112211038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 112211038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play112211039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1148ui_story = arg_152_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1148ui_story"].transform.position).z)
				arg_152_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1148ui_story"].transform.localEulerAngles = arg_152_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1148ui_story"].transform.position).z)
				arg_152_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1148ui_story"].transform.localEulerAngles = arg_152_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_155_1 = 0
			local var_155_2 = 0.05

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(112211038).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 2 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 2)

				if (2 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 2)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_6 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_6 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_6

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_6 and arg_152_1.time_ < var_155_1 + var_155_6 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play112211039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 112211039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play112211040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.05

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(112211039).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 42 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 42)

				if (42 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 42)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play112211040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 112211040
		arg_160_1.duration_ = 8.3

		local var_160_0 = {
			ja = 7.566,
			ko = 8.3,
			zh = 7.2,
			en = 6.6
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play112211041(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_163_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_160_1.stage_.transform)

				var_163_0.name = "1084ui_story"
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_["1084ui_story"] = var_163_0

				local var_163_1 = var_163_0:GetComponentInChildren(typeof(CharacterEffect))

				var_163_1.enabled = true

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_0, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end

				arg_160_1:ShowWeapon(var_163_1.transform, false)

				arg_160_1.var_["1084ui_story" .. "Animator"] = var_163_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_160_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_160_1.var_["1084ui_story" .. "LipSync"] = var_163_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_163_3 = arg_160_1.actors_["1084ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1084ui_story = var_163_3.localPosition

				arg_160_1:ShowWeapon(arg_160_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_163_4 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				var_163_3.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_160_1.time_ - 0) / var_163_4)
				var_163_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_3.position).x, (manager.ui.mainCamera.transform.position - var_163_3.position).y, (manager.ui.mainCamera.transform.position - var_163_3.position).z)
				var_163_3.localEulerAngles.z = 0
				var_163_3.localEulerAngles.x = 0
				var_163_3.localEulerAngles = var_163_3.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				var_163_3.localPosition = Vector3.New(0, -0.97, -6)
				var_163_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_3.position).x, (manager.ui.mainCamera.transform.position - var_163_3.position).y, (manager.ui.mainCamera.transform.position - var_163_3.position).z)
				var_163_3.localEulerAngles.z = 0
				var_163_3.localEulerAngles.x = 0
				var_163_3.localEulerAngles = var_163_3.localEulerAngles
			end

			local var_163_5 = arg_160_1.actors_["1084ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_5) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_6 and not isNil(var_163_5) then
				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_5) then
					arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_6 and arg_160_1.time_ < 0 + var_163_6 + arg_163_0 and not isNil(var_163_5) and arg_160_1.var_.characterEffect1084ui_story then
				arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_163_8 = 0
			local var_163_9 = 0.9

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_10 = arg_160_1:GetWordFromCfg(112211040)
				local var_163_11 = arg_160_1:FormatText(var_163_10.content)

				arg_160_1.text_.text = var_163_11

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 36 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 36)

				if (36 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 36)) > 0 and var_163_9 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_8
					end
				end

				arg_160_1.text_.text = var_163_11
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211040", "story_v_out_112211.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_112211", "112211040", "story_v_out_112211.awb") / 1000

					if var_163_14 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_8
					end

					if var_163_10.prefab_name ~= "" and arg_160_1.actors_[var_163_10.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_10.prefab_name].transform, "story_v_out_112211", "112211040", "story_v_out_112211.awb")

						arg_160_1:RecordAudio("112211040", var_163_15)
						arg_160_1:RecordAudio("112211040", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_112211", "112211040", "story_v_out_112211.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_112211", "112211040", "story_v_out_112211.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_9, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_8) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_16 and arg_160_1.time_ < var_163_8 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play112211041 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 112211041
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play112211042(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1084ui_story"]) and arg_164_1.var_.characterEffect1084ui_story == nil then
				arg_164_1.var_.characterEffect1084ui_story = arg_164_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1084ui_story"]) then
				if arg_164_1.var_.characterEffect1084ui_story and not isNil(arg_164_1.actors_["1084ui_story"]) then
					arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1084ui_story"]) and arg_164_1.var_.characterEffect1084ui_story then
				arg_164_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 0.3

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(112211041).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 12 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 12)

				if (12 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 12)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play112211042 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 112211042
		arg_168_1.duration_ = 10.77

		local var_168_0 = {
			ja = 8.566,
			ko = 10.333,
			zh = 8.333,
			en = 10.766
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play112211043(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1084ui_story"]) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = arg_168_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1084ui_story"]) then
				if arg_168_1.var_.characterEffect1084ui_story and not isNil(arg_168_1.actors_["1084ui_story"]) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1084ui_story"]) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_171_2 = 0
			local var_171_3 = 1.05

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(112211042)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 42 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 42)

				if (42 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 42)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211042", "story_v_out_112211.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211042", "story_v_out_112211.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_112211", "112211042", "story_v_out_112211.awb")

						arg_168_1:RecordAudio("112211042", var_171_9)
						arg_168_1:RecordAudio("112211042", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_112211", "112211042", "story_v_out_112211.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_112211", "112211042", "story_v_out_112211.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play112211043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 112211043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play112211044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1084ui_story"]) and arg_172_1.var_.characterEffect1084ui_story == nil then
				arg_172_1.var_.characterEffect1084ui_story = arg_172_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1084ui_story"]) then
				if arg_172_1.var_.characterEffect1084ui_story and not isNil(arg_172_1.actors_["1084ui_story"]) then
					arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1084ui_story"]) and arg_172_1.var_.characterEffect1084ui_story then
				arg_172_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.125

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(112211043).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 5 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 5)

				if (5 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 5)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play112211044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 112211044
		arg_176_1.duration_ = 13.5

		local var_176_0 = {
			ja = 13.1,
			ko = 11.3,
			zh = 13.5,
			en = 11.033
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play112211045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1084ui_story"]) and arg_176_1.var_.characterEffect1084ui_story == nil then
				arg_176_1.var_.characterEffect1084ui_story = arg_176_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1084ui_story"]) then
				if arg_176_1.var_.characterEffect1084ui_story and not isNil(arg_176_1.actors_["1084ui_story"]) then
					arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1084ui_story"]) and arg_176_1.var_.characterEffect1084ui_story then
				arg_176_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_179_2 = 0
			local var_179_3 = 1.05

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(112211044)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 42 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 42)

				if (42 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 42)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211044", "story_v_out_112211.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211044", "story_v_out_112211.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_112211", "112211044", "story_v_out_112211.awb")

						arg_176_1:RecordAudio("112211044", var_179_9)
						arg_176_1:RecordAudio("112211044", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_112211", "112211044", "story_v_out_112211.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_112211", "112211044", "story_v_out_112211.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play112211045 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 112211045
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play112211046(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1084ui_story"]) and arg_180_1.var_.characterEffect1084ui_story == nil then
				arg_180_1.var_.characterEffect1084ui_story = arg_180_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1084ui_story"]) then
				if arg_180_1.var_.characterEffect1084ui_story and not isNil(arg_180_1.actors_["1084ui_story"]) then
					arg_180_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1084ui_story"]) and arg_180_1.var_.characterEffect1084ui_story then
				arg_180_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 1.225

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_3 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(112211045).content)

				arg_180_1.text_.text = var_183_3

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 49 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 49)

				if (49 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_3) / 49)) > 0 and var_183_2 < var_183_5 then
					arg_180_1.talkMaxDuration = var_183_5

					if var_183_5 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_3
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_6 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_6 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_6

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_6 and arg_180_1.time_ < var_183_1 + var_183_6 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play112211046 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 112211046
		arg_184_1.duration_ = 6.07

		local var_184_0 = {
			ja = 4.4,
			ko = 6.066,
			zh = 4.6,
			en = 4.8
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play112211047(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1084ui_story"]) and arg_184_1.var_.characterEffect1084ui_story == nil then
				arg_184_1.var_.characterEffect1084ui_story = arg_184_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1084ui_story"]) then
				if arg_184_1.var_.characterEffect1084ui_story and not isNil(arg_184_1.actors_["1084ui_story"]) then
					arg_184_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1084ui_story"]) and arg_184_1.var_.characterEffect1084ui_story then
				arg_184_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_187_2 = 0
			local var_187_3 = 0.45

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(112211046)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 18 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 18)

				if (18 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 18)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211046", "story_v_out_112211.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211046", "story_v_out_112211.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_112211", "112211046", "story_v_out_112211.awb")

						arg_184_1:RecordAudio("112211046", var_187_9)
						arg_184_1:RecordAudio("112211046", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_112211", "112211046", "story_v_out_112211.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_112211", "112211046", "story_v_out_112211.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play112211047 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 112211047
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play112211048(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1084ui_story"]) and arg_188_1.var_.characterEffect1084ui_story == nil then
				arg_188_1.var_.characterEffect1084ui_story = arg_188_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1084ui_story"]) then
				if arg_188_1.var_.characterEffect1084ui_story and not isNil(arg_188_1.actors_["1084ui_story"]) then
					arg_188_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1084ui_story"]) and arg_188_1.var_.characterEffect1084ui_story then
				arg_188_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.95

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(112211047).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 38 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 38)

				if (38 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 38)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play112211048 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 112211048
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play112211049(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.1

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(112211048).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 4 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 4)

				if (4 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 4)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play112211049 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 112211049
		arg_196_1.duration_ = 9.9

		local var_196_0 = {
			ja = 7.333,
			ko = 7.333,
			zh = 5.466,
			en = 9.9
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play112211050(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1084ui_story = arg_196_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1084ui_story"].transform.position).z)
				arg_196_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1084ui_story"].transform.localEulerAngles = arg_196_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_196_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1084ui_story"].transform.position).z)
				arg_196_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1084ui_story"].transform.localEulerAngles = arg_196_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_199_1 = arg_196_1.actors_["1148ui_story"].transform

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1148ui_story = var_199_1.localPosition
			end

			local var_199_2 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 then
				var_199_1.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_196_1.time_ - 0) / var_199_2)
				var_199_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_1.position).x, (manager.ui.mainCamera.transform.position - var_199_1.position).y, (manager.ui.mainCamera.transform.position - var_199_1.position).z)
				var_199_1.localEulerAngles.z = 0
				var_199_1.localEulerAngles.x = 0
				var_199_1.localEulerAngles = var_199_1.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 then
				var_199_1.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_199_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_199_1.position).x, (manager.ui.mainCamera.transform.position - var_199_1.position).y, (manager.ui.mainCamera.transform.position - var_199_1.position).z)
				var_199_1.localEulerAngles.z = 0
				var_199_1.localEulerAngles.x = 0
				var_199_1.localEulerAngles = var_199_1.localEulerAngles
			end

			local var_199_3 = arg_196_1.actors_["1148ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect1148ui_story == nil then
				arg_196_1.var_.characterEffect1148ui_story = var_199_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_4 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 and not isNil(var_199_3) then
				if arg_196_1.var_.characterEffect1148ui_story and not isNil(var_199_3) then
					arg_196_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect1148ui_story then
				arg_196_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_199_6 = 0
			local var_199_7 = 0.625

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_8 = arg_196_1:GetWordFromCfg(112211049)
				local var_199_9 = arg_196_1:FormatText(var_199_8.content)

				arg_196_1.text_.text = var_199_9

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 25 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 25)

				if (25 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 25)) > 0 and var_199_7 < var_199_11 then
					arg_196_1.talkMaxDuration = var_199_11

					if var_199_11 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_9
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211049", "story_v_out_112211.awb") ~= 0 then
					local var_199_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211049", "story_v_out_112211.awb") / 1000

					if var_199_12 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_6
					end

					if var_199_8.prefab_name ~= "" and arg_196_1.actors_[var_199_8.prefab_name] ~= nil then
						local var_199_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_8.prefab_name].transform, "story_v_out_112211", "112211049", "story_v_out_112211.awb")

						arg_196_1:RecordAudio("112211049", var_199_13)
						arg_196_1:RecordAudio("112211049", var_199_13)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_112211", "112211049", "story_v_out_112211.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_112211", "112211049", "story_v_out_112211.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_14 and arg_196_1.time_ < var_199_6 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play112211050 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 112211050
		arg_200_1.duration_ = 3.43

		local var_200_0 = {
			ja = 3.433,
			ko = 3.033,
			zh = 3.166,
			en = 2.6
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play112211051(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1148ui_story"]) and arg_200_1.var_.characterEffect1148ui_story == nil then
				arg_200_1.var_.characterEffect1148ui_story = arg_200_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1148ui_story"]) then
				if arg_200_1.var_.characterEffect1148ui_story and not isNil(arg_200_1.actors_["1148ui_story"]) then
					arg_200_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1148ui_story"]) and arg_200_1.var_.characterEffect1148ui_story then
				arg_200_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_203_1 = arg_200_1.actors_["1084ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect1084ui_story == nil then
				arg_200_1.var_.characterEffect1084ui_story = var_203_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_2 and not isNil(var_203_1) then
				if arg_200_1.var_.characterEffect1084ui_story and not isNil(var_203_1) then
					arg_200_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_2 and arg_200_1.time_ < 0 + var_203_2 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect1084ui_story then
				arg_200_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action484")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_203_4 = 0
			local var_203_5 = 0.15

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(112211050)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 6 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 6)

				if (6 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 6)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211050", "story_v_out_112211.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211050", "story_v_out_112211.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_out_112211", "112211050", "story_v_out_112211.awb")

						arg_200_1:RecordAudio("112211050", var_203_11)
						arg_200_1:RecordAudio("112211050", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_112211", "112211050", "story_v_out_112211.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_112211", "112211050", "story_v_out_112211.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play112211051 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 112211051
		arg_204_1.duration_ = 12.37

		local var_204_0 = {
			ja = 12.366,
			ko = 8.466,
			zh = 8,
			en = 9.7
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play112211052(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1148ui_story"]) and arg_204_1.var_.characterEffect1148ui_story == nil then
				arg_204_1.var_.characterEffect1148ui_story = arg_204_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1148ui_story"]) then
				if arg_204_1.var_.characterEffect1148ui_story and not isNil(arg_204_1.actors_["1148ui_story"]) then
					arg_204_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1148ui_story"]) and arg_204_1.var_.characterEffect1148ui_story then
				arg_204_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_207_2 = arg_204_1.actors_["1084ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1084ui_story == nil then
				arg_204_1.var_.characterEffect1084ui_story = var_207_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_3 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_2) then
				if arg_204_1.var_.characterEffect1084ui_story and not isNil(var_207_2) then
					arg_204_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_3)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_2) and arg_204_1.var_.characterEffect1084ui_story then
				arg_204_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action476")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_207_4 = 0
			local var_207_5 = 0.825

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_6 = arg_204_1:GetWordFromCfg(112211051)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 33 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 33)

				if (33 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 33)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211051", "story_v_out_112211.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211051", "story_v_out_112211.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_112211", "112211051", "story_v_out_112211.awb")

						arg_204_1:RecordAudio("112211051", var_207_11)
						arg_204_1:RecordAudio("112211051", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_112211", "112211051", "story_v_out_112211.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_112211", "112211051", "story_v_out_112211.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play112211052 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 112211052
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play112211053(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1148ui_story"]) and arg_208_1.var_.characterEffect1148ui_story == nil then
				arg_208_1.var_.characterEffect1148ui_story = arg_208_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1148ui_story"]) then
				if arg_208_1.var_.characterEffect1148ui_story and not isNil(arg_208_1.actors_["1148ui_story"]) then
					arg_208_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1148ui_story"]) and arg_208_1.var_.characterEffect1148ui_story then
				arg_208_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 0.75

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(112211052).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 30 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 30)

				if (30 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 30)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play112211053 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 112211053
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play112211054(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 2 < arg_212_1.time_ and arg_212_1.time_ <= 2 + arg_215_0 then
				local var_215_0 = arg_212_1.bgs_.H02a:GetComponent("SpriteRenderer")

				if var_215_0 then
					arg_212_1.var_.alphaOldValueH02a = var_215_0.color.a
					arg_212_1.var_.alphaMatValueH02a = var_215_0
				end

				arg_212_1.var_.alphaOldValueH02a = 1
			end

			local var_215_1 = 2

			if 2 <= arg_212_1.time_ and arg_212_1.time_ < 2 + var_215_1 then
				if arg_212_1.var_.alphaMatValueH02a then
					arg_212_1.var_.alphaMatValueH02a.color.a = Mathf.Lerp(arg_212_1.var_.alphaOldValueH02a, 0, (arg_212_1.time_ - 2) / var_215_1)
					arg_212_1.var_.alphaMatValueH02a.color = arg_212_1.var_.alphaMatValueH02a.color
				end
			end

			if arg_212_1.time_ >= 2 + var_215_1 and arg_212_1.time_ < 2 + var_215_1 + arg_215_0 and arg_212_1.var_.alphaMatValueH02a then
				arg_212_1.var_.alphaMatValueH02a.color.a = 0
				arg_212_1.var_.alphaMatValueH02a.color = arg_212_1.var_.alphaMatValueH02a.color
			end

			local var_215_2 = 0

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.allBtn_.enabled = false
			end

			if arg_212_1.time_ >= var_215_2 + 4 and arg_212_1.time_ < var_215_2 + 4 + arg_215_0 then
				arg_212_1.allBtn_.enabled = true
			end

			local var_215_3 = arg_212_1.actors_["1148ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1148ui_story = var_215_3.localPosition
			end

			local var_215_4 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				var_215_3.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_4)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				var_215_3.localPosition = Vector3.New(0, 100, 0)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			local var_215_5 = arg_212_1.actors_["1084ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1084ui_story = var_215_5.localPosition
			end

			local var_215_6 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_6 then
				var_215_5.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_6)
				var_215_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_5.position).x, (manager.ui.mainCamera.transform.position - var_215_5.position).y, (manager.ui.mainCamera.transform.position - var_215_5.position).z)
				var_215_5.localEulerAngles.z = 0
				var_215_5.localEulerAngles.x = 0
				var_215_5.localEulerAngles = var_215_5.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_6 and arg_212_1.time_ < 0 + var_215_6 + arg_215_0 then
				var_215_5.localPosition = Vector3.New(0, 100, 0)
				var_215_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_5.position).x, (manager.ui.mainCamera.transform.position - var_215_5.position).y, (manager.ui.mainCamera.transform.position - var_215_5.position).z)
				var_215_5.localEulerAngles.z = 0
				var_215_5.localEulerAngles.x = 0
				var_215_5.localEulerAngles = var_215_5.localEulerAngles
			end

			local var_215_7 = 0
			local var_215_8 = 1.175

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_7 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(112211053).content)

				arg_212_1.text_.text = var_215_9

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 47 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_9) / 47)

				if (47 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_9) / 47)) > 0 and var_215_8 < var_215_11 then
					arg_212_1.talkMaxDuration = var_215_11

					if var_215_11 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_7
					end
				end

				arg_212_1.text_.text = var_215_9
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_8, arg_212_1.talkMaxDuration)

			if var_215_7 <= arg_212_1.time_ and arg_212_1.time_ < var_215_7 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_7) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_7 + var_215_12 and arg_212_1.time_ < var_215_7 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play112211054 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 112211054
		arg_216_1.duration_ = 8.02

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play112211055(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_0 = 2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				local var_219_1 = Color.New(0.0471698, 0.04650231, 0.04650231)

				var_219_1.a = Mathf.Lerp(1, 0, (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.mask_.color = var_219_1
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				local var_219_2 = Color.New(0.0471698, 0.04650231, 0.04650231)

				arg_216_1.mask_.enabled = false
				var_219_2.a = 0
				arg_216_1.mask_.color = var_219_2
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				local var_219_3 = arg_216_1.bgs_.H02a:GetComponent("SpriteRenderer")

				if var_219_3 then
					arg_216_1.var_.alphaOldValueH02a = var_219_3.color.a
					arg_216_1.var_.alphaMatValueH02a = var_219_3
				end

				arg_216_1.var_.alphaOldValueH02a = 0
			end

			local var_219_4 = 0.0166666666666667

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				if arg_216_1.var_.alphaMatValueH02a then
					arg_216_1.var_.alphaMatValueH02a.color.a = Mathf.Lerp(arg_216_1.var_.alphaOldValueH02a, 1, (arg_216_1.time_ - 0) / var_219_4)
					arg_216_1.var_.alphaMatValueH02a.color = arg_216_1.var_.alphaMatValueH02a.color
				end
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 and arg_216_1.var_.alphaMatValueH02a then
				arg_216_1.var_.alphaMatValueH02a.color.a = 1
				arg_216_1.var_.alphaMatValueH02a.color = arg_216_1.var_.alphaMatValueH02a.color
			end

			local var_219_5 = "H02a_blur"

			if arg_216_1.bgs_.H02a_blur == nil then
				local var_219_6 = Object.Instantiate(arg_216_1.blurPaintGo_)

				var_219_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_219_5)
				var_219_6.name = var_219_5
				var_219_6.transform.parent = arg_216_1.stage_.transform
				var_219_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.bgs_[var_219_5] = var_219_6
			end

			local var_219_7 = 0.0166666666666667
			local var_219_8 = arg_216_1.bgs_[var_219_5]

			if 0.0166666666666667 < arg_216_1.time_ and arg_216_1.time_ <= var_219_7 + arg_219_0 then
				var_219_8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_219_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_219_9 = var_219_8:GetComponent("SpriteRenderer")

				if var_219_9 and var_219_9.sprite then
					local var_219_10 = 2 * (var_219_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_219_8.transform.localScale = Vector3.New(var_219_10 / var_219_9.sprite.bounds.size.y < var_219_10 * manager.ui.mainCameraCom_.aspect / var_219_9.sprite.bounds.size.x and var_219_10 * manager.ui.mainCameraCom_.aspect / var_219_9.sprite.bounds.size.x or var_219_10 / var_219_9.sprite.bounds.size.y, var_219_10 / var_219_9.sprite.bounds.size.y < var_219_10 * manager.ui.mainCameraCom_.aspect / var_219_9.sprite.bounds.size.x and var_219_10 * manager.ui.mainCameraCom_.aspect / var_219_9.sprite.bounds.size.x or var_219_10 / var_219_9.sprite.bounds.size.y, 0)
				end
			end

			local var_219_11 = 3

			if var_219_7 <= arg_216_1.time_ and arg_216_1.time_ < var_219_7 + var_219_11 then
				local var_219_12 = Color.New(1, 1, 1)

				var_219_12.a = Mathf.Lerp(1, 0, (arg_216_1.time_ - var_219_7) / var_219_11)

				var_219_8:GetComponent("SpriteRenderer").material:SetColor("_Color", var_219_12)
			end

			local var_219_13 = 0

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_13 + arg_219_0 then
				arg_216_1.allBtn_.enabled = false
			end

			if arg_216_1.time_ >= var_219_13 + 3.01666666666667 and arg_216_1.time_ < var_219_13 + 3.01666666666667 + arg_219_0 then
				arg_216_1.allBtn_.enabled = true
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_14 = 3.01666666666667
			local var_219_15 = 0.875

			if 3.01666666666667 < arg_216_1.time_ and arg_216_1.time_ <= var_219_14 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_16 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_16:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_17 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(112211054).content)

				arg_216_1.text_.text = var_219_17

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_19 = 35 <= 0 and var_219_15 or var_219_15 * (utf8.len(var_219_17) / 35)

				if (35 <= 0 and var_219_15 or var_219_15 * (utf8.len(var_219_17) / 35)) > 0 and var_219_15 < var_219_19 then
					arg_216_1.talkMaxDuration = var_219_19
					var_219_14 = var_219_14 + 0.3

					if var_219_19 + var_219_14 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_19 + var_219_14
					end
				end

				arg_216_1.text_.text = var_219_17
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_20 = var_219_14 + 0.3
			local var_219_21 = math.max(var_219_15, arg_216_1.talkMaxDuration)

			if var_219_14 + 0.3 <= arg_216_1.time_ and arg_216_1.time_ < var_219_20 + var_219_21 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_20) / var_219_21

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_20 + var_219_21 and arg_216_1.time_ < var_219_20 + var_219_21 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play112211055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 112211055
		arg_222_1.duration_ = 3.5

		local var_222_0 = {
			ja = 3.5,
			ko = 2.533,
			zh = 2.933,
			en = 2.833
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play112211056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1084ui_story = arg_222_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1084ui_story"].transform.position).z)
				arg_222_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1084ui_story"].transform.localEulerAngles = arg_222_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_222_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1084ui_story"].transform.position).z)
				arg_222_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1084ui_story"].transform.localEulerAngles = arg_222_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["1084ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1084ui_story == nil then
				arg_222_1.var_.characterEffect1084ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect1084ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect1084ui_story then
				arg_222_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_225_4 = 0
			local var_225_5 = 0.25

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(112211055)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 10 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 10)

				if (10 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 10)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211055", "story_v_out_112211.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211055", "story_v_out_112211.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_out_112211", "112211055", "story_v_out_112211.awb")

						arg_222_1:RecordAudio("112211055", var_225_11)
						arg_222_1:RecordAudio("112211055", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_112211", "112211055", "story_v_out_112211.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_112211", "112211055", "story_v_out_112211.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play112211056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 112211056
		arg_226_1.duration_ = 8.87

		local var_226_0 = {
			ja = 8.866,
			ko = 8.333,
			zh = 6.066,
			en = 8.066
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play112211057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = arg_226_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1027ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1027ui_story = var_229_1.localPosition
			end

			local var_229_2 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 then
				var_229_1.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_226_1.time_ - 0) / var_229_2)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 then
				var_229_1.localPosition = Vector3.New(0, -0.81, -5.8)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			local var_229_3 = arg_226_1.actors_["1027ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect1027ui_story == nil then
				arg_226_1.var_.characterEffect1027ui_story = var_229_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_4 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 and not isNil(var_229_3) then
				if arg_226_1.var_.characterEffect1027ui_story and not isNil(var_229_3) then
					arg_226_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect1027ui_story then
				arg_226_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_229_6 = 0
			local var_229_7 = 0.75

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_8 = arg_226_1:GetWordFromCfg(112211056)
				local var_229_9 = arg_226_1:FormatText(var_229_8.content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 29 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 29)

				if (29 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 29)) > 0 and var_229_7 < var_229_11 then
					arg_226_1.talkMaxDuration = var_229_11

					if var_229_11 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211056", "story_v_out_112211.awb") ~= 0 then
					local var_229_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211056", "story_v_out_112211.awb") / 1000

					if var_229_12 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_6
					end

					if var_229_8.prefab_name ~= "" and arg_226_1.actors_[var_229_8.prefab_name] ~= nil then
						local var_229_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_8.prefab_name].transform, "story_v_out_112211", "112211056", "story_v_out_112211.awb")

						arg_226_1:RecordAudio("112211056", var_229_13)
						arg_226_1:RecordAudio("112211056", var_229_13)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_112211", "112211056", "story_v_out_112211.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_112211", "112211056", "story_v_out_112211.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play112211057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 112211057
		arg_230_1.duration_ = 15.47

		local var_230_0 = {
			ja = 9.433,
			ko = 8.333,
			zh = 10.033,
			en = 15.466
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play112211058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1027ui_story = arg_230_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1027ui_story"].transform.position).z)
				arg_230_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1027ui_story"].transform.localEulerAngles = arg_230_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1027ui_story"].transform.position).z)
				arg_230_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1027ui_story"].transform.localEulerAngles = arg_230_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1148ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1148ui_story = var_233_1.localPosition
			end

			local var_233_2 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 then
				var_233_1.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_230_1.time_ - 0) / var_233_2)
				var_233_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_1.position).x, (manager.ui.mainCamera.transform.position - var_233_1.position).y, (manager.ui.mainCamera.transform.position - var_233_1.position).z)
				var_233_1.localEulerAngles.z = 0
				var_233_1.localEulerAngles.x = 0
				var_233_1.localEulerAngles = var_233_1.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 then
				var_233_1.localPosition = Vector3.New(0, -0.8, -6.2)
				var_233_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_1.position).x, (manager.ui.mainCamera.transform.position - var_233_1.position).y, (manager.ui.mainCamera.transform.position - var_233_1.position).z)
				var_233_1.localEulerAngles.z = 0
				var_233_1.localEulerAngles.x = 0
				var_233_1.localEulerAngles = var_233_1.localEulerAngles
			end

			local var_233_3 = arg_230_1.actors_["1148ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_3) and arg_230_1.var_.characterEffect1148ui_story == nil then
				arg_230_1.var_.characterEffect1148ui_story = var_233_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_4 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 and not isNil(var_233_3) then
				if arg_230_1.var_.characterEffect1148ui_story and not isNil(var_233_3) then
					arg_230_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 and not isNil(var_233_3) and arg_230_1.var_.characterEffect1148ui_story then
				arg_230_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_233_6 = 0
			local var_233_7 = 1.25

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_8 = arg_230_1:GetWordFromCfg(112211057)
				local var_233_9 = arg_230_1:FormatText(var_233_8.content)

				arg_230_1.text_.text = var_233_9

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 50 <= 0 and var_233_7 or var_233_7 * (utf8.len(var_233_9) / 50)

				if (50 <= 0 and var_233_7 or var_233_7 * (utf8.len(var_233_9) / 50)) > 0 and var_233_7 < var_233_11 then
					arg_230_1.talkMaxDuration = var_233_11

					if var_233_11 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_9
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211057", "story_v_out_112211.awb") ~= 0 then
					local var_233_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211057", "story_v_out_112211.awb") / 1000

					if var_233_12 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_6
					end

					if var_233_8.prefab_name ~= "" and arg_230_1.actors_[var_233_8.prefab_name] ~= nil then
						local var_233_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_8.prefab_name].transform, "story_v_out_112211", "112211057", "story_v_out_112211.awb")

						arg_230_1:RecordAudio("112211057", var_233_13)
						arg_230_1:RecordAudio("112211057", var_233_13)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_112211", "112211057", "story_v_out_112211.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_112211", "112211057", "story_v_out_112211.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_14 and arg_230_1.time_ < var_233_6 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play112211058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 112211058
		arg_234_1.duration_ = 7.17

		local var_234_0 = {
			ja = 7.166,
			ko = 4.533,
			zh = 4,
			en = 4.1
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play112211059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1148ui_story = arg_234_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1148ui_story"].transform.position).z)
				arg_234_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1148ui_story"].transform.localEulerAngles = arg_234_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1148ui_story"].transform.position).z)
				arg_234_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1148ui_story"].transform.localEulerAngles = arg_234_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["1081ui_story"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1081ui_story = var_237_1.localPosition
			end

			local var_237_2 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 then
				var_237_1.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_234_1.time_ - 0) / var_237_2)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 then
				var_237_1.localPosition = Vector3.New(0, -0.92, -5.8)
				var_237_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_237_1.position).x, (manager.ui.mainCamera.transform.position - var_237_1.position).y, (manager.ui.mainCamera.transform.position - var_237_1.position).z)
				var_237_1.localEulerAngles.z = 0
				var_237_1.localEulerAngles.x = 0
				var_237_1.localEulerAngles = var_237_1.localEulerAngles
			end

			local var_237_3 = arg_234_1.actors_["1081ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1081ui_story == nil then
				arg_234_1.var_.characterEffect1081ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect1081ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1081ui_story then
				arg_234_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_237_6 = 0
			local var_237_7 = 0.4

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(112211058)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 16 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 16)

				if (16 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 16)) > 0 and var_237_7 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211058", "story_v_out_112211.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211058", "story_v_out_112211.awb") / 1000

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end

					if var_237_8.prefab_name ~= "" and arg_234_1.actors_[var_237_8.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_8.prefab_name].transform, "story_v_out_112211", "112211058", "story_v_out_112211.awb")

						arg_234_1:RecordAudio("112211058", var_237_13)
						arg_234_1:RecordAudio("112211058", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_112211", "112211058", "story_v_out_112211.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_112211", "112211058", "story_v_out_112211.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play112211059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 112211059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play112211060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1081ui_story = arg_238_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1081ui_story"].transform.position).z)
				arg_238_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1081ui_story"].transform.localEulerAngles = arg_238_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1081ui_story"].transform.position).z)
				arg_238_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1081ui_story"].transform.localEulerAngles = arg_238_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_241_1 = 0
			local var_241_2 = 0.625

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(112211059).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 25 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 25)

				if (25 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 25)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play112211060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 112211060
		arg_242_1.duration_ = 4.73

		local var_242_0 = {
			ja = 4.733,
			ko = 3.1,
			zh = 3.433,
			en = 2.9
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play112211061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1039ui_story = arg_242_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1039ui_story"].transform.position).z)
				arg_242_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1039ui_story"].transform.localEulerAngles = arg_242_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_242_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1039ui_story"].transform.position).z)
				arg_242_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1039ui_story"].transform.localEulerAngles = arg_242_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1039ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1039ui_story == nil then
				arg_242_1.var_.characterEffect1039ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1039ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1039ui_story then
				arg_242_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_245_4 = 0
			local var_245_5 = 0.25

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(112211060)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 10 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 10)

				if (10 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 10)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211060", "story_v_out_112211.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211060", "story_v_out_112211.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_112211", "112211060", "story_v_out_112211.awb")

						arg_242_1:RecordAudio("112211060", var_245_11)
						arg_242_1:RecordAudio("112211060", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_112211", "112211060", "story_v_out_112211.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_112211", "112211060", "story_v_out_112211.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play112211061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 112211061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play112211062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1039ui_story"]) and arg_246_1.var_.characterEffect1039ui_story == nil then
				arg_246_1.var_.characterEffect1039ui_story = arg_246_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1039ui_story"]) then
				if arg_246_1.var_.characterEffect1039ui_story and not isNil(arg_246_1.actors_["1039ui_story"]) then
					arg_246_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1039ui_story"]) and arg_246_1.var_.characterEffect1039ui_story then
				arg_246_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.1

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(112211061).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 4 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 4)

				if (4 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 4)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play112211062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 112211062
		arg_250_1.duration_ = 5.57

		local var_250_0 = {
			ja = 5.566,
			ko = 3.833,
			zh = 4.8,
			en = 5.233
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play112211063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1039ui_story"]) and arg_250_1.var_.characterEffect1039ui_story == nil then
				arg_250_1.var_.characterEffect1039ui_story = arg_250_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1039ui_story"]) then
				if arg_250_1.var_.characterEffect1039ui_story and not isNil(arg_250_1.actors_["1039ui_story"]) then
					arg_250_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1039ui_story"]) and arg_250_1.var_.characterEffect1039ui_story then
				arg_250_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_253_2 = 0
			local var_253_3 = 0.55

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(112211062)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 22 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 22)

				if (22 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 22)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211062", "story_v_out_112211.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_out_112211", "112211062", "story_v_out_112211.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_out_112211", "112211062", "story_v_out_112211.awb")

						arg_250_1:RecordAudio("112211062", var_253_9)
						arg_250_1:RecordAudio("112211062", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_112211", "112211062", "story_v_out_112211.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_112211", "112211062", "story_v_out_112211.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play112211063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 112211063
		arg_254_1.duration_ = 4.33

		local var_254_0 = {
			ja = 3.633,
			ko = 4.333,
			zh = 4.233,
			en = 3.533
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play112211064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1039ui_story = arg_254_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1039ui_story"].transform.position).z)
				arg_254_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1039ui_story"].transform.localEulerAngles = arg_254_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1039ui_story"].transform.position).z)
				arg_254_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1039ui_story"].transform.localEulerAngles = arg_254_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1084ui_story"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1084ui_story = var_257_1.localPosition
			end

			local var_257_2 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 then
				var_257_1.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_254_1.time_ - 0) / var_257_2)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 then
				var_257_1.localPosition = Vector3.New(0, -0.97, -6)
				var_257_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_257_1.position).x, (manager.ui.mainCamera.transform.position - var_257_1.position).y, (manager.ui.mainCamera.transform.position - var_257_1.position).z)
				var_257_1.localEulerAngles.z = 0
				var_257_1.localEulerAngles.x = 0
				var_257_1.localEulerAngles = var_257_1.localEulerAngles
			end

			local var_257_3 = arg_254_1.actors_["1084ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_4 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 and not isNil(var_257_3) then
				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_3) then
					arg_254_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect1084ui_story then
				arg_254_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_257_6 = 0
			local var_257_7 = 0.525

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(112211063)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 21 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 21)

				if (21 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 21)) > 0 and var_257_7 < var_257_11 then
					arg_254_1.talkMaxDuration = var_257_11

					if var_257_11 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211063", "story_v_out_112211.awb") ~= 0 then
					local var_257_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211063", "story_v_out_112211.awb") / 1000

					if var_257_12 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_6
					end

					if var_257_8.prefab_name ~= "" and arg_254_1.actors_[var_257_8.prefab_name] ~= nil then
						local var_257_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_8.prefab_name].transform, "story_v_out_112211", "112211063", "story_v_out_112211.awb")

						arg_254_1:RecordAudio("112211063", var_257_13)
						arg_254_1:RecordAudio("112211063", var_257_13)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_112211", "112211063", "story_v_out_112211.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_112211", "112211063", "story_v_out_112211.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play112211064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 112211064
		arg_258_1.duration_ = 5.4

		local var_258_0 = {
			ja = 4.566,
			ko = 3.333,
			zh = 5.4,
			en = 4.2
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play112211065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = arg_258_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).z)
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles = arg_258_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1084ui_story"].transform.position).z)
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1084ui_story"].transform.localEulerAngles = arg_258_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1027ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1027ui_story = var_261_1.localPosition
			end

			local var_261_2 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 then
				var_261_1.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_258_1.time_ - 0) / var_261_2)
				var_261_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_1.position).x, (manager.ui.mainCamera.transform.position - var_261_1.position).y, (manager.ui.mainCamera.transform.position - var_261_1.position).z)
				var_261_1.localEulerAngles.z = 0
				var_261_1.localEulerAngles.x = 0
				var_261_1.localEulerAngles = var_261_1.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 then
				var_261_1.localPosition = Vector3.New(0, -0.81, -5.8)
				var_261_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_1.position).x, (manager.ui.mainCamera.transform.position - var_261_1.position).y, (manager.ui.mainCamera.transform.position - var_261_1.position).z)
				var_261_1.localEulerAngles.z = 0
				var_261_1.localEulerAngles.x = 0
				var_261_1.localEulerAngles = var_261_1.localEulerAngles
			end

			local var_261_3 = arg_258_1.actors_["1027ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect1027ui_story == nil then
				arg_258_1.var_.characterEffect1027ui_story = var_261_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_4 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 and not isNil(var_261_3) then
				if arg_258_1.var_.characterEffect1027ui_story and not isNil(var_261_3) then
					arg_258_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect1027ui_story then
				arg_258_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_261_6 = 0
			local var_261_7 = 0.225

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_6 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(112211064)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_11 = 9 <= 0 and var_261_7 or var_261_7 * (utf8.len(var_261_9) / 9)

				if (9 <= 0 and var_261_7 or var_261_7 * (utf8.len(var_261_9) / 9)) > 0 and var_261_7 < var_261_11 then
					arg_258_1.talkMaxDuration = var_261_11

					if var_261_11 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_11 + var_261_6
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211064", "story_v_out_112211.awb") ~= 0 then
					local var_261_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211064", "story_v_out_112211.awb") / 1000

					if var_261_12 + var_261_6 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_6
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_out_112211", "112211064", "story_v_out_112211.awb")

						arg_258_1:RecordAudio("112211064", var_261_13)
						arg_258_1:RecordAudio("112211064", var_261_13)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_112211", "112211064", "story_v_out_112211.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_112211", "112211064", "story_v_out_112211.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_7, arg_258_1.talkMaxDuration)

			if var_261_6 <= arg_258_1.time_ and arg_258_1.time_ < var_261_6 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_6) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_6 + var_261_14 and arg_258_1.time_ < var_261_6 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play112211065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 112211065
		arg_262_1.duration_ = 3.2

		local var_262_0 = {
			ja = 3.2,
			ko = 2.7,
			zh = 2.733,
			en = 2.266
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play112211066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1027ui_story = arg_262_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_265_0 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 then
				arg_262_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_0)
				arg_262_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1027ui_story"].transform.position).z)
				arg_262_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1027ui_story"].transform.localEulerAngles = arg_262_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 then
				arg_262_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["1027ui_story"].transform.position).z)
				arg_262_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["1027ui_story"].transform.localEulerAngles = arg_262_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_265_1 = arg_262_1.actors_["1148ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1148ui_story = var_265_1.localPosition
			end

			local var_265_2 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 then
				var_265_1.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_262_1.time_ - 0) / var_265_2)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 then
				var_265_1.localPosition = Vector3.New(0, -0.8, -6.2)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			local var_265_3 = arg_262_1.actors_["1148ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect1148ui_story == nil then
				arg_262_1.var_.characterEffect1148ui_story = var_265_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_4 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 and not isNil(var_265_3) then
				if arg_262_1.var_.characterEffect1148ui_story and not isNil(var_265_3) then
					arg_262_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect1148ui_story then
				arg_262_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_265_6 = 0
			local var_265_7 = 0.2

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_8 = arg_262_1:GetWordFromCfg(112211065)
				local var_265_9 = arg_262_1:FormatText(var_265_8.content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 8 <= 0 and var_265_7 or var_265_7 * (utf8.len(var_265_9) / 8)

				if (8 <= 0 and var_265_7 or var_265_7 * (utf8.len(var_265_9) / 8)) > 0 and var_265_7 < var_265_11 then
					arg_262_1.talkMaxDuration = var_265_11

					if var_265_11 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211065", "story_v_out_112211.awb") ~= 0 then
					local var_265_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211065", "story_v_out_112211.awb") / 1000

					if var_265_12 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_6
					end

					if var_265_8.prefab_name ~= "" and arg_262_1.actors_[var_265_8.prefab_name] ~= nil then
						local var_265_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_8.prefab_name].transform, "story_v_out_112211", "112211065", "story_v_out_112211.awb")

						arg_262_1:RecordAudio("112211065", var_265_13)
						arg_262_1:RecordAudio("112211065", var_265_13)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_112211", "112211065", "story_v_out_112211.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_112211", "112211065", "story_v_out_112211.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_14 and arg_262_1.time_ < var_265_6 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play112211066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 112211066
		arg_266_1.duration_ = 3.2

		local var_266_0 = {
			ja = 2.7,
			ko = 2.166,
			zh = 3.033,
			en = 3.2
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play112211067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1148ui_story = arg_266_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1148ui_story"].transform.position).z)
				arg_266_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1148ui_story"].transform.localEulerAngles = arg_266_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1148ui_story"].transform.position).z)
				arg_266_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1148ui_story"].transform.localEulerAngles = arg_266_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1081ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1081ui_story = var_269_1.localPosition
			end

			local var_269_2 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 then
				var_269_1.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_266_1.time_ - 0) / var_269_2)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 then
				var_269_1.localPosition = Vector3.New(0, -0.92, -5.8)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			local var_269_3 = arg_266_1.actors_["1081ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect1081ui_story == nil then
				arg_266_1.var_.characterEffect1081ui_story = var_269_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_4 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 and not isNil(var_269_3) then
				if arg_266_1.var_.characterEffect1081ui_story and not isNil(var_269_3) then
					arg_266_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect1081ui_story then
				arg_266_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_269_6 = 0
			local var_269_7 = 0.25

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:GetWordFromCfg(112211066)
				local var_269_9 = arg_266_1:FormatText(var_269_8.content)

				arg_266_1.text_.text = var_269_9

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_11 = 10 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_9) / 10)

				if (10 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_9) / 10)) > 0 and var_269_7 < var_269_11 then
					arg_266_1.talkMaxDuration = var_269_11

					if var_269_11 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_9
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211066", "story_v_out_112211.awb") ~= 0 then
					local var_269_12 = manager.audio:GetVoiceLength("story_v_out_112211", "112211066", "story_v_out_112211.awb") / 1000

					if var_269_12 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_12 + var_269_6
					end

					if var_269_8.prefab_name ~= "" and arg_266_1.actors_[var_269_8.prefab_name] ~= nil then
						local var_269_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_8.prefab_name].transform, "story_v_out_112211", "112211066", "story_v_out_112211.awb")

						arg_266_1:RecordAudio("112211066", var_269_13)
						arg_266_1:RecordAudio("112211066", var_269_13)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_112211", "112211066", "story_v_out_112211.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_112211", "112211066", "story_v_out_112211.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_14 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_14 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_14

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_14 and arg_266_1.time_ < var_269_6 + var_269_14 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play112211067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 112211067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play112211068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1081ui_story = arg_270_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1081ui_story"].transform.position).z)
				arg_270_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1081ui_story"].transform.localEulerAngles = arg_270_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1081ui_story"].transform.position).z)
				arg_270_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1081ui_story"].transform.localEulerAngles = arg_270_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_273_1 = 0
			local var_273_2 = 0.825

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(112211067).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 33 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 33)

				if (33 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 33)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play112211068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 112211068
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play112211069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0.65

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(112211068).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 26 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 26)

				if (26 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 26)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play112211069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 112211069
		arg_278_1.duration_ = 5.5

		local var_278_0 = {
			ja = 3.433,
			ko = 4.366,
			zh = 4.466,
			en = 5.5
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play112211070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1039ui_story = arg_278_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1039ui_story"].transform.position).z)
				arg_278_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1039ui_story"].transform.localEulerAngles = arg_278_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_278_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1039ui_story"].transform.position).z)
				arg_278_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1039ui_story"].transform.localEulerAngles = arg_278_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1039ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1039ui_story == nil then
				arg_278_1.var_.characterEffect1039ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1039ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1039ui_story then
				arg_278_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_281_4 = 0
			local var_281_5 = 0.275

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(112211069)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 11 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 11)

				if (11 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 11)) > 0 and var_281_5 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211069", "story_v_out_112211.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_out_112211", "112211069", "story_v_out_112211.awb") / 1000

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end

					if var_281_6.prefab_name ~= "" and arg_278_1.actors_[var_281_6.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_6.prefab_name].transform, "story_v_out_112211", "112211069", "story_v_out_112211.awb")

						arg_278_1:RecordAudio("112211069", var_281_11)
						arg_278_1:RecordAudio("112211069", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_112211", "112211069", "story_v_out_112211.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_112211", "112211069", "story_v_out_112211.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_5, arg_278_1.talkMaxDuration)

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_4) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_4 + var_281_12 and arg_278_1.time_ < var_281_4 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play112211070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 112211070
		arg_282_1.duration_ = 15.67

		local var_282_0 = {
			ja = 15.666,
			ko = 9.933,
			zh = 11.133,
			en = 13.9
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play112211071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_285_0 = 0
			local var_285_1 = 1.225

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(112211070)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 49 <= 0 and var_285_1 or var_285_1 * (utf8.len(var_285_3) / 49)

				if (49 <= 0 and var_285_1 or var_285_1 * (utf8.len(var_285_3) / 49)) > 0 and var_285_1 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211070", "story_v_out_112211.awb") ~= 0 then
					local var_285_6 = manager.audio:GetVoiceLength("story_v_out_112211", "112211070", "story_v_out_112211.awb") / 1000

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end

					if var_285_2.prefab_name ~= "" and arg_282_1.actors_[var_285_2.prefab_name] ~= nil then
						local var_285_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_2.prefab_name].transform, "story_v_out_112211", "112211070", "story_v_out_112211.awb")

						arg_282_1:RecordAudio("112211070", var_285_7)
						arg_282_1:RecordAudio("112211070", var_285_7)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_112211", "112211070", "story_v_out_112211.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_112211", "112211070", "story_v_out_112211.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_8 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_8 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_8

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_8 and arg_282_1.time_ < var_285_0 + var_285_8 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play112211071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 112211071
		arg_286_1.duration_ = 15.43

		local var_286_0 = {
			ja = 15.433,
			ko = 7.766,
			zh = 7.3,
			en = 8.3
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play112211072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action465")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_289_0 = 0
			local var_289_1 = 0.925

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_2 = arg_286_1:GetWordFromCfg(112211071)
				local var_289_3 = arg_286_1:FormatText(var_289_2.content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 37 <= 0 and var_289_1 or var_289_1 * (utf8.len(var_289_3) / 37)

				if (37 <= 0 and var_289_1 or var_289_1 * (utf8.len(var_289_3) / 37)) > 0 and var_289_1 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211071", "story_v_out_112211.awb") ~= 0 then
					local var_289_6 = manager.audio:GetVoiceLength("story_v_out_112211", "112211071", "story_v_out_112211.awb") / 1000

					if var_289_6 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_6 + var_289_0
					end

					if var_289_2.prefab_name ~= "" and arg_286_1.actors_[var_289_2.prefab_name] ~= nil then
						local var_289_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_2.prefab_name].transform, "story_v_out_112211", "112211071", "story_v_out_112211.awb")

						arg_286_1:RecordAudio("112211071", var_289_7)
						arg_286_1:RecordAudio("112211071", var_289_7)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_112211", "112211071", "story_v_out_112211.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_112211", "112211071", "story_v_out_112211.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_8 and arg_286_1.time_ < var_289_0 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play112211072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 112211072
		arg_290_1.duration_ = 4.1

		local var_290_0 = {
			ja = 4.1,
			ko = 3.1,
			zh = 2.3,
			en = 2.9
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play112211073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_293_0 = 0
			local var_293_1 = 0.225

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(112211072)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 9 <= 0 and var_293_1 or var_293_1 * (utf8.len(var_293_3) / 9)

				if (9 <= 0 and var_293_1 or var_293_1 * (utf8.len(var_293_3) / 9)) > 0 and var_293_1 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112211", "112211072", "story_v_out_112211.awb") ~= 0 then
					local var_293_6 = manager.audio:GetVoiceLength("story_v_out_112211", "112211072", "story_v_out_112211.awb") / 1000

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end

					if var_293_2.prefab_name ~= "" and arg_290_1.actors_[var_293_2.prefab_name] ~= nil then
						local var_293_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_2.prefab_name].transform, "story_v_out_112211", "112211072", "story_v_out_112211.awb")

						arg_290_1:RecordAudio("112211072", var_293_7)
						arg_290_1:RecordAudio("112211072", var_293_7)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_112211", "112211072", "story_v_out_112211.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_112211", "112211072", "story_v_out_112211.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play112211073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 112211073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play112211074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1039ui_story = arg_294_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1039ui_story"].transform.position).z)
				arg_294_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1039ui_story"].transform.localEulerAngles = arg_294_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["1039ui_story"].transform.position).z)
				arg_294_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["1039ui_story"].transform.localEulerAngles = arg_294_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_297_1 = 0
			local var_297_2 = 0.8

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(112211073).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 32 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 32)

				if (32 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 32)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play112211074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 112211074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
			arg_298_1.auto_ = false
		end

		function arg_298_1.playNext_(arg_300_0)
			arg_298_1.onStoryFinished_()
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.475

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(112211074).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 19 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 19)

				if (19 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 19)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02a"
	},
	voices = {
		"story_v_out_112211.awb"
	}
}
