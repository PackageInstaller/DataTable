return {
	Play414081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414081001
		arg_1_1.duration_ = 6.7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02")
				var_4_0.name = "H02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H02

				arg_1_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H02" then
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

			local var_4_8 = "1015ui_story"

			if arg_1_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1015ui_story"].transform

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 then
				arg_1_1.var_.moveOldPos1015ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.7 <= arg_1_1.time_ and arg_1_1.time_ < 1.7 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_1_1.time_ - 1.7) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.7 + var_4_13 and arg_1_1.time_ < 1.7 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1015ui_story"]

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1015ui_story == nil then
				arg_1_1.var_.characterEffect1015ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.7 <= arg_1_1.time_ and arg_1_1.time_ < 1.7 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1015ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.7 + var_4_15 and arg_1_1.time_ < 1.7 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1015ui_story then
				arg_1_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 then
				arg_1_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_1")
			end

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= 1.7 + arg_4_0 then
				arg_1_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_relax", "bgm_activity_1_2_summer1_story_relax")

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

			local var_4_23 = 1.7
			local var_4_24 = 0.375

			if 1.7 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[947].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414081001).content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 15 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 15)

				if (15 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 15)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_23 = var_4_23 + 0.3

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_23 + 0.3
			local var_4_30 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play414081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414081002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1017ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1017ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1017ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1017ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1017ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1017ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1017ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1017ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1017ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1017ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1017ui_story == nil then
				arg_9_1.var_.characterEffect1017ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1017ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1017ui_story then
				arg_9_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_12_8 = arg_9_1.actors_["1015ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1015ui_story == nil then
				arg_9_1.var_.characterEffect1015ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1015ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1015ui_story then
				arg_9_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_12_10 = 0
			local var_12_11 = 0.575

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[948].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(414081002).content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 23 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 23)

				if (23 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 23)) > 0 and var_12_11 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_15 and arg_9_1.time_ < var_12_10 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
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
	Play414081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1015ui_story"]) and arg_13_1.var_.characterEffect1015ui_story == nil then
				arg_13_1.var_.characterEffect1015ui_story = arg_13_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1015ui_story"]) then
				if arg_13_1.var_.characterEffect1015ui_story and not isNil(arg_13_1.actors_["1015ui_story"]) then
					arg_13_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1015ui_story"]) and arg_13_1.var_.characterEffect1015ui_story then
				arg_13_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_16_2 = arg_13_1.actors_["1017ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect1017ui_story == nil then
				arg_13_1.var_.characterEffect1017ui_story = var_16_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_3 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.characterEffect1017ui_story and not isNil(var_16_2) then
					arg_13_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_3)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.characterEffect1017ui_story then
				arg_13_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_16_4 = 0
			local var_16_5 = 0.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[947].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(414081003).content)

				arg_13_1.text_.text = var_16_6

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_8 = 17 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_6) / 17)

				if (17 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_6) / 17)) > 0 and var_16_5 < var_16_8 then
					arg_13_1.talkMaxDuration = var_16_8

					if var_16_8 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_6
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_9 and arg_13_1.time_ < var_16_4 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play414081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414081004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1017ui_story = arg_17_1.actors_["1017ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1017ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1017ui_story"].transform.position).z)
				arg_17_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1017ui_story"].transform.localEulerAngles = arg_17_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1017ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_17_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1017ui_story"].transform.position).z)
				arg_17_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1017ui_story"].transform.localEulerAngles = arg_17_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1017ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1017ui_story == nil then
				arg_17_1.var_.characterEffect1017ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1017ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1017ui_story then
				arg_17_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017actionlink/1017action443")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_20_4 = arg_17_1.actors_["1015ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1015ui_story == nil then
				arg_17_1.var_.characterEffect1015ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_5 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_5 and not isNil(var_20_4) then
				if arg_17_1.var_.characterEffect1015ui_story and not isNil(var_20_4) then
					arg_17_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_5)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_5 and arg_17_1.time_ < 0 + var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1015ui_story then
				arg_17_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_20_6 = 0
			local var_20_7 = 0.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[948].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(414081004).content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 8 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 8)

				if (8 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 8)) > 0 and var_20_7 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_11 and arg_17_1.time_ < var_20_6 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play414081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 414081005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play414081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_24_0 = 0
			local var_24_1 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[948].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(414081005).content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 29 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_2) / 29)

				if (29 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_2) / 29)) > 0 and var_24_1 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_5 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_5 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_5

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_5 and arg_21_1.time_ < var_24_0 + var_24_5 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play414081006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 414081006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play414081007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1015ui_story = arg_25_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1015ui_story"].transform.position).z)
				arg_25_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1015ui_story"].transform.localEulerAngles = arg_25_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_25_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1015ui_story"].transform.position).z)
				arg_25_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1015ui_story"].transform.localEulerAngles = arg_25_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1015ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1015ui_story == nil then
				arg_25_1.var_.characterEffect1015ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1015ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1015ui_story then
				arg_25_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_4 = arg_25_1.actors_["1017ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1017ui_story == nil then
				arg_25_1.var_.characterEffect1017ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect1017ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect1017ui_story then
				arg_25_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[947].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(414081006).content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 16 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_8) / 16)

				if (16 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_8) / 16)) > 0 and var_28_7 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_11 and arg_25_1.time_ < var_28_6 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play414081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 414081007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play414081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[947].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(414081007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 11)

				if (11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 11)) > 0 and var_32_0 < var_32_3 then
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
	Play414081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 414081008
		arg_33_1.duration_ = 9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play414081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				local var_36_0 = arg_33_1.bgs_.H02

				arg_33_1.bgs_.H02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_1 = var_36_0:GetComponent("SpriteRenderer")

				if var_36_1 and var_36_1.sprite then
					local var_36_2 = 2 * (var_36_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_0.transform.localScale = Vector3.New(var_36_2 / var_36_1.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x or var_36_2 / var_36_1.sprite.bounds.size.y, var_36_2 / var_36_1.sprite.bounds.size.y < var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x and var_36_2 * manager.ui.mainCameraCom_.aspect / var_36_1.sprite.bounds.size.x or var_36_2 / var_36_1.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "H02" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_3 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_4 = 2

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 then
				local var_36_5 = Color.New(0, 0, 0)

				var_36_5.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_3) / var_36_4)
				arg_33_1.mask_.color = var_36_5
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = 1
				arg_33_1.mask_.color = var_36_6
			end

			local var_36_7 = 2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_8 = 2

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 then
				local var_36_9 = Color.New(0, 0, 0)

				var_36_9.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_7) / var_36_8)
				arg_33_1.mask_.color = var_36_9
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 then
				local var_36_10 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_10.a = 0
				arg_33_1.mask_.color = var_36_10
			end

			local var_36_11 = arg_33_1.actors_["1017ui_story"]

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.characterEffect1017ui_story == nil then
				arg_33_1.var_.characterEffect1017ui_story = var_36_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_12 = 0.200000002980232

			if 3.8 <= arg_33_1.time_ and arg_33_1.time_ < 3.8 + var_36_12 and not isNil(var_36_11) then
				if arg_33_1.var_.characterEffect1017ui_story and not isNil(var_36_11) then
					arg_33_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 3.8 + var_36_12 and arg_33_1.time_ < 3.8 + var_36_12 + arg_36_0 and not isNil(var_36_11) and arg_33_1.var_.characterEffect1017ui_story then
				arg_33_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 then
				arg_33_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action1_1")
			end

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 then
				arg_33_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_14 = arg_33_1.actors_["1015ui_story"]

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1015ui_story == nil then
				arg_33_1.var_.characterEffect1015ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_15 = 0.200000002980232

			if 3.8 <= arg_33_1.time_ and arg_33_1.time_ < 3.8 + var_36_15 and not isNil(var_36_14) then
				if arg_33_1.var_.characterEffect1015ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 3.8) / var_36_15)
				end
			end

			if arg_33_1.time_ >= 3.8 + var_36_15 and arg_33_1.time_ < 3.8 + var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1015ui_story then
				arg_33_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_36_16 = arg_33_1.actors_["1015ui_story"].transform

			if 1.966 < arg_33_1.time_ and arg_33_1.time_ <= 1.966 + arg_36_0 then
				arg_33_1.var_.moveOldPos1015ui_story = var_36_16.localPosition
			end

			local var_36_17 = 0.001

			if 1.966 <= arg_33_1.time_ and arg_33_1.time_ < 1.966 + var_36_17 then
				var_36_16.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 1.966) / var_36_17)
				var_36_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_16.position).x, (manager.ui.mainCamera.transform.position - var_36_16.position).y, (manager.ui.mainCamera.transform.position - var_36_16.position).z)
				var_36_16.localEulerAngles.z = 0
				var_36_16.localEulerAngles.x = 0
				var_36_16.localEulerAngles = var_36_16.localEulerAngles
			end

			if arg_33_1.time_ >= 1.966 + var_36_17 and arg_33_1.time_ < 1.966 + var_36_17 + arg_36_0 then
				var_36_16.localPosition = Vector3.New(0, 100, 0)
				var_36_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_16.position).x, (manager.ui.mainCamera.transform.position - var_36_16.position).y, (manager.ui.mainCamera.transform.position - var_36_16.position).z)
				var_36_16.localEulerAngles.z = 0
				var_36_16.localEulerAngles.x = 0
				var_36_16.localEulerAngles = var_36_16.localEulerAngles
			end

			local var_36_18 = arg_33_1.actors_["1017ui_story"].transform

			if 1.966 < arg_33_1.time_ and arg_33_1.time_ <= 1.966 + arg_36_0 then
				arg_33_1.var_.moveOldPos1017ui_story = var_36_18.localPosition
			end

			local var_36_19 = 0.001

			if 1.966 <= arg_33_1.time_ and arg_33_1.time_ < 1.966 + var_36_19 then
				var_36_18.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 1.966) / var_36_19)
				var_36_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_18.position).x, (manager.ui.mainCamera.transform.position - var_36_18.position).y, (manager.ui.mainCamera.transform.position - var_36_18.position).z)
				var_36_18.localEulerAngles.z = 0
				var_36_18.localEulerAngles.x = 0
				var_36_18.localEulerAngles = var_36_18.localEulerAngles
			end

			if arg_33_1.time_ >= 1.966 + var_36_19 and arg_33_1.time_ < 1.966 + var_36_19 + arg_36_0 then
				var_36_18.localPosition = Vector3.New(0, 100, 0)
				var_36_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_18.position).x, (manager.ui.mainCamera.transform.position - var_36_18.position).y, (manager.ui.mainCamera.transform.position - var_36_18.position).z)
				var_36_18.localEulerAngles.z = 0
				var_36_18.localEulerAngles.x = 0
				var_36_18.localEulerAngles = var_36_18.localEulerAngles
			end

			local var_36_20 = arg_33_1.actors_["1015ui_story"].transform

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 then
				arg_33_1.var_.moveOldPos1015ui_story = var_36_20.localPosition
			end

			local var_36_21 = 0.001

			if 3.8 <= arg_33_1.time_ and arg_33_1.time_ < 3.8 + var_36_21 then
				var_36_20.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_33_1.time_ - 3.8) / var_36_21)
				var_36_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_20.position).x, (manager.ui.mainCamera.transform.position - var_36_20.position).y, (manager.ui.mainCamera.transform.position - var_36_20.position).z)
				var_36_20.localEulerAngles.z = 0
				var_36_20.localEulerAngles.x = 0
				var_36_20.localEulerAngles = var_36_20.localEulerAngles
			end

			if arg_33_1.time_ >= 3.8 + var_36_21 and arg_33_1.time_ < 3.8 + var_36_21 + arg_36_0 then
				var_36_20.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_36_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_20.position).x, (manager.ui.mainCamera.transform.position - var_36_20.position).y, (manager.ui.mainCamera.transform.position - var_36_20.position).z)
				var_36_20.localEulerAngles.z = 0
				var_36_20.localEulerAngles.x = 0
				var_36_20.localEulerAngles = var_36_20.localEulerAngles
			end

			local var_36_22 = arg_33_1.actors_["1017ui_story"].transform

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 then
				arg_33_1.var_.moveOldPos1017ui_story = var_36_22.localPosition
			end

			local var_36_23 = 0.001

			if 3.8 <= arg_33_1.time_ and arg_33_1.time_ < 3.8 + var_36_23 then
				var_36_22.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_33_1.time_ - 3.8) / var_36_23)
				var_36_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_22.position).x, (manager.ui.mainCamera.transform.position - var_36_22.position).y, (manager.ui.mainCamera.transform.position - var_36_22.position).z)
				var_36_22.localEulerAngles.z = 0
				var_36_22.localEulerAngles.x = 0
				var_36_22.localEulerAngles = var_36_22.localEulerAngles
			end

			if arg_33_1.time_ >= 3.8 + var_36_23 and arg_33_1.time_ < 3.8 + var_36_23 + arg_36_0 then
				var_36_22.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_36_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_22.position).x, (manager.ui.mainCamera.transform.position - var_36_22.position).y, (manager.ui.mainCamera.transform.position - var_36_22.position).z)
				var_36_22.localEulerAngles.z = 0
				var_36_22.localEulerAngles.x = 0
				var_36_22.localEulerAngles = var_36_22.localEulerAngles
			end

			if 3.8 < arg_33_1.time_ and arg_33_1.time_ <= 3.8 + arg_36_0 then
				arg_33_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_24 = 4
			local var_36_25 = 0.375

			if 4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_24 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_26 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_26:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_27 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(414081008).content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_29 = 15 <= 0 and var_36_25 or var_36_25 * (utf8.len(var_36_27) / 15)

				if (15 <= 0 and var_36_25 or var_36_25 * (utf8.len(var_36_27) / 15)) > 0 and var_36_25 < var_36_29 then
					arg_33_1.talkMaxDuration = var_36_29
					var_36_24 = var_36_24 + 0.3

					if var_36_29 + var_36_24 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_24
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_30 = var_36_24 + 0.3
			local var_36_31 = math.max(var_36_25, arg_33_1.talkMaxDuration)

			if var_36_24 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_30 + var_36_31 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_30) / var_36_31

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_30 + var_36_31 and arg_33_1.time_ < var_36_30 + var_36_31 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play414081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414081009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1017ui_story"]) and arg_39_1.var_.characterEffect1017ui_story == nil then
				arg_39_1.var_.characterEffect1017ui_story = arg_39_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1017ui_story"]) then
				if arg_39_1.var_.characterEffect1017ui_story and not isNil(arg_39_1.actors_["1017ui_story"]) then
					arg_39_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1017ui_story"]) and arg_39_1.var_.characterEffect1017ui_story then
				arg_39_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.55

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414081009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 22 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 22)

				if (22 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 22)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play414081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414081010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1015ui_story"]) and arg_43_1.var_.characterEffect1015ui_story == nil then
				arg_43_1.var_.characterEffect1015ui_story = arg_43_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1015ui_story"]) then
				if arg_43_1.var_.characterEffect1015ui_story and not isNil(arg_43_1.actors_["1015ui_story"]) then
					arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1015ui_story"]) and arg_43_1.var_.characterEffect1015ui_story then
				arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_2 = 0
			local var_46_3 = 0.4

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(414081010).content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 16 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_4) / 16)

				if (16 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_4) / 16)) > 0 and var_46_3 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_7 and arg_43_1.time_ < var_46_2 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play414081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414081011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["1049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1049ui_story"))) then
				local var_50_0 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_47_1.stage_.transform)

				var_50_0.name = "1049ui_story"
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1049ui_story"] = var_50_0

				local var_50_1 = var_50_0:GetComponentInChildren(typeof(CharacterEffect))

				var_50_1.enabled = true

				local var_50_2 = GameObjectTools.GetOrAddComponent(var_50_0, typeof(DynamicBoneHelper))

				if var_50_2 then
					var_50_2:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_1.transform, false)

				arg_47_1.var_["1049ui_story" .. "Animator"] = var_50_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_["1049ui_story" .. "Animator"].applyRootMotion = true
				arg_47_1.var_["1049ui_story" .. "LipSync"] = var_50_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_3 = arg_47_1.actors_["1049ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1049ui_story = var_50_3.localPosition
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_3.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_47_1.time_ - 0) / var_50_4)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_3.localPosition = Vector3.New(0, -1.2, -6)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			local var_50_5 = arg_47_1.actors_["1049ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1049ui_story == nil then
				arg_47_1.var_.characterEffect1049ui_story = var_50_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.characterEffect1049ui_story and not isNil(var_50_5) then
					arg_47_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1049ui_story then
				arg_47_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_8 = arg_47_1.actors_["1015ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1015ui_story = var_50_8.localPosition
			end

			local var_50_9 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_9 then
				var_50_8.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_9)
				var_50_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_8.position).x, (manager.ui.mainCamera.transform.position - var_50_8.position).y, (manager.ui.mainCamera.transform.position - var_50_8.position).z)
				var_50_8.localEulerAngles.z = 0
				var_50_8.localEulerAngles.x = 0
				var_50_8.localEulerAngles = var_50_8.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_9 and arg_47_1.time_ < 0 + var_50_9 + arg_50_0 then
				var_50_8.localPosition = Vector3.New(0, 100, 0)
				var_50_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_8.position).x, (manager.ui.mainCamera.transform.position - var_50_8.position).y, (manager.ui.mainCamera.transform.position - var_50_8.position).z)
				var_50_8.localEulerAngles.z = 0
				var_50_8.localEulerAngles.x = 0
				var_50_8.localEulerAngles = var_50_8.localEulerAngles
			end

			local var_50_10 = arg_47_1.actors_["1015ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_10) and arg_47_1.var_.characterEffect1015ui_story == nil then
				arg_47_1.var_.characterEffect1015ui_story = var_50_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_11 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_11 and not isNil(var_50_10) then
				if arg_47_1.var_.characterEffect1015ui_story and not isNil(var_50_10) then
					arg_47_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_11)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_11 and arg_47_1.time_ < 0 + var_50_11 + arg_50_0 and not isNil(var_50_10) and arg_47_1.var_.characterEffect1015ui_story then
				arg_47_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_50_12 = arg_47_1.actors_["1017ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1017ui_story = var_50_12.localPosition
			end

			local var_50_13 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_13 then
				var_50_12.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_13)
				var_50_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_12.position).x, (manager.ui.mainCamera.transform.position - var_50_12.position).y, (manager.ui.mainCamera.transform.position - var_50_12.position).z)
				var_50_12.localEulerAngles.z = 0
				var_50_12.localEulerAngles.x = 0
				var_50_12.localEulerAngles = var_50_12.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_13 and arg_47_1.time_ < 0 + var_50_13 + arg_50_0 then
				var_50_12.localPosition = Vector3.New(0, 100, 0)
				var_50_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_12.position).x, (manager.ui.mainCamera.transform.position - var_50_12.position).y, (manager.ui.mainCamera.transform.position - var_50_12.position).z)
				var_50_12.localEulerAngles.z = 0
				var_50_12.localEulerAngles.x = 0
				var_50_12.localEulerAngles = var_50_12.localEulerAngles
			end

			local var_50_14 = arg_47_1.actors_["1017ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_14) and arg_47_1.var_.characterEffect1017ui_story == nil then
				arg_47_1.var_.characterEffect1017ui_story = var_50_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_15 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_15 and not isNil(var_50_14) then
				if arg_47_1.var_.characterEffect1017ui_story and not isNil(var_50_14) then
					arg_47_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_15)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_15 and arg_47_1.time_ < 0 + var_50_15 + arg_50_0 and not isNil(var_50_14) and arg_47_1.var_.characterEffect1017ui_story then
				arg_47_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_50_16 = 0
			local var_50_17 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_18 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(414081011).content)

				arg_47_1.text_.text = var_50_18

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_20 = 9 <= 0 and var_50_17 or var_50_17 * (utf8.len(var_50_18) / 9)

				if (9 <= 0 and var_50_17 or var_50_17 * (utf8.len(var_50_18) / 9)) > 0 and var_50_17 < var_50_20 then
					arg_47_1.talkMaxDuration = var_50_20

					if var_50_20 + var_50_16 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_16
					end
				end

				arg_47_1.text_.text = var_50_18
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_21 = math.max(var_50_17, arg_47_1.talkMaxDuration)

			if var_50_16 <= arg_47_1.time_ and arg_47_1.time_ < var_50_16 + var_50_21 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_16) / var_50_21

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_16 + var_50_21 and arg_47_1.time_ < var_50_16 + var_50_21 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play414081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414081012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play414081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1015ui_story = arg_51_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).z)
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles = arg_51_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_51_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1015ui_story"].transform.position).z)
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1015ui_story"].transform.localEulerAngles = arg_51_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1015ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1015ui_story == nil then
				arg_51_1.var_.characterEffect1015ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1015ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1015ui_story then
				arg_51_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action3_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_4 = arg_51_1.actors_["1049ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1049ui_story = var_54_4.localPosition
			end

			local var_54_5 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				var_54_4.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_5)
				var_54_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_4.position).x, (manager.ui.mainCamera.transform.position - var_54_4.position).y, (manager.ui.mainCamera.transform.position - var_54_4.position).z)
				var_54_4.localEulerAngles.z = 0
				var_54_4.localEulerAngles.x = 0
				var_54_4.localEulerAngles = var_54_4.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				var_54_4.localPosition = Vector3.New(0, 100, 0)
				var_54_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_4.position).x, (manager.ui.mainCamera.transform.position - var_54_4.position).y, (manager.ui.mainCamera.transform.position - var_54_4.position).z)
				var_54_4.localEulerAngles.z = 0
				var_54_4.localEulerAngles.x = 0
				var_54_4.localEulerAngles = var_54_4.localEulerAngles
			end

			local var_54_6 = arg_51_1.actors_["1049ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1049ui_story == nil then
				arg_51_1.var_.characterEffect1049ui_story = var_54_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_7 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 and not isNil(var_54_6) then
				if arg_51_1.var_.characterEffect1049ui_story and not isNil(var_54_6) then
					arg_51_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_7)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 and not isNil(var_54_6) and arg_51_1.var_.characterEffect1049ui_story then
				arg_51_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_54_8 = 0
			local var_54_9 = 1.075

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(414081012).content)

				arg_51_1.text_.text = var_54_10

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_12 = 43 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_10) / 43)

				if (43 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_10) / 43)) > 0 and var_54_9 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_10
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_13 and arg_51_1.time_ < var_54_8 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play414081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 414081013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play414081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1015ui_story"]) and arg_55_1.var_.characterEffect1015ui_story == nil then
				arg_55_1.var_.characterEffect1015ui_story = arg_55_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1015ui_story"]) then
				if arg_55_1.var_.characterEffect1015ui_story and not isNil(arg_55_1.actors_["1015ui_story"]) then
					arg_55_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1015ui_story"]) and arg_55_1.var_.characterEffect1015ui_story then
				arg_55_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.4

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(414081013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 16 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 16)

				if (16 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 16)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play414081014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 414081014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play414081015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) and arg_59_1.var_.characterEffect1015ui_story == nil then
				arg_59_1.var_.characterEffect1015ui_story = arg_59_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) then
				if arg_59_1.var_.characterEffect1015ui_story and not isNil(arg_59_1.actors_["1015ui_story"]) then
					arg_59_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) and arg_59_1.var_.characterEffect1015ui_story then
				arg_59_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action3_2")
			end

			local var_62_2 = 0
			local var_62_3 = 0.75

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(414081014).content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 30 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_4) / 30)

				if (30 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_4) / 30)) > 0 and var_62_3 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_7 and arg_59_1.time_ < var_62_2 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play414081015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 414081015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play414081016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1017ui_story = arg_63_1.actors_["1017ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1017ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1017ui_story"].transform.position).z)
				arg_63_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1017ui_story"].transform.localEulerAngles = arg_63_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1017ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_63_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1017ui_story"].transform.position).z)
				arg_63_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1017ui_story"].transform.localEulerAngles = arg_63_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1017ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1017ui_story == nil then
				arg_63_1.var_.characterEffect1017ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1017ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1017ui_story then
				arg_63_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action7_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_66_4 = arg_63_1.actors_["1015ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1015ui_story == nil then
				arg_63_1.var_.characterEffect1015ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_5 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_5 and not isNil(var_66_4) then
				if arg_63_1.var_.characterEffect1015ui_story and not isNil(var_66_4) then
					arg_63_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_5)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_5 and arg_63_1.time_ < 0 + var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1015ui_story then
				arg_63_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_66_6 = 0
			local var_66_7 = 0.65

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(414081015).content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 26 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_8) / 26)

				if (26 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_8) / 26)) > 0 and var_66_7 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_11 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_11 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_11

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_11 and arg_63_1.time_ < var_66_6 + var_66_11 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play414081016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 414081016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play414081017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1015ui_story"]) and arg_67_1.var_.characterEffect1015ui_story == nil then
				arg_67_1.var_.characterEffect1015ui_story = arg_67_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1015ui_story"]) then
				if arg_67_1.var_.characterEffect1015ui_story and not isNil(arg_67_1.actors_["1015ui_story"]) then
					arg_67_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1015ui_story"]) and arg_67_1.var_.characterEffect1015ui_story then
				arg_67_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_70_2 = arg_67_1.actors_["1017ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect1017ui_story == nil then
				arg_67_1.var_.characterEffect1017ui_story = var_70_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_3 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.characterEffect1017ui_story and not isNil(var_70_2) then
					arg_67_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_3)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect1017ui_story then
				arg_67_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_70_4 = 0
			local var_70_5 = 0.425

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(414081016).content)

				arg_67_1.text_.text = var_70_6

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 17 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_6) / 17)

				if (17 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_6) / 17)) > 0 and var_70_5 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_6
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_9 and arg_67_1.time_ < var_70_4 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play414081017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 414081017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play414081018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1017ui_story"]) and arg_71_1.var_.characterEffect1017ui_story == nil then
				arg_71_1.var_.characterEffect1017ui_story = arg_71_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1017ui_story"]) then
				if arg_71_1.var_.characterEffect1017ui_story and not isNil(arg_71_1.actors_["1017ui_story"]) then
					arg_71_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1017ui_story"]) and arg_71_1.var_.characterEffect1017ui_story then
				arg_71_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_74_2 = arg_71_1.actors_["1015ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1015ui_story == nil then
				arg_71_1.var_.characterEffect1015ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect1015ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1015ui_story then
				arg_71_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action7_2")
			end

			local var_74_4 = 0
			local var_74_5 = 1.325

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(414081017).content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 53 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_6) / 53)

				if (53 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_6) / 53)) > 0 and var_74_5 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8

					if var_74_8 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_9 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_9

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_9 and arg_71_1.time_ < var_74_4 + var_74_9 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play414081018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 414081018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play414081019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_78_0 = 0
			local var_78_1 = 0.625

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(414081018).content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 25 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_2) / 25)

				if (25 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_2) / 25)) > 0 and var_78_1 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_5 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_5 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_5

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_5 and arg_75_1.time_ < var_78_0 + var_78_5 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play414081019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 414081019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play414081020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1049ui_story = arg_79_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1049ui_story, Vector3.New(0, -1.2, -6), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1049ui_story"].transform.position).z)
				arg_79_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1049ui_story"].transform.localEulerAngles = arg_79_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_79_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1049ui_story"].transform.position).z)
				arg_79_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1049ui_story"].transform.localEulerAngles = arg_79_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1049ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1049ui_story == nil then
				arg_79_1.var_.characterEffect1049ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1049ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1049ui_story then
				arg_79_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action3_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_4 = arg_79_1.actors_["1015ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1015ui_story = var_82_4.localPosition
			end

			local var_82_5 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_5)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0, 100, 0)
				var_82_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_4.position).x, (manager.ui.mainCamera.transform.position - var_82_4.position).y, (manager.ui.mainCamera.transform.position - var_82_4.position).z)
				var_82_4.localEulerAngles.z = 0
				var_82_4.localEulerAngles.x = 0
				var_82_4.localEulerAngles = var_82_4.localEulerAngles
			end

			local var_82_6 = arg_79_1.actors_["1015ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1015ui_story == nil then
				arg_79_1.var_.characterEffect1015ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_7 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 and not isNil(var_82_6) then
				if arg_79_1.var_.characterEffect1015ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_7)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1015ui_story then
				arg_79_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_82_8 = arg_79_1.actors_["1017ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1017ui_story = var_82_8.localPosition
			end

			local var_82_9 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_9 then
				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_9)
				var_82_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_8.position).x, (manager.ui.mainCamera.transform.position - var_82_8.position).y, (manager.ui.mainCamera.transform.position - var_82_8.position).z)
				var_82_8.localEulerAngles.z = 0
				var_82_8.localEulerAngles.x = 0
				var_82_8.localEulerAngles = var_82_8.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_9 and arg_79_1.time_ < 0 + var_82_9 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(0, 100, 0)
				var_82_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_8.position).x, (manager.ui.mainCamera.transform.position - var_82_8.position).y, (manager.ui.mainCamera.transform.position - var_82_8.position).z)
				var_82_8.localEulerAngles.z = 0
				var_82_8.localEulerAngles.x = 0
				var_82_8.localEulerAngles = var_82_8.localEulerAngles
			end

			local var_82_10 = arg_79_1.actors_["1017ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_10) and arg_79_1.var_.characterEffect1017ui_story == nil then
				arg_79_1.var_.characterEffect1017ui_story = var_82_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_11 and not isNil(var_82_10) then
				if arg_79_1.var_.characterEffect1017ui_story and not isNil(var_82_10) then
					arg_79_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_11)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_11 and arg_79_1.time_ < 0 + var_82_11 + arg_82_0 and not isNil(var_82_10) and arg_79_1.var_.characterEffect1017ui_story then
				arg_79_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_82_12 = 0
			local var_82_13 = 0.3

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_14 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(414081019).content)

				arg_79_1.text_.text = var_82_14

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_16 = 12 <= 0 and var_82_13 or var_82_13 * (utf8.len(var_82_14) / 12)

				if (12 <= 0 and var_82_13 or var_82_13 * (utf8.len(var_82_14) / 12)) > 0 and var_82_13 < var_82_16 then
					arg_79_1.talkMaxDuration = var_82_16

					if var_82_16 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_12
					end
				end

				arg_79_1.text_.text = var_82_14
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_17 = math.max(var_82_13, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_17 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_12) / var_82_17

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_17 and arg_79_1.time_ < var_82_12 + var_82_17 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play414081020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 414081020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play414081021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1049ui_story = arg_83_1.actors_["1049ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1049ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1049ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1049ui_story"].transform.position).z)
				arg_83_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1049ui_story"].transform.localEulerAngles = arg_83_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1049ui_story"].transform.position).z)
				arg_83_1.actors_["1049ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1049ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1049ui_story"].transform.localEulerAngles = arg_83_1.actors_["1049ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1049ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1049ui_story == nil then
				arg_83_1.var_.characterEffect1049ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1049ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_2)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1049ui_story then
				arg_83_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1049ui_story.fillRatio = 0.5
			end

			local var_86_3 = 0
			local var_86_4 = 0.725

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_5 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(414081020).content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 29 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 29)

				if (29 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 29)) > 0 and var_86_4 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_3
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_4, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_3) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_8 and arg_83_1.time_ < var_86_3 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play414081021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 414081021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play414081022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1015ui_story = arg_87_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1015ui_story"].transform.position).z)
				arg_87_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1015ui_story"].transform.localEulerAngles = arg_87_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_87_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1015ui_story"].transform.position).z)
				arg_87_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1015ui_story"].transform.localEulerAngles = arg_87_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1015ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1015ui_story == nil then
				arg_87_1.var_.characterEffect1015ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1015ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1015ui_story then
				arg_87_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_4 = arg_87_1.actors_["1017ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1017ui_story = var_90_4.localPosition
			end

			local var_90_5 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 then
				var_90_4.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_87_1.time_ - 0) / var_90_5)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 then
				var_90_4.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_90_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_4.position).x, (manager.ui.mainCamera.transform.position - var_90_4.position).y, (manager.ui.mainCamera.transform.position - var_90_4.position).z)
				var_90_4.localEulerAngles.z = 0
				var_90_4.localEulerAngles.x = 0
				var_90_4.localEulerAngles = var_90_4.localEulerAngles
			end

			local var_90_6 = arg_87_1.actors_["1017ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1017ui_story == nil then
				arg_87_1.var_.characterEffect1017ui_story = var_90_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_7 = 0.034000001847744

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 and not isNil(var_90_6) then
				if arg_87_1.var_.characterEffect1017ui_story and not isNil(var_90_6) then
					arg_87_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_7)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 and not isNil(var_90_6) and arg_87_1.var_.characterEffect1017ui_story then
				arg_87_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_90_8 = 0
			local var_90_9 = 0.775

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(414081021).content)

				arg_87_1.text_.text = var_90_10

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_12 = 31 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_10) / 31)

				if (31 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_10) / 31)) > 0 and var_90_9 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_10
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_13 and arg_87_1.time_ < var_90_8 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play414081022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 414081022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play414081023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1015ui_story"]) and arg_91_1.var_.characterEffect1015ui_story == nil then
				arg_91_1.var_.characterEffect1015ui_story = arg_91_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1015ui_story"]) then
				if arg_91_1.var_.characterEffect1015ui_story and not isNil(arg_91_1.actors_["1015ui_story"]) then
					arg_91_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1015ui_story"]) and arg_91_1.var_.characterEffect1015ui_story then
				arg_91_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.225

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(414081022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 9 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 9)

				if (9 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 9)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play414081023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 414081023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play414081024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1015ui_story = arg_95_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).z)
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles = arg_95_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_95_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1015ui_story"].transform.position).z)
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1015ui_story"].transform.localEulerAngles = arg_95_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1015ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1015ui_story == nil then
				arg_95_1.var_.characterEffect1015ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1015ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1015ui_story then
				arg_95_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action6_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.425

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(414081023).content)

				arg_95_1.text_.text = var_98_6

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 17 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_6) / 17)

				if (17 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_6) / 17)) > 0 and var_98_5 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_6
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_9 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_9 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_9

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_9 and arg_95_1.time_ < var_98_4 + var_98_9 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play414081024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 414081024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
			arg_99_1.auto_ = false
		end

		function arg_99_1.playNext_(arg_101_0)
			arg_99_1.onStoryFinished_()
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1017ui_story = arg_99_1.actors_["1017ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1017ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1017ui_story"].transform.position).z)
				arg_99_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1017ui_story"].transform.localEulerAngles = arg_99_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1017ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_99_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1017ui_story"].transform.position).z)
				arg_99_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1017ui_story"].transform.localEulerAngles = arg_99_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1017ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1017ui_story == nil then
				arg_99_1.var_.characterEffect1017ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1017ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1017ui_story then
				arg_99_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_102_4 = arg_99_1.actors_["1015ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1015ui_story == nil then
				arg_99_1.var_.characterEffect1015ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_5 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 and not isNil(var_102_4) then
				if arg_99_1.var_.characterEffect1015ui_story and not isNil(var_102_4) then
					arg_99_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_5)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1015ui_story then
				arg_99_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_102_6 = 0
			local var_102_7 = 0.125

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(414081024).content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 5 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_8) / 5)

				if (5 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_8) / 5)) > 0 and var_102_7 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_11 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_11 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_11

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_11 and arg_99_1.time_ < var_102_6 + var_102_11 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H02"
	},
	voices = {}
}
